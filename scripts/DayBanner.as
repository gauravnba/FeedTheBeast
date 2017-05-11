package
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	public class DayBanner
	{
		public static const TEXT_OFFSET_X:Number = 40.0;
		public static const TEXT_OFFSET_Y:Number = -20.0;
		public static const TEXT_WIDTH:Number = 400.0;
		public static const TEXT_HEIGHT:Number = 300.0;
		
		public var clip:MovieClip;
		public var text:TextField;
		
		public function DayBanner(day:int)
		{
			clip = new Assets.classDayBannerMC();
			MainStage.sMainStage.addChild(clip);
			clip.x = C.DAY_BANNER_X;
			clip.y = C.DAY_BANNER_Y;
			clip.width = C.DAY_BANNER_WIDTH;
			clip.height = C.DAY_BANNER_HEIGHT;
			
			text = new TextField();
			text.x = C.SCREEN_WIDTH/2.0 - TEXT_OFFSET_X;
			text.y = C.DAY_BANNER_Y - TEXT_OFFSET_Y;
			text.width = TEXT_WIDTH;
			text.height = TEXT_HEIGHT;
			
			var tf:TextFormat = new TextFormat();
			tf.size = 48;
			tf.color = C.SCORE_TEXTFIELD_COLOR;
			text.defaultTextFormat = tf;
			text.selectable = false;

			text.text = "Day " + (day + 1);
			
			MainStage.sMainStage.addChild(text);
		}
		
		public function update(time:Number)
		{
			if (time > C.LEVEL_WAIT_TIME/2.0)
			{
				clip.alpha = 1.0 - (time - C.LEVEL_WAIT_TIME/2.0)/(C.LEVEL_WAIT_TIME/2.0);
				text.alpha = clip.alpha;
			}
			else
			{
				clip.alpha = 1.0;
				text.alpha = 1.0;
			}
		}
		
		public function destroy()
		{
			MainStage.sMainStage.removeChild(text);
			MainStage.sMainStage.removeChild(clip);
		}
		
	}
}