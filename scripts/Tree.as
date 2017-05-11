package
{
	import flash.events.GeolocationEvent;

	public class Tree extends Obstacle
	{
		public var collisionCounter:int = 0;
		
		public function Tree(theGame)
		{
			super(theGame);
			
			type = C.OBSTACLE_TYPE_TREE;
			
			rect.x = 0;
			rect.y = 0;
			rect.width = C.TREE_RECT_WIDTH;
			rect.height = C.TREE_RECT_HEIGHT;
			
			clip = new Assets.classTreeMC();
			clip.width = C.TREE_WIDTH;
			clip.height = C.TREE_HEIGHT;
			MainStage.sMainStage.addChild(clip);
			clipOffsetX = C.TREE_CLIP_OFFSET_X;
			clipOffsetY = C.TREE_CLIP_OFFSET_Y;
			syncClipPosition();
		}
		
		public function destroyTree()
		{
			
		}
	}
}