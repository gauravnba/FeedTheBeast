package 
{
	
	public class Bird extends Prey
	{
		public static const BIRD_DIR_LEFT  = 0;
		public static const BIRD_DIR_RIGHT = 1;
		
		private var direction:int;
		
		public function Bird(theGame:Game)
		{
			super(theGame);
			
			type = C.PREY_TYPE_BIRD;
			
			rect.x = 0.0;
			rect.y = 0.0;
			rect.width = C.BIRD_WIDTH;
			rect.height = C.BIRD_HEIGHT;
			
			clip = new Assets.classBirdMC();
			MainStage.sMainStage.addChild(clip);
			clip.width = C.BIRD_CLIP_WIDTH;
			clip.height = C.BIRD_CLIP_HEIGHT;
			
			clipOffsetX = C.BIRD_CLIP_OFFSET_X;
			clipOffsetY = C.BIRD_CLIP_OFFSET_Y;
			
			bonus = 3.0;

			initializeStats();
		}
		
		public function initializeStats()
		{
			direction = int(Math.random() * 2);
			speed = Math.random() * (C.BIRD_MAX_SPEED - C.BIRD_MIN_SPEED) + C.BIRD_MIN_SPEED;
			rect.y = Math.random() * C.SCREEN_GAME_HEIGHT + C.SCREEN_GAME_Y_OFFSET;
			
			if (direction == BIRD_DIR_LEFT)
			{
				rect.x = C.SCREEN_WIDTH + C.BIRD_CLIP_OFFSET_X;
				setFlip(true, false);
				speed *= -1;	
			}
			else
			{
				rect.x = 0 - clip.width + C.BIRD_CLIP_OFFSET_X;
			}
			
			syncClipPosition();
		}
		
		override public function update()
		{
			rect.x += speed * MainStage.getDeltaTime();
			syncClipPosition();
			
			if (direction == BIRD_DIR_LEFT)
			{
				if (rect.x < 0 - rect.width)
				{
					// Offscreen, removeFromGame
					removeFromGame();
				}
			}
			else
			{
				if (clip.x < 0 - clip.width)
				{
					// Offscreen, removeFromGame
					removeFromGame();
				}
			}
		}
		
		public function removeFromGame()
		{
			// First, remove graphics from stage
			MainStage.sMainStage.removeChild(clip);
			
			// Secondly remove this object from prey list
			for (var i:int = 0; i < game.prey.length; i++)
			{
				if (game.prey[i] == this)
				{
					// So I think this is fine... nothing else
					// will be referencing this object, so it should
					// be garbage collected.
					game.prey.removeAt(i);
					break;
				}
			}
		}
	}
}