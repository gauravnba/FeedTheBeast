package
{
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.system.fscommand;
	import flash.system.System;
	
	
	class Menu
	{
		public var startButton:MovieClip;
		public var quitButton:MovieClip;
		public var titleClip:MovieClip;
		public var bgClip:MovieClip;

		public var selectedClip:MovieClip;
		
		public function Menu()
		{
			// Instantiate the movie clips from loaded classes
			startButton = new Assets.classMenuStartMC();
			quitButton = new Assets.classMenuQuitMC();
			titleClip = new Assets.classMenuTitleMC();
			bgClip = new Assets.classMenuBGMC();
			
			// Add to the stage
			MainStage.sMainStage.addChild(bgClip);
			MainStage.sMainStage.addChild(startButton);
			MainStage.sMainStage.addChild(quitButton);
			MainStage.sMainStage.addChild(titleClip);
			
			
			// Position Menu Items
			startButton.x = C.MENU_START_X;
			startButton.y = C.MENU_START_Y;
			
			quitButton.x = C.MENU_QUIT_X;
			quitButton.y = C.MENU_QUIT_Y;
			
			titleClip.x = C.MENU_TITLE_X;
			titleClip.y = C.MENU_TITLE_Y;
			
			bgClip.x = C.MENU_BG_X;
			bgClip.y = C.MENU_BG_Y;
		}
		
		public function update()
		{
			if (MainStage.input.isMouseJustDown() &&
				startButton.hitTestPoint(MainStage.input.getMouseX(),
										 MainStage.input.getMouseY()))
			{
				MainStage.sMainStage.switchState(C.MAIN_STATE_GAME);
				MainStage.sMainStage.removeChild(startButton);
				MainStage.sMainStage.removeChild(quitButton);
				MainStage.sMainStage.removeChild(titleClip);
				MainStage.sMainStage.removeChild(bgClip);
			}
			else if (MainStage.input.isMouseJustDown() &&
				quitButton.hitTestPoint(MainStage.input.getMouseX(),
										MainStage.input.getMouseY()))
			{
				//System.exit(0);
			}
			
		}		
		
	}
}