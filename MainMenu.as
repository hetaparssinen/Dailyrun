package  {

import starling.utils.AssetManager;
import starling.display.Button;
import flash.net.drm.AddToDeviceGroupSetting;
import starling.textures.Texture;
import starling.events.Event;
import starling.display.Sprite;
import starling.display.Quad;

/*
	* This class manages the Main Menu.
	* 
	* 
	*/
	public class MainMenu extends Sprite {

		private var game:GameStateManager;
		private var assetManager:AssetManager;
		
		private var level1Button:Button;
		private var level2Button:Button;
		private var level3Button:Button;
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
			
			level1Button.addEventListener( Event.TRIGGERED, level1Start );
			level2Button.addEventListener( Event.TRIGGERED, level2Start );
			level3Button.addEventListener( Event.TRIGGERED, level3Start );
			lifeLevelButton.addEventListener( Event.TRIGGERED, lifeLevelStart );
		}

		/*public function update(deltaTime:Number)
		{
		}*/
		
		public function level1Start( e:Event ):void {
			trace("Level 1 starting");
			game.setGameState( Level1 );
		}
		
		public function level2Start( e:Event ):void {
			trace("Level 2 starting");
			game.setGameState( Level2 );
		}
		
		public function level3Start( e:Event ):void {
			trace("Level 3 starting");
			game.setGameState( Level3 );
		}
		
		public function lifeLevelStart( e:Event ):void {
			trace("Life level starting");
			game.setGameState( GoodLifeLevel );
		}
		
		public function drawMainMenu():void {
			var background:Quad = new Quad( game.stage.stageWidth, game.stage.stageHeight, 123456 );
			background.alpha = 0.9;
			game.addChild( background );
			
			level1Button = new Button( assetManager.getTexture( "button-pink" ) );
			level1Button.text = "Level 1";
			level1Button.scale = 0.8;
			trace("height " + level1Button.height);
			trace( game.stage.stageHeight + " stage ");
			level1Button.alignPivot("center", "top");
			level1Button.x = game.stage.stageWidth / 2;
			level1Button.y = 10;
			game.addChild( level1Button );
			
			level2Button = new Button( assetManager.getTexture( "button-pink" ) );
			level2Button.text = "Level 2";
			level2Button.scale = 0.8;
			level2Button.alignPivot("center", "top");
			level2Button.x = game.stage.stageWidth / 2;
			level2Button.y = 10 + level2Button.height + 5;
			game.addChild( level2Button );
			
			level3Button = new Button( assetManager.getTexture( "button-pink" ) );
			level3Button.text = "Level 3";
			level3Button.scale = 0.8;
			level3Button.alignPivot("center", "top");
			level3Button.x = game.stage.stageWidth / 2;
			level3Button.y = 10 + 2 * level3Button.height + 2 * 5;
			game.addChild( level3Button );
			
			lifeLevelButton = new Button( assetManager.getTexture( "button-pink" ) );
			lifeLevelButton.text = "Life level";
			lifeLevelButton.scale = 0.8;
			lifeLevelButton.alignPivot("center", "top");
			lifeLevelButton.x = game.stage.stageWidth / 2;
			lifeLevelButton.y = 10 + 3 * lifeLevelButton.height + 3 * 5;
			game.addChild( lifeLevelButton );
		}
		

    }
}
