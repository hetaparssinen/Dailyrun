package  {

import flash.media.SoundTransform;

import starling.utils.AssetManager;
import starling.display.Button;
import starling.events.Event;
import starling.display.Sprite;
import starling.display.Quad;
import starling.utils.deg2rad;
import starling.text.TextField;
import starling.display.Image;

/*
	* This class manages the Main Menu.
	* 
	* 
	*/
	public class MainMenu extends Sprite implements GameState {

		private var game:GameStateManager;
		private var assetManager:AssetManager;
		
		private var level1Button:Button;
		private var level2Button:Button;
		private var level3Button:Button;
		private var lifeLevelButton:Button;
		private var muteButton:Button;
		
		[Embed(source="assets/DKCodswallop.ttf", embedAsCFF="false", fontFamily="DK Codswallop")]
		private static const FontDK:Class;

		/*
		 * This function sets the gameState to the class that's being passed.
		 *
		 *
		 */
		public function MainMenu( game:GameStateManager ) {
			this.game = game;
			this.assetManager = game.getAssetManager();
			trace("Main Menu")
			
			drawMainMenu();
			
			level1Button.addEventListener( Event.TRIGGERED, level1Start );
			level2Button.addEventListener( Event.TRIGGERED, level2Start );
			level3Button.addEventListener( Event.TRIGGERED, level3Start );
			lifeLevelButton.addEventListener( Event.TRIGGERED, lifeLevelStart );
		}


		public function update(deltaTime:Number){
                }

		public function startPlaying(color:String){
                }

		public function level1Start( e:Event ):void {
			trace("Level 1 starting");
			trace(game.saveDataObject.data.mute);
			if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
			game.setGameState( Level1 );
		}
		
		public function level2Start( e:Event ):void {
			trace("Level 2 starting");
			if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
			game.setGameState( Level2 );
		}
		
		public function level3Start( e:Event ):void {
			trace("Level 3 starting");
			if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
			game.setGameState( Level3 );
		}
		
		public function lifeLevelStart( e:Event ):void {
			trace("Life level starting");
			if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
			game.setGameState( GoodLifeLevel );
		}
		
		public function mute( e:Event ):void {
			game.removeChild( muteButton );
			if ( game.saveDataObject.data.mute == false ) {
				game.saveDataObject.data.mute = true;
				game.saveDataObject.data.backgroundMusic.stop();
				muteButton = new Button( assetManager.getTexture( "noSound" ) );
			} else {
				game.saveDataObject.data.mute = false;
				game.saveDataObject.data.backgroundMusic = assetManager.playSound( "music", 0, 100, new SoundTransform( 0.2 ) );
				muteButton = new Button( assetManager.getTexture( "sound" ) );
			}
			initMuteButton();
		}
		
		public function drawMainMenu():void {
			var background:Quad = new Quad( game.stage.stageWidth, game.stage.stageHeight, 16776960 );
			//background.alpha = 0.8;
			game.addChild( background );
			
			var logo:Image = new Image (assetManager.getTexture("logo"));
			logo.rotation = deg2rad( -25 );
			logo.alignPivot("left", "center");
			logo.y = game.stage.stageHeight / 2 - 30;
			logo.x = 20;
			game.addChild( logo );
			
			level1Button = new Button( assetManager.getTexture( "button-pink" ), "LEVEL 1" );
			initButton( level1Button );
			level1Button.y = 10;
			game.addChild( level1Button );
			
			level2Button = new Button( assetManager.getTexture( "button-pink" ), "LEVEL 2" );
			initButton( level2Button );
			level2Button.y = 10 + level2Button.height + 5;
			if ( game.saveDataObject.data.level1passed == true ) {
				level2Button.enabled = true;
			} else {
				level2Button.enabled = false;
			}
			game.addChild( level2Button );
			
			level3Button = new Button( assetManager.getTexture( "button-pink" ), "LEVEL 3" );
			initButton( level3Button );
			level3Button.y = 10 + 2 * level3Button.height + 2 * 5;
			if ( game.saveDataObject.data.level2passed == true ) {
				level3Button.enabled = true;
			} else {
				level3Button.enabled = false;
			}
			game.addChild( level3Button );
			
			lifeLevelButton = new Button( assetManager.getTexture( "button-pink" ), "LIFE LEVEL" );
			initButton( lifeLevelButton );
			lifeLevelButton.y = 10 + 3 * lifeLevelButton.height + 3 * 5;
			game.addChild( lifeLevelButton );
			
			if ( game.saveDataObject.data.mute == false ) {
				muteButton = new Button( assetManager.getTexture( "sound" ) );
			} else {
				muteButton = new Button( assetManager.getTexture( "noSound" ) );
			}
			initMuteButton();
		}
		
		private function initButton( button:Button ):void {
			button.scale = 0.65;
			button.fontColor = 16776960;
			button.fontName = "DK Codswallop";
			button.fontSize = 54;
			button.alignPivot("center", "top");
			button.x = game.stage.stageWidth / 2 + 80;
		}
		
		private function initMuteButton():void {
			muteButton.x = 10;
			muteButton.y = game.stage.stageHeight - muteButton.height - 10;
			game.addChild( muteButton );
			muteButton.addEventListener( Event.TRIGGERED, mute );
		}
		

    }
}
