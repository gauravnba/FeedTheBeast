package
{
	import flash.utils.Timer;
	import flash.geom.Rectangle;
	
	public class Gazelle extends Prey
	{
		
		private var behaviorState:int;
		private var time:Number;
		private var transTime:Number;
		private var velocityX:Number;
		private var velocityY:Number;
		
		public function Gazelle(theGame:Game)
		{
			super(theGame);
			
			type = C.PREY_TYPE_GAZELLE;
			
			rect.x = 0.0;
			rect.y = 0.0;
			rect.width = C.GAZELLE_WIDTH;
			rect.height = C.GAZELLE_HEIGHT;
			
			clip = new Assets.classGazelleMC();
			MainStage.sMainStage.addChild(clip);
			clip.width = C.GAZELLE_CLIP_WIDTH;
			clip.height = C.GAZELLE_CLIP_HEIGHT;
			
			clipOffsetX = C.GAZELLE_CLIP_OFFSET_X;
			clipOffsetY = C.GAZELLE_CLIP_OFFSET_Y;
			
			behaviorState = C.GAZELLE_STATE_IDLE;
			time = 0.0;
			transTime = Math.random() * (C.GAZELLE_MAX_IDLE_TIME - C.GAZELLE_MIN_IDLE_TIME) + C.GAZELLE_MIN_IDLE_TIME;
			velocityX = 0.0;
			velocityY = 0.0;
			
			// Randomize this gazelle's speed.
			speed = Math.random() * (C.GAZELLE_MAX_SPEED - C.GAZELLE_MIN_SPEED) + C.GAZELLE_MIN_SPEED;
			clip.gotoAndStop("Stop");
		}
		
		override public function update()
		{
			const deltaTime:Number = MainStage.getDeltaTime();
			time += deltaTime;
			
			if (behaviorState == C.GAZELLE_STATE_IDLE)
				updateIdle();
			else if (behaviorState == C.GAZELLE_STATE_RUN)
				updateRun();
				
			
			syncClipPosition();
		}
		
		private function updateIdle()
		{
			// Do nothing except to check if we should switch to the run state 
			if (time >= transTime)
			{
				switchBehaviorState(C.GAZELLE_STATE_RUN);
			}
		}
		
		private function updateRun()
		{
			if (time >= transTime)
			{
				switchBehaviorState(C.GAZELLE_STATE_IDLE);
			}
			else
			{
				//rect.x += velocityX * MainStage.getDeltaTime();
				//rect.y += velocityY * MainStage.getDeltaTime();
				var moveResult:MoveResult = new MoveResult();
				
				moveWithCollision(velocityX * MainStage.getDeltaTime(),
								  velocityY * MainStage.getDeltaTime(),
								  moveResult);
				
				syncClipPosition();
				
				if (rect.x  - clipOffsetX + clip.width < 0)
				{
					rect.x = C.SCREEN_WIDTH + clipOffsetX;
				}
				else if (rect.x  - clipOffsetX > C.SCREEN_WIDTH)
				{
					rect.x = 0 - clip.width + clipOffsetX;
				}
				
				if (rect.y - clipOffsetY + clip.height < C.SCREEN_GAME_Y_OFFSET)
				{
					rect.y = C.SCREEN_HEIGHT + clipOffsetY;
				}
				else if (rect.y - clipOffsetY > C.SCREEN_HEIGHT)
				{
					rect.y = C.SCREEN_GAME_Y_OFFSET - clip.height + clipOffsetY;
				}
				
				syncClipPosition();
			}
		}
		
		private function switchBehaviorState(state:int)
		{
			time = 0.0;
			behaviorState = state;
			
			if (state == C.GAZELLE_STATE_IDLE)
			{
				transTime = Math.random() * (C.GAZELLE_MAX_IDLE_TIME - C.GAZELLE_MIN_IDLE_TIME) + C.GAZELLE_MIN_IDLE_TIME;
				clip.gotoAndStop("Stop");
			}
			else if (state == C.GAZELLE_STATE_RUN)
			{
				transTime = Math.random() * (C.GAZELLE_MAX_RUN_TIME - C.GAZELLE_MIN_RUN_TIME) + C.GAZELLE_MIN_RUN_TIME;
				
				var dist:Number = getDistanceToPlayer();
				var pXVel = game.player.getXVelocity();
				var pYVel = game.player.getYVelocity();
				
				if (dist < C.GAZELLE_FLEE_RADIUS)
				{
					var dx = rect.x - game.player.rect.x;
					var dy = rect.y - game.player.rect.y;
					
					velocityX = speed * (dx/dist);
					velocityY = speed * (dy/dist);
				}
				else
				{
					// Randomize new velocity
					var angle:Number = Math.random() * (2 * Math.PI);
					velocityX = speed * Math.cos(angle);
					velocityY = speed * Math.sin(angle);
				}
				
				setFlip(velocityX < 0, false);
				clip.gotoAndPlay("Run");
			}
		}
		
		private function getDistanceToPlayer():Number
		{
			var pRect:Rectangle = game.player.rect;
			var px:Number = pRect.x + pRect.width/2.0;
			var py:Number = pRect.y + pRect.height/2.0;
			
			var gx:Number = rect.x + rect.width/2.0;
			var gy:Number = rect.y + rect.height/2.0;
			
			var result:Number = (px - gx)*(px - gx) + (py - gy)*(py - gy);
			return Math.sqrt(result);
			
		}
	}
}