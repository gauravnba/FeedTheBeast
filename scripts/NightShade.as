package
{
	import fl.motion.Color;
	import flash.display.Shape;
	import flash.display.BlendMode;
	
	public class NightShade
	{
		private var warmShade:Shape;
		private var nightShade:Shape;
		private var warmPeak:Number;
		private var nightPeak:Number;
		
		
		public function NightShade()
		{
			warmShade = new Shape();
			nightShade = new Shape();
			
			warmShade.graphics.beginFill(C.NIGHT_SHADE_WARM_COLOR);
			warmShade.graphics.drawRect(0, C.SCREEN_GAME_Y_OFFSET, C.SCREEN_WIDTH, C.SCREEN_GAME_HEIGHT);
			warmShade.graphics.endFill();
			
			nightShade.graphics.beginFill(C.NIGHT_SHADE_NIGHT_COLOR);
			nightShade.graphics.drawRect(0, C.SCREEN_GAME_Y_OFFSET, C.SCREEN_WIDTH, C.SCREEN_GAME_HEIGHT);
			nightShade.graphics.endFill();
			
			MainStage.sMainStage.addChild(warmShade);
			MainStage.sMainStage.addChild(nightShade);
			
			warmShade.alpha = 0.0;
			nightShade.alpha = 0.0;
			
			warmPeak  = (C.NIGHT_SHADE_WARM_START + C.NIGHT_SHADE_WARM_END)/2;
			nightPeak = (C.NIGHT_SHADE_NIGHT_START + C.NIGHT_SHADE_NIGHT_END)/2;
			
			warmShade.blendMode = BlendMode.MULTIPLY;
			nightShade.blendMode = BlendMode.MULTIPLY;
		}
		
		public function update(dayRatio:Number)
		{
			var alpha:Number = 0.0;
			
			if (dayRatio > C.NIGHT_SHADE_WARM_START &&
				dayRatio < C.NIGHT_SHADE_WARM_END)
			{
				if (dayRatio < warmPeak)
				{
					warmShade.alpha = (dayRatio - C.NIGHT_SHADE_WARM_START)/ (warmPeak - C.NIGHT_SHADE_WARM_START) * C.NIGHT_SHADE_MAX_ALPHA_WARM;
				}
				else
				{
					warmShade.alpha = (1.0 - (dayRatio - warmPeak)/ (C.NIGHT_SHADE_WARM_END - warmPeak)) * C.NIGHT_SHADE_MAX_ALPHA_WARM;
				}
			}
			else
			{
				warmShade.alpha = 0.0;
			}
			
			if (dayRatio > C.NIGHT_SHADE_NIGHT_START && 
				dayRatio < C.NIGHT_SHADE_NIGHT_END)
			{
				if (dayRatio < nightPeak)
				{
					nightShade.alpha = (dayRatio - C.NIGHT_SHADE_NIGHT_START)/ (nightPeak - C.NIGHT_SHADE_NIGHT_START) * C.NIGHT_SHADE_MAX_ALPHA_NIGHT;
				}
				else
				{
					nightShade.alpha = (1.0 - (dayRatio - nightPeak)/ (C.NIGHT_SHADE_NIGHT_END - nightPeak)) * C.NIGHT_SHADE_MAX_ALPHA_NIGHT;
				}
			}
			else
			{
				nightShade.alpha = 0.0;
			}
			
			// Place on top of everything
			if(warmShade.stage != null)
			{
				MainStage.sMainStage.removeChild(warmShade);
				MainStage.sMainStage.addChild(warmShade);
			}
			if (nightShade.stage != null)
			{
				MainStage.sMainStage.removeChild(nightShade);
				MainStage.sMainStage.addChild(nightShade);
			}
			
		}
		
		public function reset()
		{
			if (warmShade != null)
				warmShade.alpha = 0.0;
			if (nightShade != null)
				nightShade.alpha = 0.0;
		}
	}
}