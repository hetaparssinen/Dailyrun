package  {

import starling.utils.AssetManager;

/*
	* This class manages the Main Menu.
	* 
	* 
	*/
	public class MainMenu implements GameState {

		private var game:GameStateManager;
		private var assetManager:AssetManager;

		/*
		 * This function sets the gameState to the class that's being passed.
		 *
		 *
		 */
		public function MainMenu(game:GameStateManager) {
			this.game = game;
			this.assetManager = game.getAssetManager();
			trace("Main Menu")
			
			game.setGameState( MainMenu );
		}

		public function update(deltaTime:Number)
		{
		}
    }
}
