//code for version 1.01

package
{
	import flash.geom.Rectangle;
	import flash.display.MovieClip;

	public class Obstacle extends Actor
	{
		protected var type:int;

		public function Obstacle(theGame:Game)
		{
			super(theGame);
			
			type = C.OBSTACLE_TYPE_ROCK;
		}
		
		// Check collision with obstacle and return Boolean		
		public function getObstacleRect():Rectangle
		{
			return rect;
		}
		
		//Check for type of obstacle and destroy it.
		public function destroyObstacle()
		{
			
		}
		
		public function getType()
		{
			return type;
		}
	}
}