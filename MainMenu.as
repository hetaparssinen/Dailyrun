package  {

import starling.utils.AssetManager;
import starling.display.Button;
import flash.net.drm.AddToDeviceGroupSetting;
import starling.textures.Texture;
import starling.events.Event;
import starling.display.Sprite;

/*
	* This class manages the Main Menu.
	* 
	* 
	*/
	public class MainMenu extends Sprite {

		private var game:GameStateManager;
		private var assetManager:AssetManager;
		
		private var level1Button:Button;
		private var lifeLevelButton:Button;

		/*
		 * This function sets the gameState to the class that's being passed.
		 *
		 *
		 */
		public function MainMenu( game:GameStateManager ) {
			this.game = game;
			this.assetManager = game.getAssetManager();
			trace("Main Menu")
			
			//game.setGameState( MainMenu );
			
			drawMainMenu();
			
			level1Button.addEventListener( Event.TRIGGERED, level1Start);
			lifeLevelButton.addEventListener( Event.TRIGGERED, lifeLevelStart);
		}

		public function update(deltaTime:Number)
		{
		}
		
		public function level1Start( e:Event ):void {
			trace("Level 1 starting");
			game.setGameState( Level1 );
		}
		
		public function lifeLevelStart( e:Event ):void {
			trace("Life level starting");
			game.setGameState( GoodLifeLevel );
		}
		
		public function drawMainMenu():void {
			level1Button = new Button( assetManager.getTexture( "button-pink" ) );
			level1Button.text = "Level 1";
			game.addChild( level1Button );
			
			lifeLevelButton = new Button( assetManager.getTexture( "button-pink" ) );
			lifeLevelButton.text = "Life level";
			lifeLevelButton.y = lifeLevelButton.height * 2;
			game.addChild( lifeLevelButton );
		}
		

    }
}
