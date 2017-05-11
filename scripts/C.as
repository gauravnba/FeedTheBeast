	
	package
	{
		import flash.display3D.IndexBuffer3D;

		public class C
		{	
			
			// Main States
			public static const MAIN_STATE_LOADING:int = 0;
			public static const MAIN_STATE_MENU:int = 1;
			public static const MAIN_STATE_GAME:int = 2;
			
			// Game States
			public static const GAME_STATE_WAIT:int = 0;
			public static const GAME_STATE_PLAY:int = 1;
			public static const GAME_STATE_FAIL:int = 2;
			public static const GAME_STATE_FINALE:int = 3;
			public static const GAME_STATE_WIN:int = 4;
			
			// General Consts
			public static const SCREEN_WIDTH:Number = 1366.0;
			public static const SCREEN_HEIGHT:Number = 768.0;
			public static const SCREEN_GAME_WIDTH:Number = 1366.0;
			public static const SCREEN_GAME_HEIGHT:Number = 720.0;
			public static const SCREEN_GAME_X_OFFSET:Number = 0;
			public static const SCREEN_GAME_Y_OFFSET:Number = 48.0;
			public static const FRAME_RATE:int = 60;
			
			// Player Consts
			public static const PLAYER_WIDTH:Number = 100.0;
			public static const PLAYER_HEIGHT:Number = 48.0;
			public static const PLAYER_CLIP_WIDTH:Number = 200.0;
			public static const PLAYER_CLIP_HEIGHT:Number = 100.0;
			public static const PLAYER_CLIP_OFFSET_X:Number = 50.0;
			public static const PLAYER_CLIP_OFFSET_Y:Number = 20.0;
			
			public static const PLAYER_START_X:Number = 600;
			public static const PLAYER_START_Y:Number = 400;
			
			public static const PLAYER_LEVEL_1_MAX_VELOCITY:Number = 6.0;
			public static const PLAYER_LEVEL_2_MAX_VELOCITY:Number = 4.0;
			public static const PLAYER_LEVEL_3_MAX_VELOCITY:Number = 1.5;
			public static const PLAYER_LEVEL_4_MAX_VELOCITY:Number = 1.25;
			public static const PLAYER_LEVEL_5_MAX_VELOCITY:Number = 1.0;
			
			public static const PLAYER_LEVEL_3_ROLLING_VELOCITY:Number = 6;
			public static const PLAYER_LEVEL_4_ROLLING_VELOCITY:Number = 8.0;
			
			public static const PLAYER_LEVEL_1_ACCELERATION:Number = 0.4;
			public static const PLAYER_LEVEL_2_ACCELERATION:Number = 0.25;
			public static const PLAYER_LEVEL_3_ACCELERATION:Number = 0.3;
			public static const PLAYER_LEVEL_4_ACCELERATION:Number = 0.4;
			public static const PLAYER_LEVEL_5_ACCELERATION:Number = 0.5;
			
			public static const PLAYER_LEVEL_1_DRAG:Number = 0.2;
			public static const PLAYER_LEVEL_2_DRAG:Number = 0.15;
			public static const PLAYER_LEVEL_3_DRAG:Number = 0.05;
			public static const PLAYER_LEVEL_4_DRAG:Number = 0.05;
			public static const PLAYER_LEVEL_5_DRAG:Number = 0.05;
			
			public static const PLAYER_MAX_VELOCITY:Number = 4.0;
			public static const PLAYER_DRAG_ACCELERATION:Number = 0.05;
			
			public static const PLAYER_ANIM_STATE_STOP:int = 0;
			public static const PLAYER_ANIM_STATE_RUN:int = 1;
			
			// Menu Consts 
			public static const MENU_START_X:int = 730;
			public static const MENU_START_Y:int = 250;
			public static const MENU_QUIT_X:int = 730;
			public static const MENU_QUIT_Y:int = 440;
			public static const MENU_TITLE_X:int = 100;
			public static const MENU_TITLE_Y:int = 100;
			public static const MENU_BG_X:int = 0;
			public static const MENU_BG_Y:int = 0;
			
			// HUD Consts 
			public static const TIME_BAR_MAX_TIME:Number = 30.0;
			public static const TIME_BAR_START_TIME:Number = 15.0;
			public static const TIME_BAR_FILL_COLOR:int = 0xff0000;
			public static const TIME_BAR_STROKE_COLOR:int = 0x000000;
			public static const TIME_BAR_STROKE_SIZE:int = 4;
			public static const TIME_BAR_X:int = 700;
			public static const TIME_BAR_Y:int = 8;
			public static const TIME_BAR_WIDTH:int = 300;
			public static const TIME_BAR_HEIGHT:int = 30;
			
			public static const SCORE_TEXTFIELD_X:int = 1200;
			public static const SCORE_TEXTFIELD_Y:int = 4;
			public static const SCORE_TEXTFIELD_SIZE:int = 32;
			public static const SCORE_TEXTFIELD_COLOR:int = 0xff0000;
			public static const SCORE_TEXTFIELD_WIDTH:int = 300;
			
			public static const NIGHT_SHADE_WARM_COLOR:uint = 0xf7e348;
			public static const NIGHT_SHADE_NIGHT_COLOR:uint = 0x5718ff;
			public static const NIGHT_SHADE_MAX_ALPHA_WARM:Number = 0.5;
			public static const NIGHT_SHADE_MAX_ALPHA_NIGHT:Number = 0.8;
			public static const NIGHT_SHADE_WARM_START:Number = 0.2;
			public static const NIGHT_SHADE_WARM_END:Number = 0.7;
			public static const NIGHT_SHADE_NIGHT_START:Number = 0.5;
			public static const NIGHT_SHADE_NIGHT_END:Number = 1.5;
			
			public static const FAIL_DIALOGUE_STROKE_SIZE:int = 5;
			public static const FAIL_DIALOGUE_STROKE_COLOR:int = 0xffffff;
			public static const FAIL_DIALOGUE_FILL_COLOR:int = 0x000000;
			public static const FAIL_DIALOGUE_ROUNDING:int = 12;
			public static const FAIL_DIALOGUE_X:Number = 460;
			public static const FAIL_DIALOGUE_Y:Number = 200;
			public static const FAIL_DIALOGUE_WIDTH:Number = 250;
			public static const FAIL_DIALOGUE_HEIGHT:Number = 200;
			
			public static const DAY_BANNER_X:Number = 0.0;
			public static const DAY_BANNER_Y:Number = SCREEN_HEIGHT/2 - 40;
			public static const DAY_BANNER_WIDTH:Number = SCREEN_WIDTH;
			public static const DAY_BANNER_HEIGHT:Number = 120.0;
			
			public static const PREY_TRACKER_MAX_COUNT:int = 20;
			public static const PREY_ICON_WIDTH:Number = 40.0;
			public static const PREY_ICON_HEIGHT:Number = 40.0;
			public static const PREY_TRACKER_SPACING:Number = 42.0;
			public static const PREY_TRACKER_X:Number = 10.0;
			public static const PREY_TRACKER_Y:Number = 3.0;
			
			// Level Consts 
			public static const LEVEL_WAIT_TIME = 3.0;
			
			public static const LEVEL_1:int = 0;
			public static const LEVEL_2:int = 1;
			public static const LEVEL_3:int = 2;
			public static const LEVEL_4:int = 3;
			public static const LEVEL_5:int = 4;
			
			public static const LEVEL_1_TIME:int = 15;
			public static const LEVEL_2_TIME:int = 25;
			public static const LEVEL_3_TIME:int = 30;
			public static const LEVEL_4_TIME:int = 30;
			public static const LEVEL_5_TIME:int = 100;
			
			public static const LEVEL_1_PREY_QUOTA:int = 10;
			public static const LEVEL_2_PREY_QUOTA:int = 10;
			public static const LEVEL_3_PREY_QUOTA:int = 10;
			public static const LEVEL_4_PREY_QUOTA:int = 10;
			public static const LEVEL_5_PREY_QUOTA:int = 1;
			
			public static const LEVEL_1_GAZELLE_COUNT:int = 15;
			public static const LEVEL_2_GAZELLE_COUNT:int = 20;
			public static const LEVEL_3_GAZELLE_COUNT:int = 20;
			public static const LEVEL_4_GAZELLE_COUNT:int = 20;
			public static const LEVEL_5_GAZELLE_COUNT:int = 1;
			
			public static const LEVEL_1_HIPPO_COUNT:int = 0;
			public static const LEVEL_2_HIPPO_COUNT:int = 0;
			public static const LEVEL_3_HIPPO_COUNT:int = 5;
			public static const LEVEL_4_HIPPO_COUNT:int = 10;
			public static const LEVEL_5_HIPPO_COUNT:int = 0;
			
			public static const LEVEL_1_BIRD_SPAWN_PERIOD:Number = LEVEL_1_TIME * 0.3;
			public static const LEVEL_2_BIRD_SPAWN_PERIOD:Number = LEVEL_2_TIME * 0.25;
			public static const LEVEL_3_BIRD_SPAWN_PERIOD:Number = LEVEL_3_TIME * 0.25;
			public static const LEVEL_4_BIRD_SPAWN_PERIOD:Number = LEVEL_4_TIME * 0.15;
			public static const LEVEL_5_BIRD_SPAWN_PERIOD:Number = LEVEL_5_TIME;
			
			public static const LEVEL_5_LAST_PREY_X:Number = 900.0;
			public static const LEVEL_5_LAST_PREY_Y:Number = 450.0;
			
			// Prey Consts
			public static const PREY_TYPE_GAZELLE:int = 0;
			public static const PREY_TYPE_BIRD:int = 1;
			public static const PREY_TYPE_ELEPHANT:int = 2;
			public static const PREY_TYPE_HIPPO:int = 3;
			
			public static const GAZELLE_WIDTH:Number = 48.0;
			public static const GAZELLE_HEIGHT:Number = 30.0;
			public static const GAZELLE_CLIP_WIDTH:Number = 80.0;
			public static const GAZELLE_CLIP_HEIGHT:Number = 52.0;
			public static const GAZELLE_CLIP_OFFSET_X:Number = 12.0;
			public static const GAZELLE_CLIP_OFFSET_Y:Number = 10.0;
			public static const GAZELLE_STATE_IDLE:int = 0;
			public static const GAZELLE_STATE_RUN:int = 1;
			public static const GAZELLE_MIN_SPEED:Number = 100.0;
			public static const GAZELLE_MAX_SPEED:Number = 200.0;
			public static const GAZELLE_MIN_IDLE_TIME:Number = 0.0;
			public static const GAZELLE_MAX_IDLE_TIME:Number = 2.0;
			public static const GAZELLE_MIN_RUN_TIME:Number = 1.0;
			public static const GAZELLE_MAX_RUN_TIME:Number = 3.0;
			public static const GAZELLE_FLEE_RADIUS:Number = 600.0;
			
			public static const BIRD_WIDTH:Number = 48.0;
			public static const BIRD_HEIGHT:Number = 30.0;
			public static const BIRD_CLIP_WIDTH:Number = 65.0;
			public static const BIRD_CLIP_HEIGHT:Number = 42.0;
			public static const BIRD_CLIP_OFFSET_X:Number = 4.0;
			public static const BIRD_CLIP_OFFSET_Y:Number = 3.0;
			public static const BIRD_MIN_SPEED:Number = 300.0;
			public static const BIRD_MAX_SPEED:Number = 500.0;
			
			public static const HIPPO_WIDTH:Number = 48.0;
			public static const HIPPO_HEIGHT:Number = 30.0;
			public static const HIPPO_CLIP_WIDTH:Number = 65.0;
			public static const HIPPO_CLIP_HEIGHT:Number = 42.0;
			public static const HIPPO_CLIP_OFFSET_X:Number = 4.0;
			public static const HIPPO_CLIP_OFFSET_Y:Number = 3.0;
			public static const HIPPO_MIN_SPEED:Number = 80.0;
			public static const HIPPO_MAX_SPEED:Number = 170.0;
			public static const HIPPO_Y_TIME:Number = 1.0;

			// Debug Variables 
			public static const DEBUG_ACTOR_SHAPE_STROKE_SIZE:Number = 3.0;
			public static const DEBUG_ACTOR_SHAPE_COLOR:int = 0xA54565;
			
			// Obstacle Consts 
			public static const OBSTACLE_TYPE_ROCK:int = 0;
			public static const OBSTACLE_TYPE_TREE:int = 1;
			public static const OBSTACLE_TYPE_WATER:int = 2;
			
			public static const ROCK_X_POSITION:int = 700;
			public static const ROCK_Y_POSITION:int = 500;
			public static const ROCK_WIDTH:Number = 35;
			public static const ROCK_HEIGHT:Number = 29;
			public static const ROCK_CLIP_OFFSET_X:Number = 6;
			public static const ROCK_CLIP_OFFSET_Y:Number = 10;
			
			public static const TREE_X_POSITION:int = 300;
			public static const TREE_Y_POSITION:int = 700;
			public static const TREE_WIDTH:int = 250;
			public static const TREE_HEIGHT:int = 195;
			public static const TREE_RECT_WIDTH:Number = 25;
			public static const TREE_RECT_HEIGHT:Number = 60;
			public static const TREE_CLIP_OFFSET_X:Number = 130;
			public static const TREE_CLIP_OFFSET_Y:Number = 90;
			
			public static const WATER_WIDTH:Number = 470;
			public static const WATER_HEIGHT:Number = 330;
			public static const WATER_CLIP_X_OFFSET:Number = -220;
			public static const WATER_CLIP_Y_OFFSET:Number = -160;
			
			// Finale Consts
			public static const FINALE_TIME:Number = 2.0;
			public static const FINALE_EXPLOSION_WIDTH:Number = 500.0;
			public static const FINALE_EXPLOSION_HEIGHT:Number = 282.0;
			
			// Win Consts 
			public static const WIN_SCORE_X:Number = 650;
			public static const WIN_SCORE_Y:Number = 500;
		}	
	}