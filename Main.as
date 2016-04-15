package  {
	
	import flash.display.MovieClip;
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
			var _starling:Starling = new Starling( DailyRun, this.stage );
			_starling.start();
		}
	}
	
}