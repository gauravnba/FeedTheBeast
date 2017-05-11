
package
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.PressAndTapGestureEvent;
	
	
	public class Player extends Actor 
	{
		protected var velocityX:Number;
		protected var velocityY:Number;
		
		protected var accelerationX:Number;
		protected var accelerationY:Number;
		
		protected var maxVelocity:Number;
		protected var acceleration:Number;
		protected var drag:Number;
		protected var rollFlag:Boolean = false;
		public var playerRolling:Boolean = false;
		
		protected var maxRollVelocity:Number;
		protected var flipX:Boolean = false;
		
		public var inWater:Boolean = false;
		
		protected var form:int;		
		protected var animState:int; 
		
		protected var moveResult:MoveResult;
		
		protected var runClip:MovieClip;
		protected var rollClip:MovieClip;
		
		
		public var obstacle:Obstacle = new Obstacle(game);
		
		public function Player(theGame:Game)
		{
			super (theGame);
			rect.x = 0.0;
			rect.y = 0.0;
			rect.width = C.PLAYER_WIDTH;
			rect.height = C.PLAYER_HEIGHT;
			
			clip = new Assets.classLion1MC();
			runClip = null;
			rollClip = null
			
			MainStage.sMainStage.addChild(clip);
			clip.width = C.PLAYER_CLIP_WIDTH;
			clip.height = C.PLAYER_CLIP_HEIGHT;
			clipOffsetX = C.PLAYER_CLIP_OFFSET_X;
			clipOffsetY = C.PLAYER_CLIP_OFFSET_Y;
			
			velocityX = 0.0;
			velocityY = 0.0;
			accelerationX = 0.0;
			accelerationY = 0.0;
			
			animState = C.PLAYER_ANIM_STATE_STOP;
			
			maxVelocity = C.PLAYER_LEVEL_1_MAX_VELOCITY;
			acceleration = C.PLAYER_LEVEL_1_ACCELERATION;
			drag = C.PLAYER_LEVEL_1_DRAG;
			
			moveResult = new MoveResult();
		}
	
		public function setStats(level:int)
		{
			animState = C.PLAYER_ANIM_STATE_STOP;
			
			// Remove lion from stage if on it
			if (clip.stage != null)
			{
				MainStage.sMainStage.removeChild(clip);
				clip = null;
			}
			
			// Reset movement vars 
			velocityX = 0.0;
			velocityY = 0.0;
			accelerationX = 0.0;
			accelerationY = 0.0;
			
			switch(level)
			{
			case C.LEVEL_1:
				maxVelocity = C.PLAYER_LEVEL_1_MAX_VELOCITY;
				acceleration = C.PLAYER_LEVEL_1_ACCELERATION;
				drag = C.PLAYER_LEVEL_1_DRAG;
				clip = new Assets.classLion1MC();
				runClip = clip;
				rollClip = null;
				rollFlag = false;
				break;
			case C.LEVEL_2:
				maxVelocity = C.PLAYER_LEVEL_2_MAX_VELOCITY;
				acceleration = C.PLAYER_LEVEL_2_ACCELERATION;
				drag = C.PLAYER_LEVEL_2_DRAG;
				clip = new Assets.classLion2MC();
				runClip = clip;
				rollClip = null;
				rollFlag = false;
				break;
			case C.LEVEL_3:
				maxVelocity = C.PLAYER_LEVEL_3_MAX_VELOCITY;
				acceleration = C.PLAYER_LEVEL_3_ACCELERATION;
				rollFlag = true;
				maxRollVelocity = C.PLAYER_LEVEL_3_ROLLING_VELOCITY;
				drag = C.PLAYER_LEVEL_3_DRAG;
				clip = new Assets.classLion3MC();
				runClip = clip;
				rollClip = new Assets.classLion3RollMC();
				break;
			case C.LEVEL_4:
				maxVelocity = C.PLAYER_LEVEL_4_MAX_VELOCITY;
				acceleration = C.PLAYER_LEVEL_4_ACCELERATION;
				rollFlag = true;
				maxRollVelocity = C.PLAYER_LEVEL_4_ROLLING_VELOCITY;
				drag = C.PLAYER_LEVEL_4_DRAG;
				clip = new Assets.classLion4MC();
				runClip = clip;
				rollClip = new Assets.classLion4RollMC();
				break;
			case C.LEVEL_5:
				maxVelocity = C.PLAYER_LEVEL_5_MAX_VELOCITY;
				acceleration = C.PLAYER_LEVEL_5_ACCELERATION;
				drag = C.PLAYER_LEVEL_5_DRAG;
				clip = new Assets.classLion5MC();
				rollFlag = false;
				break;
			default:
				break;
			}
			
			if (clip != null)
			{
				// Add the lion clip back on to the stage.
				MainStage.sMainStage.addChild(clip);
				clip.width = C.PLAYER_CLIP_WIDTH;
				clip.height = C.PLAYER_CLIP_HEIGHT;
				clipOffsetX = C.PLAYER_CLIP_OFFSET_X;
				clipOffsetY = C.PLAYER_CLIP_OFFSET_Y;
				setFlip(false, false);
				clip.gotoAndStop("Stop");
			}
		}
		
		public function update()
		{
			updateMovement();
			checkCollisions();
			updateAnimation();
			setFlip(flipX, false);
			syncClipPosition();
		}
		
		protected function updateAnimation()
		{
			if (playerRolling)
			{
				
			}
			else if (animState == C.PLAYER_ANIM_STATE_STOP)
			{
				if (Math.abs(velocityX) > 0.3 || 
					Math.abs(velocityY) > 0.3)
				{
					animState = C.PLAYER_ANIM_STATE_RUN;
					clip.gotoAndPlay("Run");
				}
			}
			else if (animState == C.PLAYER_ANIM_STATE_RUN)
			{
				if (Math.abs(velocityX) < 0.3 && 
					Math.abs(velocityY) < 0.3)
				{
					animState = C.PLAYER_ANIM_STATE_STOP;
					clip.gotoAndStop("Stop");
				}
			}
		}
		
		protected function updateMovement()
		{			
			if(inWater)
			{
				if (MainStage.input.isKeyDown(Keyboard.RIGHT))
				{
					accelerationX = acceleration;
					flipX = false;
				}
					
				else if (MainStage.input.isKeyDown(Keyboard.LEFT))
				{
					accelerationX = -acceleration;
					flipX = true;
				}
				else
					accelerationX = 0.0;
				
				if (MainStage.input.isKeyDown(Keyboard.DOWN))
					accelerationY = acceleration;
				else if (MainStage.input.isKeyDown(Keyboard.UP))
					accelerationY = -acceleration;
				else
					accelerationY = 0.0;
				
				// Update Velocites based on the determined acceleration
				if (accelerationX == 0.0 &&
					velocityX     != 0.0)
				{
					// apply drag
					if (velocityX > 0)
						velocityX -= drag;
					else 
						velocityX += drag;
					
					// zeroize velocity if almost zero
					if (Math.abs(velocityX) < 0.1)
						velocityX = 0.0;
				}
				else
				{
					// accelerate the player
					velocityX += accelerationX;
				}
				
				if (accelerationY == 0.0 &&
					velocityY     != 0.0)
				{
					// apply drag
					if (velocityY > 0)
						velocityY -= drag;
					else 
						velocityY += drag;
					
					// zeroize velocity if almost zero
					if (Math.abs(velocityY) < 0.1)
						velocityY = 0.0;
				}
				else
				{
					velocityY += accelerationY;
				}
				
				// Clamp velocity
				if (velocityX > 3.0)
					velocityX = 3.0;
				else if (velocityX < -3.0)
					velocityX = -3.0;
	
				if (velocityY > 3.0)
					velocityY = 3.0;
				else if (velocityY < -3.0)
					velocityY = -3.0;
				
				moveResult.clear();
				moveWithCollision(velocityX, velocityY, moveResult);
				
				return;
				
				//if(MainStage.input.isKeyDown(Keyboard.RIGHT) && MainStage.input.isKeyJustUp(Keyboard.SPACE))
				//{
				//	velocityX = 3.0;
				//}
				//
				//if(MainStage.input.isKeyDown(Keyboard.LEFT) && MainStage.input.isKeyJustUp(Keyboard.SPACE))
				//{
				//	velocityX = -3.0;
				//}
				//
				//if(MainStage.input.isKeyDown(Keyboard.DOWN) && MainStage.input.isKeyJustUp(Keyboard.SPACE))
				//{
				//	velocityY = 3.0;
				//}
				//
				//if(MainStage.input.isKeyDown(Keyboard.UP) && MainStage.input.isKeyJustUp(Keyboard.SPACE))
				//{
				//	velocityY = -3.0;
				//}
				//
				//if (velocityX != 0.0)
				//{
				//	// apply drag
				//	if (velocityX > 0)
				//		velocityX -= drag;
				//	else
				//		velocityX += drag;
				//
				//	// zeroize velocity if almost zero
				//	if (Math.abs(velocityX) < 0.1)
				//		velocityX = 0.0;
				//}
				//
				//if (velocityY != 0.0)
				//{
				//	// apply drag
				//	if (velocityY > 0)
				//		velocityY -= drag;
				//	else
				//		velocityY += drag;
				//
				//	// zeroize velocity if almost zero
				//	if (Math.abs(velocityY) < 0.1)
				//		velocityY = 0.0;
				//}
			}
			
			// Determine the player's acceleration
			// depending on what keys are down.
			if (MainStage.input.isKeyDown(Keyboard.RIGHT))
			{
				accelerationX = acceleration;
				flipX = false;
			}
				

			else if (MainStage.input.isKeyDown(Keyboard.LEFT))
			{
				accelerationX = -acceleration;
				flipX = true;
			}
			else
				accelerationX = 0.0;
			
			if (MainStage.input.isKeyDown(Keyboard.DOWN))
				accelerationY = acceleration;
			else if (MainStage.input.isKeyDown(Keyboard.UP))
				accelerationY = -acceleration;
			else
				accelerationY = 0.0;
			
			// Update Velocites based on the determined acceleration
			if (accelerationX == 0.0 &&
				velocityX     != 0.0)
			{
				// apply drag
				if (velocityX > 0)
					velocityX -= drag;
				else 
					velocityX += drag;
				
				// zeroize velocity if almost zero
				if (Math.abs(velocityX) < 0.1)
					velocityX = 0.0;
			}
			else
			{
				// accelerate the player
				velocityX += accelerationX;
			}
			
			if (accelerationY == 0.0 &&
				velocityY     != 0.0)
			{
				// apply drag
				if (velocityY > 0)
					velocityY -= drag;
				else 
					velocityY += drag;
				
				// zeroize velocity if almost zero
				if (Math.abs(velocityY) < 0.1)
					velocityY = 0.0;
			}
			else
			{
				velocityY += accelerationY;
			}
			
			// Clamp velocity
			
			// Added functionality to roll at levels 3 and 4
			if(MainStage.input.isKeyDown(Keyboard.SPACE) && rollFlag)
			{
				
				if (!playerRolling)
				{
					rollClip.x = clip.x;
					rollClip.y = clip.y;
					rollClip.width = clip.width;
					rollClip.height = clip.height;
					
					MainStage.sMainStage.removeChild(clip);
					clip = rollClip;
					MainStage.sMainStage.addChild(clip);
					MainStage.sMainStage.setChildIndex(clip, 1);
				}
				
				playerRolling = true;
				
				if (velocityX > maxRollVelocity)
					velocityX = maxRollVelocity;
				else if (velocityX < -maxRollVelocity)
					velocityX = -maxRollVelocity;
					
				if (velocityY < -maxRollVelocity)
					velocityY = -maxRollVelocity;
				else if (velocityY > maxRollVelocity)
					velocityY = maxRollVelocity;
			}
			else
			{
				if (playerRolling)
				{
					runClip.x = clip.x;
					runClip.y = clip.y;
					runClip.width = clip.width;
					runClip.height = clip.height;
					
					MainStage.sMainStage.removeChild(clip);
					clip = runClip;
					MainStage.sMainStage.addChild(clip);
					MainStage.sMainStage.setChildIndex(clip, 1);
					
					animState = C.PLAYER_ANIM_STATE_STOP;
				}
				if (velocityX > maxVelocity)
					velocityX = maxVelocity;
				else if (velocityX < -maxVelocity)
					velocityX = -maxVelocity;

				if (velocityY > maxVelocity)
					velocityY = maxVelocity;
				else if (velocityY < -maxVelocity)
					velocityY = -maxVelocity;
			}
			
			if (MainStage.input.isKeyUp(Keyboard.SPACE) && rollFlag)
				playerRolling = false;
			
			// Add velocity to movieclip (and possible the player's Rectangle)
			moveResult.clear();
			moveWithCollision(velocityX, velocityY, moveResult);
			
			if (playerRolling)
			{
				// Bounce player away from collision
				if (moveResult.collidedX)
					velocityX *= -1;
				if (moveResult.collidedY)
					velocityY *= -1;
			}
		}
		
		protected function flipIfLeft()
		{
			if(flipX)
			{
				clip.scaleX = -1;
				clip.x += 456;
			}
		}
		
		public function checkCollisions()
		{
			var i:int = 0;
			
			// Check collision with screen boundaries
			if (rect.x < 0)
			{
				rect.x = 0;
				velocityX *= -1;
			}
			else if (rect.x > C.SCREEN_WIDTH - C.PLAYER_WIDTH)
			{
				rect.x = C.SCREEN_WIDTH - C.PLAYER_WIDTH;
				velocityX *= -1;
			}
			if (rect.y < C.SCREEN_GAME_Y_OFFSET)
			{
				rect.y = C.SCREEN_GAME_Y_OFFSET;
				velocityY *= -1;
			}
			else if (rect.y > C.SCREEN_HEIGHT - C.PLAYER_HEIGHT)
			{
				rect.y = C.SCREEN_HEIGHT - C.PLAYER_HEIGHT;
				velocityY *= -1;
			}
			
			// Check if player is overlapping a gazelle
			var prey:Vector.<Prey> = game.prey;
			
			for (i = 0; i < prey.length; i++)
			{
				if (this.overlaps(prey[i]))
				{
					// add to score
					Assets.gulpSound.play();
					game.addToScore(prey[i].getBonus());
					game.addToPreyHunted(1);
					game.hud.preyTracker.onEatPrey(prey[i].getType());
					
					prey[i].destroy();
					
					if (prey.length > 1)
					{
						// remove the prey from the vector by moving the last prey 
						// to this prey's index and popping. It's faster than splice
						// and we can do it because we don't care about the order of this vector.
						prey[i] = prey[prey.length - 1];
						prey.pop();
					}
					else
					{
						// Only one element so pop it
						prey.pop();
					}
					
					// decrement the counter so we don't skip a prey
					i--;
				}
			}			
		}
		
		public function getXVelocity():Number
		{
			return velocityX;
		}
		
		public function getYVelocity():Number
		{
			return velocityY;
		}
	}
}
