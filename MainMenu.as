package  {
	
	/*
	* This class manages the Main Menu.
	* 
	* 
	*/
	public class MainMenu implements GameState
	{
		
		private var game:GameStateManager;
		
		/*
		* This function sets the gameState to the class that's being passed.
		* 
		* 
		*/
		public function MainMenu( game:GameStateManager )
		{
			this.game = game;
			trace( "You entered the main menu" );
		}
		
		public function update( deltaTime:Number )
		{
			//trace( deltaTime );
		}

	}
	
}
