package
{
	import flash.geom.Rectangle;
	import flash.display.MovieClip;
	
	public class Prey extends Actor 
	{
		protected var speed:Number;
		protected var bonus:Number;
		protected var type:int;
		
		public function Prey(theGame:Game)
		{
			super(theGame);
			
			rect = new Rectangle();
			speed = 1.0;
			bonus = 1.0;
			type = C.PREY_TYPE_GAZELLE;
		}
		
		public function update()
		{
			
		}
		
		public function getBonus():Number
		{
			return bonus;
		}

		public function getType():int
		{
			return type;
		}
		
		public function setSpeed(newSpeed:Number)
		{
			speed = newSpeed;
		}
	}
}