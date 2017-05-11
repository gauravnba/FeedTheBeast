

package {
	
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;

	public class Renderable {
		
		protected var baseClip:MovieClip; // primary movie clip that all others attach to
		protected var parentClip:MovieClip; // parent of the base clip
		protected var assetClip:MovieClip; // used to load external assets	

		// Debug 
		protected var startTime:Number;
		protected var endTime:Number;
		
		public function Renderable(argParentClip:MovieClip, argAssetPath:String) {	
			this.parentClip = argParentClip;
			
			// Create the base clip on the parent
			this.baseClip = new MovieClip();
			this.parentClip.addChild(this.baseClip);
			
			// Create a loader and load the provided asset path
			var loader:Loader = new Loader();
			var urlReq:URLRequest = new URLRequest(argAssetPath);
			var loaderParams:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.completedExternalAssetLoad);
			loader.load(urlReq, loaderParams);
			
			
			startTime = new Date().getTime();
			
			
		}
		
		private function completedExternalAssetLoad(event:Event):void {
			endTime = new Date().getTime();
			trace("End load: " + (endTime - startTime));
			// Assign the movie clip for the asset and center it on the base clip	
			this.assetClip = MovieClip(event.target.content);
			this.baseClip.addChild(this.assetClip);
			//this.assetClip.x -= this.assetClip.width / 2;
			//this.assetClip.y -= this.assetClip.height / 2;			
			
			// Remove the event listener that triggered this call back
			event.target.removeEventListener(Event.COMPLETE, this.completedExternalAssetLoad);
		}
		
		public function setX(x:Number)
		{
			baseClip.x = x;
		}
		
		public function setY(y:Number)
		{
			baseClip.y = y;
		}
	}
	
}
