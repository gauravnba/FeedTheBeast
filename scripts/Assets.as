package
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	public class Assets
	{
		
		public static var classFieldMC:Class;     // 0 
		public static var classLion1MC:Class;     // 1 
		public static var classMenuStartMC:Class; // 2
		public static var classMenuQuitMC:Class;  // 3
		public static var classMenuTitleMC:Class; // 4 
		public static var classMenuBGMC:Class;    // 5 
		public static var classRock2MC:Class;     // 6
		public static var classTreeMC:Class;      // 7
		public static var classGazelleMC:Class;   // 8
		public static var classFailBackMC:Class;  // 9
		public static var classFailRetryMC:Class; // 9
		public static var classFailQuitMC:Class;  // 9
		public static var classLion2MC:Class;     // 10 
		public static var classWaterSampleMC:Class; // 11
		public static var classBirdMC:Class;	  // 12
		public static var classDayBannerMC:Class; // 13 
		public static var classLion3MC:Class;     // 14
		public static var classLion4MC:Class;     // 15 
		public static var classLion5MC:Class;     // 16   
		public static var classWoodSound:Class;   // 17 
		public static var classGazelleHeadCMC:Class; // 18
		public static var classGazelleHeadGMC:Class; // 19 
		public static var classHippoHeadCMC:Class;   // 20 
		public static var classHippoHeadGMC:Class;   // 21
		public static var classHippoMC:Class;      //22
		public static var classExplosionSFX:Class;	 // 23
		public static var classFailureTone:Class;	 // 24
		public static var classInGameMusic:Class;	 // 25
		public static var classSuccessTone:Class;	 // 26
		public static var classRockSound:Class;		 // 27
		public static var classWoodBreaking:Class; // 28
		public static var classLion3RollMC:Class //29
		public static var classLion4RollMC:Class; //30
		public static var classExplosionMC:Class; // 31 
		public static var classWinScreenMC:Class; // 32
		public static var classGulpSound:Class;
		public static const NUM_ASSETS:int = 27; 
		
		public static var woodSound:Sound = null;
		public static var explosionSFX:Sound =  null;
		public static var inGameMusic:Sound =  null;
		public static var successTone:Sound =  null;
		public static var rockSound:Sound =  null;
		public static var woodBreaking:Sound =  null;
		public static var gulpSound:Sound = null;
		
		public static var titleMusic:Sound;
		public static var titleMusicChannel:SoundChannel;
		
		public static var failureTone:Sound;
		public static var failureToneChannel:SoundChannel;

		
		private static var numLoadedAssets:int = 0;
		
		public static function loadAll()
		{
			loadMovieClip("assets/swfs/field.swf");	
			loadMovieClip("assets/swfs/WaterSample.swf");
			loadMovieClip("assets/swfs/gazelle.swf");
			loadMovieClip("assets/swfs/lion1.swf");
			loadMovieClip("assets/swfs/Play.swf");
			loadMovieClip("assets/swfs/Quit.swf");
			loadMovieClip("assets/swfs/menu_title.swf");
			loadMovieClip("assets/swfs/TreeMenu.swf");
			loadMovieClip("assets/swfs/Rock2.swf");
			loadMovieClip("assets/swfs/Tree2.swf");
			loadMovieClip("assets/swfs/gazelle.swf");
			loadMovieClip("assets/swfs/fail_dialogue.swf");
			loadMovieClip("assets/swfs/lion2.swf");
			loadMovieClip("assets/swfs/bird.swf");
			loadMovieClip("assets/swfs/day_banner.swf");
			loadMovieClip("assets/swfs/lion3.swf");
			loadMovieClip("assets/swfs/lion4.swf");
			loadMovieClip("assets/swfs/lion5.swf");
			loadMovieClip("assets/swfs/sound.swf");
			loadMovieClip("assets/swfs/GazelleHeadC.swf");
			loadMovieClip("assets/swfs/GazelleHeadG.swf");
			loadMovieClip("assets/swfs/HippoHeadC.swf");
			loadMovieClip("assets/swfs/HippoHeadG.swf");
			loadMovieClip("assets/swfs/hippo.swf");
			loadMovieClip("assets/swfs/lion3RollAnim.swf");
			loadMovieClip("assets/swfs/lion4RollAnim.swf");
			loadMovieClip("assets/swfs/Explosion.swf");
			loadMovieClip("assets/swfs/win_screen.swf");
		}
		
		private static function loadMovieClip(path:String)
		{
			var loader:Loader = new Loader();
			var urlReq:URLRequest = new URLRequest(path);
			var loaderParams:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, Assets.completedAssetLoad);
			loader.load(urlReq, loaderParams);
		}
		
		public static function completedAssetLoad(event:Event)
		{
			event.target.removeEventListener(Event.COMPLETE, Assets.completedAssetLoad);
			numLoadedAssets++;
		}
		
		public static function loadAllSymbols()
		{
			classFieldMC = getDefinitionByName("FieldMC") as Class;
			classWaterSampleMC = getDefinitionByName("WaterSampleMC") as Class;
			classLion1MC = getDefinitionByName("Lion1MC") as Class;
			classMenuStartMC = getDefinitionByName("MenuStartMC") as Class;
			classMenuQuitMC = getDefinitionByName("MenuQuitMC") as Class;
			classMenuTitleMC = getDefinitionByName("MenuTitleMC") as Class;
			classMenuBGMC = getDefinitionByName("MenuBGMC") as Class;
			classRock2MC = getDefinitionByName("Rock2MC") as Class;
			classTreeMC = getDefinitionByName("Tree2MC") as Class;
			classGazelleMC = getDefinitionByName("GazelleMC") as Class;
			classFailBackMC = getDefinitionByName("FailBackMC") as Class;
			classFailRetryMC = getDefinitionByName("FailRetryMC") as Class;
			classFailQuitMC = getDefinitionByName("FailQuitMC") as Class;
			classLion2MC = getDefinitionByName("Lion2MC") as Class;
			classBirdMC = getDefinitionByName("BirdMC") as Class;
			classDayBannerMC = getDefinitionByName("DayBannerMC") as Class;
			classLion3MC = getDefinitionByName("Lion3MC") as Class;
			classLion4MC = getDefinitionByName("Lion4MC") as Class;
			classLion5MC = getDefinitionByName("Lion5MC") as Class;
			classWoodSound = getDefinitionByName("WoodSound") as Class;
			classGazelleHeadCMC = getDefinitionByName("GazelleHeadCMC") as Class;
			classGazelleHeadGMC = getDefinitionByName("GazelleHeadGMC") as Class;
			classHippoHeadCMC = getDefinitionByName("HippoHeadCMC") as Class;
			classHippoHeadGMC = getDefinitionByName("HippoHeadGMC") as Class;
			classHippoMC = getDefinitionByName("HippoMC") as Class;
			classLion3RollMC = getDefinitionByName("Lion3RollMC") as Class;
			classLion4RollMC = getDefinitionByName("Lion4RollMC") as Class;
			classExplosionMC = getDefinitionByName("ExplosionMC") as Class;
			classWinScreenMC = getDefinitionByName("WinScreenMC") as Class;
			
			//classes for sounds
			classExplosionSFX = getDefinitionByName("ExplosionSFX") as Class;
			classFailureTone = getDefinitionByName("FailureTone") as Class;
			classInGameMusic = getDefinitionByName("InGameMusic") as Class;
			classSuccessTone = getDefinitionByName("SuccessTone") as Class;
			classRockSound = getDefinitionByName("RockSound") as Class;
			classWoodBreaking = getDefinitionByName("WoodBreakingSound") as Class;
			classGulpSound = getDefinitionByName("GulpSound") as Class;
			
			//init for sound
			explosionSFX 	= new classExplosionSFX();
			failureTone 	= new classFailureTone();
			inGameMusic 	= new classInGameMusic();
			successTone 	= new classSuccessTone();
			rockSound 		= new classRockSound();
			woodBreaking 	= new classWoodBreaking();
			woodSound		= new classWoodSound();
			gulpSound		= new classGulpSound();
			
			titleMusic = new Sound();
			titleMusicChannel = new SoundChannel();
			
			failureTone = new Sound();
			failureToneChannel = new SoundChannel();
		}
		
		public static function isLoadingComplete():Boolean
		{
			if (numLoadedAssets >= Assets.NUM_ASSETS)
				return true;
			else 
				return false; 
		}
	}
}