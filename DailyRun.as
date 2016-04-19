package  {

	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import flash.filesystem.File;
	
	/*
	* This class loads the assetManager and on completion starts the gamestate manager and passes the assetmanager.
	* 
	* 
	*/
	public class DailyRun extends Sprite
	{

		var assetManager:AssetManager;
		
		/*
		* This function checks if the class is being added to the stage.
		* 
		* 
		*/
		public function DailyRun() {
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		/*
		* This function loads the assetManager
		* 
		* 
		*/
		private function initialize()
		{
			assetManager = new AssetManager();
			var folder:File = File.applicationDirectory.resolvePath( "assets" );
			assetManager.enqueue( folder );
			assetManager.loadQueue( onProgress );
		}
		
		/*
		* This function checks if the assetManager had completed loading.
		* If so, it calls the startDailyRun function.
		* 
		*/
		private function onProgress( ratio:Number )
		{
			trace( ratio );
			
			if( ratio == 1 )
			{
				trace( "assetmanager loaded..")
				startDailyRun();
			}
		}
		
		/*
		* This function starts the Game State Manager.
		* 
		* 
		*/
		private function startDailyRun()
		{
			var gameStateManager:GameStateManager = new GameStateManager( assetManager );
			addChild( gameStateManager );
		}

	}
	
}
