package
{
	import flash.text.TextField;
	import flash.text.engine.TextBaseline;
	import flash.text.TextFormat;
	import flash.display.Shape;
	import flash.display.MovieClip;
	
	class HUD
	{
		public var game:Game;
		public var timeBar:TimeBar;
		public var preyTracker:PreyTracker;
		public var scoreText:TextField;
		private var scoreTextFormat:TextFormat;
		private var backgroundQuad:Shape;
		public static var parentClip:MovieClip;
		
		public function HUD(theGame:Game)
		{
			game = theGame;
			
			parentClip = new MovieClip();
			MainStage.sMainStage.addChild(parentClip);
			
			backgroundQuad = new Shape();
			backgroundQuad.graphics.beginFill(0);
			backgroundQuad.graphics.drawRect(0, 0, C.SCREEN_WIDTH, C.SCREEN_GAME_Y_OFFSET);
			backgroundQuad.graphics.endFill();
			parentClip.addChild(backgroundQuad);
			
			timeBar = new TimeBar(game);
			
			preyTracker = new PreyTracker();
			
			scoreText = new TextField();
			parentClip.addChild(scoreText);
			scoreText.x = C.SCORE_TEXTFIELD_X;
			scoreText.y = C.SCORE_TEXTFIELD_Y;
			scoreText.width = C.SCORE_TEXTFIELD_WIDTH;
			scoreTextFormat = new TextFormat();
			scoreTextFormat.size = C.SCORE_TEXTFIELD_SIZE;
			scoreTextFormat.color = C.SCORE_TEXTFIELD_COLOR;
			scoreText.defaultTextFormat = scoreTextFormat;
			scoreText.selectable = false;
			

			
			setScore(game.getScore());

		}
		
		public function update()
		{
			bringToTop();
			
			timeBar.update();
		}
		
		public function bringToTop()
		{
			if (parentClip.stage != null)
			{
				// Remove from stage.
				MainStage.sMainStage.removeChild(parentClip);
				// Add to stage to put on top
				MainStage.sMainStage.addChild(parentClip);
			}
		}
		
		public function setScore(theScore:int)
		{
			scoreText.text = "Score: " + theScore;
		}
	}
}