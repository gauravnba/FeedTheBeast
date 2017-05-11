package
{
	import flash.display.Shape;
	import flash.text.TextField;
	import flash.display.MovieClip;
	import flash.net.URLRequest;
	
	
	public class FailDialogue
	{
		private var backClip:MovieClip;
		private var retryClip:MovieClip;
		private var quitClip:MovieClip;
		
		private var game:Game;
		
		public function FailDialogue(theGame:Game)
		{
			game = theGame;
			
			backClip = new Assets.classFailBackMC();
			retryClip = new Assets.classFailRetryMC();
			quitClip = new Assets.classFailQuitMC();
		}
		
		public function show()
		{
			MainStage.sMainStage.addChild(backClip);
			MainStage.sMainStage.addChild(retryClip);
			MainStage.sMainStage.addChild(quitClip);
			
			backClip.x = 0;
			backClip.y = 0;
			retryClip.x = C.FAIL_DIALOGUE_X + 50;
			retryClip.y = C.FAIL_DIALOGUE_Y + 200;
			quitClip.x = C.FAIL_DIALOGUE_X + 245;
			quitClip.y = C.FAIL_DIALOGUE_Y + 200;
			Assets.failureTone.load(new URLRequest("assets/Audio/OmNomSavanah-FalseEnd.mp3"));
			Assets.failureToneChannel = Assets.failureTone.play();
		}
		
		public function update()
		{
			if (MainStage.input.isMouseJustDown())
			{
				var mouseX:int = MainStage.input.getMouseX();
				var mouseY:int = MainStage.input.getMouseY();
				
				if (retryClip.hitTestPoint(mouseX, mouseY))
				{
					game.resetLevel();
					hide();
					Assets.failureToneChannel.stop();
				}
				
				if (quitClip.hitTestPoint(mouseX, mouseY))
				{
					MainStage.clearStage();
					MainStage.sMainStage.switchState(C.MAIN_STATE_MENU);
					Assets.failureToneChannel.stop();
				}
			}
		}
		
		public function hide()
		{
			if (backClip.stage != null)
				MainStage.sMainStage.removeChild(backClip);
			if (retryClip.stage != null)
				MainStage.sMainStage.removeChild(retryClip);
			if (quitClip.stage != null)
				MainStage.sMainStage.removeChild(quitClip);
		}
		
		public function bringToTop()
		{
			MainStage.sMainStage.setChildIndex(backClip, MainStage.sMainStage.numChildren);
			MainStage.sMainStage.setChildIndex(retryClip, MainStage.sMainStage.numChildren);
			MainStage.sMainStage.setChildIndex(quitClip, MainStage.sMainStage.numChildren);
		}
	}
}