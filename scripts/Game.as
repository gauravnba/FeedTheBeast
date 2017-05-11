package
{
	import flash.display.*;
	import flash.ui.Keyboard;
	import flash.utils.*;
	import flash.media.SoundMixer;
	
	public class Game
	{		
		public var level:int;
		public var time:int;
		public var player:Player;
		public var prey:Vector.<Prey>;
		//public var predators:Vector.<Predator>;
		public var obstacles:Vector.<Obstacle>;
		public var hud:HUD;
		public var nightShade:NightShade;
		//public var pauseMenu:PauseMenu;
		public var preyQuota:int;
		public var preyHunted:int;
		
		public var gameState:int;
		
		private var field:MovieClip;
		private var failDialogue:FailDialogue;
		
		private var birdSpawnTimer:Number;
		private var birdSpawnPeriod:Number;
		
		private var waitTime:Number;
		private var dayBanner:DayBanner;
		
		private var score:int;
		private var lastValidScore:int;
		
		private var finaleTime:Number;
		private var explosionClip:MovieClip;
		private var winScreen:MovieClip;
		
		public function Game()
		{
			level = C.LEVEL_1;
			time = C.LEVEL_1_TIME;
			
			field = new Assets.classFieldMC();
			MainStage.sMainStage.addChild(field);
			
			player = new Player(this);
			player.setPosition(C.PLAYER_START_X, C.PLAYER_START_Y);

			prey = null;
			obstacles = null;
			
			hud = new HUD(this);
			failDialogue = new FailDialogue(this);
			score = 0;
			lastValidScore = 0;
			preyQuota = C.LEVEL_1_PREY_QUOTA;
			preyHunted = 0;
			
			birdSpawnTimer = 0.0;
			
			loadLevel(C.LEVEL_1);
			
			waitTime = 0.0;
			
			nightShade = new NightShade();
			gameState = C.GAME_STATE_WAIT;
			

		}
		
		public function update()
		{
			switch (gameState)
			{
			case C.GAME_STATE_WAIT:
				updateWait();
				break;
			case C.GAME_STATE_PLAY:
				updatePlay();
				break;
			case C.GAME_STATE_FAIL:
				updateFail();
				break;
			case C.GAME_STATE_FINALE:
				updateFinale();
				break;
			case C.GAME_STATE_WIN:
				updateWin();
				break;
			default:
				break;
			}
		}
		
		public function updateWait()
		{
			waitTime += MainStage.getDeltaTime();
			dayBanner.update(waitTime);
			
			player.setPosition(C.PLAYER_START_X, C.PLAYER_START_Y);
			hud.bringToTop();
			
			if (waitTime >= C.LEVEL_WAIT_TIME)
			{
				gameState = C.GAME_STATE_PLAY;
				dayBanner.destroy();
				dayBanner = null;
			}
			
		}
		
		public function updatePlay()
		{
			var i:int = 0;
			
			player.update();
			
			spawnBirds();
			
			for (i = 0; i < prey.length; i++)
			{
				prey[i].update();
			}
			
			hud.update();
			
			// Check if we should change level.
			if ((hud.preyTracker.getPreyRemaining() == 0) && (hud.timeBar.getTime() <= 0))
			{
				loadLevel(level+1);
				gameState = C.GAME_STATE_WAIT;
				waitTime = 0.0;
			}
			else if (hud.timeBar.getTime() <= 0)
			{
				// Player failed to get all of the gazelle.
				// So transition to the fail game state.
				nightShade.reset();
				failDialogue.show();
				score = lastValidScore;
				hud.setScore(score);
				gameState = C.GAME_STATE_FAIL;
			}
			else if (level == C.LEVEL_5 &&
					 hud.preyTracker.getPreyRemaining() == 0)
			{
				finaleTime = C.FINALE_TIME;
				gameState = C.GAME_STATE_FINALE;
				
				explosionClip = new Assets.classExplosionMC();
				Assets.explosionSFX.play();
				explosionClip.x = player.rect.x + player.rect.width/2.0 - C.FINALE_EXPLOSION_WIDTH/2.0;
				explosionClip.y =  player.rect.y + player.rect.height/2.0 - C.FINALE_EXPLOSION_HEIGHT/2.0;
				explosionClip.width = C.FINALE_EXPLOSION_WIDTH;
				explosionClip.height = C.FINALE_EXPLOSION_HEIGHT;
				MainStage.sMainStage.addChild(explosionClip);
				MainStage.sMainStage.removeChild(player.clip);
				
			}
			
			nightShade.update(hud.timeBar.getRatio());
			
			if (MainStage.input.isKeyJustDown(Keyboard.C))
			{
				loadLevel(level+1);
				gameState = C.GAME_STATE_WAIT;
				waitTime = 0.0;
			}
			if (MainStage.input.isKeyJustDown(Keyboard.NUMBER_1))
			{
				player.showDebugShape();
				
				for (i = 0; i < prey.length; i++)
					prey[i].showDebugShape();
				for (i = 0; i < obstacles.length; i++)
				    obstacles[i].showDebugShape();
				// for (i = 0; i < predators.length; i++)
				//    predators[i].showDebugShape();
			}
			if (MainStage.input.isKeyJustDown(Keyboard.NUMBER_2))
			{
				player.hideDebugShape();
				
				for (i = 0; i < prey.length; i++)
					prey[i].hideDebugShape();
				for (i = 0; i < obstacles.length; i++)
				    obstacles[i].hideDebugShape();
				// for (i = 0; i < predators.length; i++)
				//    predators[i].hideDebugShape();
			}
		}
		
		public function updateFail()
		{
			nightShade.reset();
			failDialogue.update();
		}
		
		public function updateFinale()
		{
			finaleTime -= MainStage.getDeltaTime();
			
			if (finaleTime <= 0)
			{
				gameState = C.GAME_STATE_WIN;
				winScreen = new Assets.classWinScreenMC();
				winScreen.x = 0;
				winScreen.y = 0;
				MainStage.sMainStage.addChild(winScreen);
				hud.scoreText.x = C.WIN_SCORE_X;
				hud.scoreText.y = C.WIN_SCORE_Y;
				//MainStage.sMainStage.removeChild(hud.scoreText);
				MainStage.sMainStage.addChild(hud.scoreText);
				SoundMixer.stopAll();
				Assets.successTone.play()
			}
		}
		
		public function updateWin()
		{
			if (MainStage.input.isMouseJustDown())
			{
				MainStage.clearStage();
				MainStage.sMainStage.switchState(C.MAIN_STATE_MENU);
			}
		}
		
		public function addToScore(points:Number)
		{
			score += points;
			hud.setScore(score);
		}
		
		public function getScore():Number
		{
			return score;
		}
		
		public function loadLevel(level:int)
		{
			var i:int = 0;
			var levelObstacles:Array = null;
			var levelTime:Number = 0.0;
			var levelPreyTargets:Array = null;
			
			this.level = level;
			
			lastValidScore = score;
			
			preyHunted = 0;
			birdSpawnTimer = 0.0;
			
			player.setStats(level);
			player.setPosition(C.PLAYER_START_X, C.PLAYER_START_Y);
			
			if (nightShade != null)
				nightShade.reset();
			
			// Destroy actors from previous level's obstacles / predators/ water 
			if (prey != null)
				Actor.destroyActors(Vector.<Actor>(prey));
			if (obstacles != null)
				Actor.destroyActors(Vector.<Actor>(obstacles));
			// if (predators != null)
			//	  Actor.destroyActors(predators);
			
			// Create new arrays, the previous ones will be garbage collected (hopefully?)
			prey = new Vector.<Prey>();
			obstacles = new Vector.<Obstacle>();
			//predators = new Vector.<Predators>();
			
			// Get the correct level data vectors
			switch (level)
			{
			case C.LEVEL_1:
				levelObstacles = LevelData.level1Obstacles;
				levelPreyTargets = LevelData.level1PreyTargets;
				levelTime = C.LEVEL_1_TIME;
				preyQuota = C.LEVEL_1_PREY_QUOTA;
				birdSpawnPeriod = C.LEVEL_1_BIRD_SPAWN_PERIOD;
				break;
			case C.LEVEL_2:
				levelObstacles = LevelData.level2Obstacles;
				levelPreyTargets = LevelData.level2PreyTargets;
				levelTime = C.LEVEL_2_TIME;
				preyQuota = C.LEVEL_2_PREY_QUOTA;
				birdSpawnPeriod = C.LEVEL_2_BIRD_SPAWN_PERIOD;
				break;
			case C.LEVEL_3:
				levelObstacles = LevelData.level3Obstacles;
				levelPreyTargets = LevelData.level3PreyTargets;
				levelTime = C.LEVEL_3_TIME;
				preyQuota = C.LEVEL_3_PREY_QUOTA;
				birdSpawnPeriod = C.LEVEL_3_BIRD_SPAWN_PERIOD;
				break;
			case C.LEVEL_4:
				levelObstacles = LevelData.level4Obstacles;
				levelPreyTargets = LevelData.level4PreyTargets;
				levelTime = C.LEVEL_4_TIME;
				preyQuota = C.LEVEL_4_PREY_QUOTA;
				birdSpawnPeriod = C.LEVEL_4_BIRD_SPAWN_PERIOD;
				break;
			case C.LEVEL_5:
				levelObstacles = LevelData.level5Obstacles;
				levelPreyTargets = LevelData.level5PreyTargets;
				levelTime = C.LEVEL_5_TIME;
				preyQuota = C.LEVEL_5_PREY_QUOTA;
				birdSpawnPeriod = C.LEVEL_5_BIRD_SPAWN_PERIOD;
				break;
			default:
				break;
			}
			
			var type:int = 0;
			var x:int    = 0;
			var y:int    = 0;

			//Moved spawnPrey before loading obstacles, to allow prey to hide behind trees.
			spawnPrey();
			
			while (i < levelObstacles.length)
			{
				type = levelObstacles[i];
				x    = levelObstacles[i+1];
				y    = levelObstacles[i+2];
				
				switch (type)
				{
					case C.OBSTACLE_TYPE_TREE:
						obstacles.push(new Tree(this));
						obstacles[obstacles.length - 1].setPosition(x, y);
						break;
					case C.OBSTACLE_TYPE_ROCK:
						obstacles.push(new Rock(this));
						obstacles[obstacles.length - 1].setPosition(x, y);
						break;
					case C.OBSTACLE_TYPE_WATER:
						obstacles.push(new Water(this));
						obstacles[obstacles.length - 1].setPosition(x, y);
						break;
					default:
						break;
				}
				
				// Go to the next list item 
				i += 3;
			}
			
			spawnHippos();
			
			if (level == C.LEVEL_5)
			{
				// special scripted stuff for level 5 
				prey[0].setSpeed(0.0);
				prey[0].setPosition(C.LEVEL_5_LAST_PREY_X, C.LEVEL_5_LAST_PREY_Y);
			}
			
			hud.timeBar.reset();
			hud.preyTracker.setPrey(levelPreyTargets);
			dayBanner = new DayBanner(level);
		}
		
		function spawnHippos()
		{
			var numHippo:int = 0;
			var numWaters:int = 0;
			var waterVec:Vector.<Water> = new Vector.<Water>();
			var w:int = 0;
			
			var i:int = 0;
			
			switch(level)
			{
			case C.LEVEL_1:
				numHippo = C.LEVEL_1_HIPPO_COUNT;
				break;
			case C.LEVEL_2:
				numHippo = C.LEVEL_2_HIPPO_COUNT;
				break;
			case C.LEVEL_3:
				numHippo = C.LEVEL_3_HIPPO_COUNT;
				break;
			case C.LEVEL_4:
				numHippo = C.LEVEL_4_HIPPO_COUNT;
				break;
			case C.LEVEL_5:
				numHippo = C.LEVEL_5_HIPPO_COUNT;
				break;
			default:
				numHippo = C.LEVEL_1_HIPPO_COUNT;
				break;
			}
			
			var spawnX:Number = 0;
			var spawnY:Number = 0;
			
			for (i = 0; i < obstacles.length; i++)
			{
				if (obstacles[i].getType() == C.OBSTACLE_TYPE_WATER)
				{
					numWaters++;
					waterVec.push(obstacles[i]);
				}
			}
			
			// Only spawn hippos if there are water obstacles.
			if (numWaters > 0)
			{
				for (i = 0; i < numHippo; i++)
				{
					spawnX = waterVec[w].rect.x + Math.random() * waterVec[w].rect.width;
					spawnY = waterVec[w].rect.y + Math.random() * waterVec[w].rect.height;
					prey.push(new Hippo(this));
					prey[prey.length - 1].setPosition(spawnX, spawnY);
					Hippo(prey[prey.length - 1]).setWater(Water(waterVec[w]));
					
					w++;					
					if (w >= numWaters)
						w = 0;
				}
			}
			Assets.inGameMusic.play();
		}
		
		function spawnPrey()
		{
			var numGazelle:int = 0;
			var numHippo:int = 0;
			var numWaters:int = 0;
			var waterVec:Vector.<Water> = new Vector.<Water>();
			var w:int = 0;
			
			var i:int = 0;
			
			switch(level)
			{
			case C.LEVEL_1:
				numGazelle = C.LEVEL_1_GAZELLE_COUNT;
				numHippo = C.LEVEL_1_HIPPO_COUNT;
				break;
			case C.LEVEL_2:
				numGazelle = C.LEVEL_2_GAZELLE_COUNT;
				numHippo = C.LEVEL_2_HIPPO_COUNT;
				break;
			case C.LEVEL_3:
				numGazelle = C.LEVEL_3_GAZELLE_COUNT;
				numHippo = C.LEVEL_3_HIPPO_COUNT;
				break;
			case C.LEVEL_4:
				numGazelle = C.LEVEL_4_GAZELLE_COUNT;
				numHippo = C.LEVEL_4_HIPPO_COUNT;
				break;
			case C.LEVEL_5:
				numGazelle = C.LEVEL_5_GAZELLE_COUNT;
				numHippo = C.LEVEL_5_HIPPO_COUNT;
				break;
			default:
				numGazelle = C.LEVEL_1_GAZELLE_COUNT;
				numHippo = C.LEVEL_1_HIPPO_COUNT;
				break;
			}
			
			var spawnX:Number = 0;
			var spawnY:Number = 0;
			
			// Spawn gazelle!
			while (prey.length < numGazelle)
			{
				spawnX = Math.random() * C.SCREEN_WIDTH;
				spawnY = Math.random() * C.SCREEN_HEIGHT;
				prey.push(new Gazelle(this));
				prey[prey.length - 1].setPosition(spawnX, spawnY);
			}
			
			for (i = 0; i < obstacles.length; i++)
			{
				if (obstacles[i].getType() == C.OBSTACLE_TYPE_WATER)
				{
					numWaters++;
					waterVec.push(obstacles[i]);
				}
			}
			
			// Only spawn hippos if there are water obstacles.
			if (numWaters > 0)
			{
				for (i = 0; i < numHippo; i++)
				{
					spawnX = obstacles[w].rect.x + Math.random() * obstacles[w].rect.width;
					spawnY = obstacles[w].rect.y + Math.random() * obstacles[w].rect.height;
					prey.push(new Hippo(this));
					prey[prey.length - 1].setPosition(spawnX, spawnY);
					Hippo(prey[prey.length - 1]).setWater(Water(obstacles[w]));
					
					w++;					
					if (w >= numWaters)
						w = 0;
				}
			}
		}
		
		public function resetLevel()
		{
			loadLevel(level);
			gameState = C.GAME_STATE_WAIT;
			waitTime = 0.0;
		}
		
		public function addToPreyHunted(addedPrey:int)
		{
			preyHunted += addedPrey;
		}
		
		public function spawnBirds()
		{
			birdSpawnTimer += MainStage.getDeltaTime();
			
			if (birdSpawnTimer > birdSpawnPeriod)
			{
				birdSpawnTimer = 0.0;
				prey.push(new Bird(this));
			}
		}
	}
}