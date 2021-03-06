﻿package  {

import flash.media.SoundTransform;

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
		var loader:Loader;
		
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
			loader = new Loader();
			addChild( loader );
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
			loader.update( ratio );
			
			if( ratio == 1 )
			{
				trace( "assetmanager loaded..")
				removeChild( loader );
				startDailyRun();
			}
		}
		
		/*
		* This function starts the Game State Manager and starts the music
		* 
		* 
		*/
		private function startDailyRun()
		{
			var gameStateManager:GameStateManager = new GameStateManager( assetManager );
			addChild( gameStateManager );
			if ( gameStateManager.saveDataObject.data.mute != true ) {
				gameStateManager.saveDataObject.data.backgroundMusic = assetManager.playSound( "music", 0, 100, new SoundTransform( 0.2 ) );
			}
		}

	}
	
}
