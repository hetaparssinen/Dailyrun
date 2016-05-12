package  {
	
	import flash.display.MovieClip;
import flash.geom.Rectangle;

import starling.core.Starling;
	
	/*
	* This class sets up the Starling framework and the stage.
	*
	*
	*/
	public class Main extends MovieClip
	{
		
		public function Main():void
		{
			var screenWidth:int = stage.fullScreenWidth;
			var screenHeight:int = stage.fullScreenHeight;
			var viewPort:Rectangle = new flash.geom.Rectangle( 0, 0, screenWidth, screenHeight );

			var _starling:Starling = new Starling( DailyRun, this.stage, viewPort );
			_starling.stage.stageWidth = 480;
			_starling.stage.stageHeight = 320;
			_starling.start();
			Starling.current.nativeStage.frameRate = 30;
		}
	}	
}