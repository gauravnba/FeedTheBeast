package 
{
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	class Actor
	{
		protected var game:Game;
		
		public var rect:Rectangle;
		public var clip:MovieClip;
		protected var debugShape:Shape;
		
		protected var clipOffsetX:int;
		protected var clipOffsetY:int;
		
		protected var flippedX:Boolean;
		protected var flippedY:Boolean;
		
		protected var drawDebugShape:Boolean;
		
		public function Actor(theGame:Game)
		{
			game = theGame;
			
			rect = new Rectangle(0,0,100, 100);
			clip = null;
			debugShape = new Shape();
			
			clipOffsetX = 0;
			clipOffsetY = 0;
			
			drawDebugShape = false;
		}
		
		public function setPosition(x:Number, y:Number)
		{
			rect.x = x;
			rect.y = y;
			syncClipPosition();
		}
		
		public function syncClipPosition()
		{
			if (clip != null)
			{
				// This actor has an attached movieclip, so we want
				// to update it's x/y position to match this actor's rect.
				clip.x = rect.x - clipOffsetX;
				clip.y = rect.y - clipOffsetY;
				
				if (flippedX)
					clip.x += clip.width;
				if (flippedY)
					clip.y += clip.height;
			}
			
			if (drawDebugShape == true)
			{
				debugShape.graphics.clear();
				debugShape.graphics.lineStyle(C.DEBUG_ACTOR_SHAPE_STROKE_SIZE, C.DEBUG_ACTOR_SHAPE_COLOR);
				debugShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			}
		}
		
		public function overlaps(other:Actor):Boolean
		{
			return rect.intersects(other.rect);
		}
		
		public function setFlip(xFlip:Boolean, yFlip:Boolean)
		{
			flippedX = xFlip;
			flippedY = yFlip;
			
			if (flippedX)
				clip.scaleX = -Math.abs(clip.scaleX);
			else
				clip.scaleX = Math.abs(clip.scaleX);
			
			if (flippedY)
				clip.scaleY = -Math.abs(clip.scaleY);
			else
				clip.scaleY = Math.abs(clip.scaleY);
			
			syncClipPosition();
		}
		
		public function destroy()
		{
			if (clip       != null &&
				clip.stage != null)
			{
				MainStage.sMainStage.removeChild(clip);
				clip = null;
			}
			
			
			if (debugShape       != null &&
				debugShape.stage != null)
			{
				MainStage.sMainStage.removeChild(debugShape);
				debugShape = null; 
			}
		}
		
		public function showDebugShape()
		{
			MainStage.sMainStage.addChild(debugShape);
			debugShape.graphics.lineStyle(C.DEBUG_ACTOR_SHAPE_STROKE_SIZE, C.DEBUG_ACTOR_SHAPE_COLOR);
			debugShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			
			drawDebugShape = true;
		}
		
		public function hideDebugShape()
		{
			if (debugShape.stage != null)
			{
				MainStage.sMainStage.removeChild(debugShape);
				debugShape.graphics.clear();
				
				drawDebugShape = false;
			}
		}
		
		public function moveWithCollision(velocityX:Number, velocityY:Number, result:MoveResult):void
		{			
			if (game == null)
				return;
			
			var obstacles:Vector.<Obstacle> = game.obstacles;
			var tree:Tree = null;
			
			// Move in x direction first 
			rect.x += velocityX;
			
			for (var i:int = 0; i < obstacles.length; i++)
			{					
				if (this.overlaps(obstacles[i]))
				{
					if (obstacles[i] is Rock && this is Player && isRolling())
						Assets.rockSound.play();
						
					if(obstacles[i] is Tree && this is Player && isRolling())
					{
						tree = obstacles[i] as Tree;
						
						tree.collisionCounter++;
						
						// Play wood sound
						Assets.woodSound.play();
						if(tree.collisionCounter > 1)
						{
							obstacles[i].destroy();
							obstacles.removeAt(i);
							Assets.woodBreaking.play();
							break;
						}
					}
					//new code added for Water.
					else if(obstacles[i] is Water && this is Player)
					{
						setPlayerInWater(true);
						break;
					}
					
					result.collidedX = true;
					
					if (velocityX >= 0)
					{
						rect.x = obstacles[i].rect.x - rect.width;
					}
					else
					{
						rect.x = obstacles[i].rect.x + obstacles[i].rect.width;
					}
					result.collideeX = obstacles[i];
				}
				
				else if(this is Player)
				{
					setPlayerInWater(false);
				}
			}
			
			// Move in y direction second
			rect.y += velocityY;			
			
			for (i = 0; i < obstacles.length; i++)
			{
				if (this.overlaps(obstacles[i]))
				{
					//IF hitting tree from Y direction.
					if(obstacles[i] is Tree && this is Player && isRolling())
					{
						tree = obstacles[i] as Tree;
						
						tree.collisionCounter++;
						Assets.woodSound.play();
						if(tree.collisionCounter > 1)
						{
							obstacles[i].destroy();
							obstacles.removeAt(i);
							break;
						}
					}
					
					else if(obstacles[i] is Water && this is Player)
					{
						setPlayerInWater(true);
						break;
					}
					
					else if(this is Player)
					{
						setPlayerInWater(false);
					}
					
					result.collidedY = true;
					
					if (velocityY >= 0)
					{
						rect.y = obstacles[i].rect.y - rect.height;
					}
					else
					{
						rect.y = obstacles[i].rect.y + obstacles[i].rect.height;
					}
					result.collideeY = obstacles[i];
				}
			}
		}
		
		public static function destroyActors(vec:Vector.<Actor>)
		{
			if (vec == null)
				return;
			
			for (var i:int = 0; i < vec.length; i++)
			{
				vec[i].destroy();
			}
		}
		
		protected function isRolling():Boolean
		{
			var player:Player = this as Player;
			
			return player.playerRolling;
		}
		
		protected function setPlayerInWater(isInWater:Boolean)
		{
			var player:Player = this as Player;
			
			player.inWater = isInWater;
		}
	}
}