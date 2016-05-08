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
			var _starling:Starling = new Starling( DailyRun, this.stage, new flash.geom.Rectangle(0, 0, 480, 320 ) );
			_starling.start();
			Starling.current.nativeStage.frameRate = 30;
		}
	}
	
}