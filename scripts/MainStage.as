package
{
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.*;
	import flash.display.StageScaleMode;
	import flash.net.URLRequest;
	
	public class MainStage extends MovieClip 
	{
		public static var sMainStage:MainStage = null; 
		
		public var mainState:int;
		
		public var game:Game;
		public var menu:Menu;
		private var deltaTime:Number;
		private var lastFrameTime:Number;
		private var thisFrameTime:Number;
		private var MusicIsPlaying:Boolean = false;
		
		public static var input:InputManager;
		
		
		
		public function MainStage() 
		{
			mainState = C.MAIN_STATE_LOADING;
			
			// Create only one input manager. 
			// This constructor should only be called once anyway.
			// Just being safe
			if (input == null)
			{
				input = new InputManager();
				stage.addEventListener(KeyboardEvent.KEY_DOWN, input.handleKeyDown);
				stage.addEventListener(KeyboardEvent.KEY_UP, input.handleKeyUp);
				stage.addEventListener(MouseEvent.MOUSE_DOWN, input.handleMouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, input.handleMouseUp);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, input.handleMouseMove);
			}
			
			game = null;
			menu = null;
			deltaTime = 0.0;
			// Initialize frame times to the current time to avoid crazy delta times on first frame of game
			var date:Date = new Date();
			lastFrameTime = date.time;
			thisFrameTime = date.time;
			
			// Load assets 
			Assets.loadAll();
			
			sMainStage = this;
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(evt:Event)
		{
			updateDeltaTime();
			
			if (mainState == C.MAIN_STATE_GAME)
			{
				Assets.titleMusicChannel.stop();
				game.update();
			}
			else if (mainState == C.MAIN_STATE_LOADING)
			{
				if (Assets.isLoadingComplete())
				{
					// Load symbols so other classes can assign movie clip references
					Assets.loadAllSymbols();
					switchState(C.MAIN_STATE_MENU);
				}
			}
			else if (mainState == C.MAIN_STATE_MENU)
			{
				if(MusicIsPlaying == false)
				{
					Assets.titleMusic.load(new URLRequest("assets/Audio/OmNomSavanah-Title.mp3"));
					Assets.titleMusicChannel = Assets.titleMusic.play();
					MusicIsPlaying = true;
				}

				menu.update();
			}
			
			// Keep this input.update function last because it sets keys that
			// are JUST DOWN to DOWN and JUST UP to UP.
			input.update();
		}
		
		public function switchState(state:int)
		{
			mainState = state;
			
			if (mainState == C.MAIN_STATE_GAME)
				game = new Game();
			else if (mainState == C.MAIN_STATE_MENU)
				menu = new Menu();
		}
		
		private function updateDeltaTime()
		{
			lastFrameTime = thisFrameTime;
			thisFrameTime = (new Date()).time;
			
			// calculate deltaTime in seconds
			deltaTime = (thisFrameTime - lastFrameTime)/1000.0; 
		}
		
		public static function getDeltaTime()
		{
			return sMainStage.deltaTime;
		}

		public static function clearStage()
		{
			if (sMainStage != null)
			{
				while(sMainStage.numChildren != 0)
				{
					sMainStage.removeChild(sMainStage.getChildAt(0));
				}
			}
		}
	}
}