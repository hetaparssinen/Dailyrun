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
		private var clearDataButton:Button;
		private var confirmButton:Button;
		private var cancelButton:Button;
		
		private var confirmItems:Array;
		
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
			
			confirmItems = new Array();
			
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
			if ( game.saveDataObject.data.mute != true ) {
				game.saveDataObject.data.mute = true;
				game.saveDataObject.data.backgroundMusic.stop();
				muteButton = new Button( assetManager.getTexture( "soundOff" ) );
			} else {
				game.saveDataObject.data.mute = false;
				game.saveDataObject.data.backgroundMusic = assetManager.playSound( "music", 0, 100, new SoundTransform( 0.2 ) );
				muteButton = new Button( assetManager.getTexture( "soundOn" ) );
			}
			initMuteButton();
		}
		
		public function drawMainMenu():void {
			var background:Quad = new Quad( game.stage.stageWidth, game.stage.stageHeight, 16776960 );
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
			
			if ( game.saveDataObject.data.mute != true ) {
				muteButton = new Button( assetManager.getTexture( "soundOn" ) );
			} else {
				muteButton = new Button( assetManager.getTexture( "soundOff" ) );
			}
			initMuteButton();
			
			clearDataButton = new Button( assetManager.getTexture( "button-yellow" ), "NEW GAME" );
			clearDataButton.scale = 0.35;
			clearDataButton.fontName = "DK Codswallop";
			clearDataButton.fontSize = 48;
			clearDataButton.fontColor = 15466636;
			clearDataButton.x = 10;
			clearDataButton.y = game.stage.stageHeight - clearDataButton.height - 10;
			game.addChild( clearDataButton );
			
			clearDataButton.addEventListener( Event.TRIGGERED, clearData );
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
			muteButton.y = 10;
			game.addChild( muteButton );
			muteButton.addEventListener( Event.TRIGGERED, mute );
		}
		
		private function clearData() {
			var background:Quad = new Quad( this.game.stage.stageWidth - 40, this.game.stage.stageHeight - 40, 15466636 );
			background.alpha = 0.9;
			background.alignPivot();
			background.x = this.game.stage.stageWidth / 2;
			background.y = this.game.stage.stageHeight/ 2;
			this.game.addChild( background );
			confirmItems.push( background );
			
			var text:TextField = new TextField( this.game.stage.stageWidth - 200, 100, "All your objects will be gone.", "Gotham Rounded", 24 );
			text.x = this.game.stage.stageWidth / 2;
			text.y = this.game.stage.stageHeight/ 2 - 50;
			text.alignPivot();
			this.game.addChild( text );
			confirmItems.push( text );
			
			cancelButton = new Button( assetManager.getTexture( "button-yellow" ), "CANCEL" );
			initConfirmButton( cancelButton );
			cancelButton.x = game.stage.stageWidth / 2 - cancelButton.width / 2;
			confirmItems.push( cancelButton );
			
			confirmButton = new Button( assetManager.getTexture( "button-yellow" ), "NEW GAME" );
			initConfirmButton( confirmButton );
			confirmItems.push( confirmButton );
			
			confirmButton.addEventListener( Event.TRIGGERED, confirm );
			cancelButton.addEventListener( Event.TRIGGERED, calcel );
		}
		
		function initConfirmButton( button:Button ) {
			button.scale = 0.5;
			button.fontName = "DK Codswallop";
			button.fontSize = 48;
			button.fontColor = 15466636;
			button.alignPivot();
			button.x = game.stage.stageWidth / 2 + button.width / 2;
			button.y = game.stage.stageHeight / 2 + 50;
			game.addChild( button );
		}
		
		function calcel( e:Event ) {
			for ( var i:int = 0; i < confirmItems.length; i++ ) {
				game.removeChild( confirmItems[i] );
			}
		}
		
		function confirm( e:Event ) {
			game.saveDataObject.clear();
			while ( game.numChildren > 0 ) {
				game.removeChildAt( 0 );
			}
			var dailyrun:DailyRun = new DailyRun();
			game.addChild( dailyrun );
		}
    }
}
