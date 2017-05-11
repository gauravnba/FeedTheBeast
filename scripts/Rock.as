package
{
	
	class Rock extends Obstacle
	{
		
		public function Rock(theGame:Game)
		{
			super(theGame);
			
			type = C.OBSTACLE_TYPE_ROCK;
			
			rect.x = 0;
			rect.y = 0;
			rect.width = C.ROCK_WIDTH;
			rect.height = C.ROCK_HEIGHT;
			
			clip = new Assets.classRock2MC();
			MainStage.sMainStage.addChild(clip);
			clipOffsetX = C.ROCK_CLIP_OFFSET_X;
			clipOffsetY = C.ROCK_CLIP_OFFSET_Y;
			syncClipPosition();
		}
		
	}
}