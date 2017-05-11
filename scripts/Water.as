package
{
	public class Water extends Obstacle
	{
		public function Water(game:Game)
		{
			super(game);
			
			type = C.OBSTACLE_TYPE_WATER;
			
			/*rect.x = -100;
			rect.y = -100;*/
			rect.width = C.WATER_WIDTH;
			rect.height = C.WATER_HEIGHT;
			
			clip = new Assets.classWaterSampleMC();
			clip.alpha = 0.5;
			MainStage.sMainStage.addChild(clip);
			clipOffsetX = C.WATER_CLIP_X_OFFSET;
			clipOffsetY = C.WATER_CLIP_Y_OFFSET;
			syncClipPosition();
		}		
	}
}