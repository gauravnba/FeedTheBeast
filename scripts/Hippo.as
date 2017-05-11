package 
{
	
	public class Hippo extends Prey 
	{
		
		private var velocityX:Number;
		private var velocityY:Number;
		private var water;
		private var yTime;
		
		public function Hippo(theGame:Game)
		{
			super(theGame);
			
			type = C.PREY_TYPE_HIPPO;
			
			rect.x = 0.0;
			rect.y = 0.0;
			rect.width = C.HIPPO_WIDTH;
			rect.height = C.HIPPO_HEIGHT;
			
			clip = new Assets.classHippoMC();
			MainStage.sMainStage.addChild(clip);
			clip.width = C.HIPPO_CLIP_WIDTH;
			clip.height = C.HIPPO_CLIP_HEIGHT;
			
			clipOffsetX = C.HIPPO_CLIP_OFFSET_X;
			clipOffsetY = C.HIPPO_CLIP_OFFSET_Y;
			
			speed = Math.random() * (C.HIPPO_MAX_SPEED - C.HIPPO_MIN_SPEED) + C.HIPPO_MIN_SPEED;
			velocityX = speed;
			velocityY = speed;
			
			water = null;
			yTime = 0.0;
		}
		
		override public function update()
		{
			rect.x += velocityX * MainStage.getDeltaTime();
			
			if (yTime >= 0.0)
			{
				yTime -= MainStage.getDeltaTime();
			}
			
			if (velocityX >= 0.1)
			{
				if (rect.right > water.rect.right)
				{
					velocityX *= -1;
					yTime = C.HIPPO_Y_TIME;
					setFlip(true, false);
				}
			}
			else if (velocityX <= -0.1)
			{
				if (rect.left < water.rect.left)
				{
					velocityX *= -1;
					yTime = C.HIPPO_Y_TIME;
					setFlip(false, false);
				}
			}
			
			if (yTime > 0.0)
			{
				rect.y += velocityY * MainStage.getDeltaTime();
				
				if (velocityY >= 0.1)
				{
					if (rect.bottom > water.rect.bottom)
					{
						velocityY *= -1;
					}
				}
				else if (velocityY <= -0.1)
				{
					if (rect.top < water.rect.top)
					{
						velocityY *= -1;
					}
				}
			}	
			
			syncClipPosition();
		}
		
		public function setWater(water:Water)
		{
			this.water = water;
		}
	}
}