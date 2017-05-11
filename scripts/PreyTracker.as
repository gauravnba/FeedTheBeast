package
{
	import flash.display.MovieClip;
	
	public class PreyTracker
	{
		private var clipVec:Vector.<MovieClip>;
		private var clipXVec:Vector.<int>;
		private var clipYVec:Vector.<int>;
		private var preyTypes:Vector.<int>;
		private var preyEaten:Vector.<Boolean>;
		private var numPrey:int;
		private var preyRemaining:int;
		
		public function PreyTracker()
		{
			clipVec = new Vector.<MovieClip>();
			clipXVec = new Vector.<int>();
			clipYVec = new Vector.<int>();
			preyTypes = new Vector.<int>();
			preyEaten = new Vector.<Boolean>();
			numPrey = 0;
			preyRemaining = 0;
			
			initPreyIconPositions();
			
		}
		
		public function setPrey(preyTargets:Array)
		{
			if (preyTargets.length > C.PREY_TRACKER_MAX_COUNT)
			{
				trace ("Too many prey for prey tracker");
				return;
			}
			
			// Remove any previous icons 
			removeIconsFromStage();
			
			numPrey = preyTargets.length;
			preyRemaining = numPrey;
			
			var i:int = 0;
			
			// Reset arrays 
			clipVec = new Vector.<MovieClip>();
			preyTypes = new Vector.<int>();
			preyEaten = new Vector.<Boolean>();
			
			for (i = 0; i < preyTargets.length; i++)
			{
				preyTypes[i] = preyTargets[i];
				preyEaten[i] = false;
				
				switch (preyTargets[i])
				{
				case C.PREY_TYPE_GAZELLE:
					clipVec[i] = new Assets.classGazelleHeadCMC();
					break;
				case C.PREY_TYPE_BIRD:
					//clipVec[i] = new Assets.classBirdHeadCMC();
					break;
				case C.PREY_TYPE_ELEPHANT:
					//clipVec[i] = new Assets.classElephantHeadCMC();
					break;
				case C.PREY_TYPE_HIPPO:
					clipVec[i] = new Assets.classHippoHeadCMC();
					break;
				default:
					break;
				}
				
				clipVec[i].x = clipXVec[i];
				clipVec[i].y = clipYVec[i];
				clipVec[i].width = C.PREY_ICON_WIDTH;
				clipVec[i].height = C.PREY_ICON_HEIGHT;
			}
			
			addIconsToStage();
		}
		
		private function initPreyIconPositions()
		{
			var i:int = 0;
			
			for (i = 0; i < C.PREY_TRACKER_MAX_COUNT; i++)
			{
				clipXVec.push(0);
				clipYVec.push(0);
			}
			for (i = 0; i < C.PREY_TRACKER_MAX_COUNT; i++)
			{
				clipXVec[i] = C.PREY_TRACKER_X + i*C.PREY_TRACKER_SPACING;
				clipYVec[i] = C.PREY_TRACKER_Y;
			}
		}
		
		public function addIconsToStage()
		{
			for (var i:int = 0; i < numPrey; i++)
			{
				HUD.parentClip.addChild(clipVec[i]);
			}
		}
		
		public function removeIconsFromStage()
		{
			for (var i:int = 0; i < numPrey; i++)
			{
				if (clipVec[i].stage != null)
					HUD.parentClip.removeChild(clipVec[i]);
			}
		}
		
		public function markAsEaten(index:int)
		{
			preyEaten[index] = true;
			preyRemaining--;
			
			if (clipVec[index].stage != null)
			{
				HUD.parentClip.removeChild(clipVec[index]);
			}
			
			// Swap clip to the greyed out version
			switch(preyTypes[index])
			{
				case C.PREY_TYPE_GAZELLE:
					clipVec[index] = new Assets.classGazelleHeadGMC();
					break;
				case C.PREY_TYPE_BIRD:
					//clipVec[index] = new Assets.classBirdHeadGMC();
					break;
				case C.PREY_TYPE_ELEPHANT:
					//clipVec[index] = new Assets.classElephantHeadGMC();
					break;
				case C.PREY_TYPE_HIPPO:
					clipVec[index] = new Assets.classHippoHeadGMC();
					break;
				default:
					break;
			}
			
			HUD.parentClip.addChild(clipVec[index]);
			
			clipVec[index].x = clipXVec[index];
			clipVec[index].y = clipYVec[index];
			clipVec[index].width = C.PREY_ICON_WIDTH;
			clipVec[index].height = C.PREY_ICON_HEIGHT;
			clipVec[index].alpha = 0.5;
		}
		
		public function onEatPrey(preyType:int)
		{
			var i:int = 0;
			
			for (i = 0; i < preyTypes.length; i++)
			{
				if (preyTypes[i] == preyType &&
					preyEaten[i] == false)
				{
					markAsEaten(i);
					//Assets.gulpSound.play();
					break;
				}
			}
		}
		
		public function getPreyRemaining()
		{
			return preyRemaining;
		}
		
	}
}