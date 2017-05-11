package
{
	
	public class MoveResult
	{
		public var collidedX:Boolean;
		public var collidedY:Boolean;
		public var collideeX:Actor;
		public var collideeY:Actor;
		
		public function MoveResult()
		{
			clear();
		}
		
		public function clear()
		{
			collidedX = false;
			collidedY = false;
			collideeX = null;
			collideeY = null;
		}
	}
}