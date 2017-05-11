
package 
{
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.display3D.IndexBuffer3D;
	
	class TimeBar
	{
		public var game:Game;
		private var maxTime:Number;
		private var time:Number;
		private var rect:Rectangle;
		private var shape:Shape;
		private var fillColor:int;
		private var strokeColor:int;
		private var strokeSize:int;
		
		public function TimeBar(theGame:Game)
		{
			game = theGame;
			shape = new Shape();
			HUD.parentClip.addChild(shape);
			
			rect = new Rectangle();
			
			time = C.LEVEL_1_TIME;
			maxTime = C.LEVEL_1_TIME;
			fillColor = C.TIME_BAR_FILL_COLOR;
			strokeColor = C.TIME_BAR_STROKE_COLOR;
			strokeSize = C.TIME_BAR_STROKE_SIZE;
			
			// init default rect.
			rect.x = C.TIME_BAR_X;
			rect.y = C.TIME_BAR_Y;
			rect.width = C.TIME_BAR_WIDTH;
			rect.height = C.TIME_BAR_HEIGHT;
		}
		
		public function update()
		{
			time -= MainStage.getDeltaTime();
			
			if (time < 0.0)
			{
				time = 0.0;
			}
			
			// Update graphical component (shape)
			shape.graphics.clear();
			shape.graphics.lineStyle(NaN);
			shape.graphics.beginFill(0x0000000);
			shape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			shape.graphics.endFill();
			shape.graphics.beginFill(fillColor);
			shape.graphics.drawRect(rect.x, rect.y, rect.width * (time/maxTime), rect.height);
			shape.graphics.endFill();
			shape.graphics.lineStyle(strokeSize, strokeColor);
			shape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
		}
		
		public function SetDimensions(x:int, 
									  y:int, 
									  width:int,
									  height:int)
		{
			rect.x = x;
			rect.y = y;
			rect.width = width;
			rect.height = height;
		}
		
		public function SetFillColor(color:int)
		{
			fillColor = color;
		}
		
		public function SetStrokeColor(color:int)
		{
			strokeColor = color;
		}
		
		public function SetStrokeSize(size:int)
		{
			strokeSize = size;
		}
		
		public function addTime(extraTime:Number)
		{
			time += extraTime;
			
			if (time > maxTime)
			{
				time = maxTime;
			}
		}
		
		public function getTime()
		{
			return time;
		}
		
		public function setMaxTime(newMaxTime:Number)
		{
			maxTime = newMaxTime;
		}
		
		public function reset()
		{
			time = maxTime;
		}
		
		public function getRatio():Number
		{
			return (maxTime - time)/maxTime;
		}

	}
	
	
}