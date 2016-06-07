package  {
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.events.TouchEvent;

	
	/*
	* This class manages the state of the game, such as the Main Menu Screen, High Score Screen,
	* the levels, etc.
	*
	*/
	public class GameStateManager extends Sprite
	{

		private var currentGameState:GameState;
		private var lastUpdate:int;
		private var assetManager:AssetManager;
		
		/*
		* This function sets the assetmanager and checks if the class is being added to the stage.
		* 
		* @param assetManager	This parameter holds the assetManager with all the assets.
		*/
		public function GameStateManager( assetManager:AssetManager ):void
		{
			this.assetManager = assetManager;
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}

		public function getAssetManager():AssetManager
		{
			return this.assetManager;
		}
		
		/*
		* This function sets the initial gameState (Main Menu) and adds an eventlistener
		* for entering a stage (for updating).
		* 
		*/
		private function initialize():void
		{
			setGameState( Level1 );
			addEventListener( Event.ENTER_FRAME, update );
		}
		
		/*
		* This function sets the gameState to the class that's being passed.
		* 
		* @param nextState	This is the class which will be the next game state.
		*/
		public function setGameState( nextState:Class ):void
		{
			currentGameState = new nextState( this );
		}
		
		/*
		* This function is called when entering a new frame. It calculates the time that is passed
		* since the last update and calls the update function from the current game state.
		* 
		*/
		private function update():void
		{
			var currentTime:int = new Date().getTime();
			var deltaTime:Number = ( currentTime - lastUpdate ) / 1000;
			
			currentGameState.update( deltaTime );
			
			lastUpdate = currentTime;
		}

	}
	
}
