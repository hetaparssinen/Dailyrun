package  {
	import starling.display.Image;
	import starling.display.Quad;
	import starling.utils.AssetManager;
	import starling.text.TextField;
	import starling.display.Button;
	import starling.events.Event;
	
	public class LifeScreen {
		
		private var game:GameStateManager;
		
		private var assetManager:AssetManager;
		
		private var congratsText:TextField;
		private var continueButton:Button;

		public function LifeScreen( game:GameStateManager, items:Vector.<Image>, color:String) {
			this.game = game;
			assetManager = game.getAssetManager();
			removeContent();
			addLifeScreen( items, color );
		}
		
		private function removeContent():void {
			while ( this.game.numChildren > 0 ) {
				this.game.removeChildAt( 0 );
			}
		}
		
		private function addLifeScreen( items:Vector.<Image>, color:String ):void {
			var foundItems:Vector.<Image> = items;

			var background:Image = new Image( assetManager.getTexture( "landscape_size ok" ) ); 
			this.game.addChild( background );
			
			congratsText = new TextField( game.stage.stageWidth, 200, "CONGRATULATIONS!", "DK Codswallop", 44 );
			congratsText.color = 15466636;
			congratsText.alignPivot();
			congratsText.y = 50;
			congratsText.x = game.stage.stageWidth / 2;
			this.game.addChild( congratsText );
			
			continueButton = new Button( assetManager.getTexture( "button-pink" ), "CONTINUE");
			continueButton.fontSize = 44;
			continueButton.fontColor = 41701;
			continueButton.fontName = "DK Codswallop";
			continueButton.alignPivot();
			continueButton.scale = 0.55;
			continueButton.x = this.game.stage.stageWidth / 2;
			continueButton.y = congratsText.y + 70;
			this.game.addChild(continueButton);
			continueButton.addEventListener(Event.TRIGGERED, continueButtonClicked);
			
			var character:Image = new Image( assetManager.getTexture( color ) );
			character.alignPivot();
			character.scale = 1.5;
			character.x = 50;
			character.y = game.stage.stageHeight - character.height;
			this.game.addChild( character );

			for ( var i:int = 0; i < foundItems.length; i++ ) {
				foundItems[i].scale = 0.2;
				foundItems[i].alignPivot();
				foundItems[i].x = 140 + i * 70;
				foundItems[i].y = game.stage.stageHeight - character.height;
				this.game.addChild( foundItems[i] );
			}
		}
		
		private function continueButtonClicked():void {
			this.game.removeChild( congratsText );
			this.game.removeChild( continueButton );
			
			var text:TextField = new TextField( this.game.stage.stageWidth, 200, "You passed all levels! Now you can enjoy the items that you have collected to your life.", "Comic Sans MS", 18 );
			text.color = 15466636;
			text.alignPivot();
			text.y = 45;
			text.x = this.game.stage.stageWidth / 2;
			this.game.addChild( text );
			
			var restartButton:Button = new Button( assetManager.getTexture( "button-pink" ), "MAIN MENU");
			restartButton.fontSize = 44;
			restartButton.fontColor = 41701;
			restartButton.fontName = "DK Codswallop";
			restartButton.alignPivot();
			restartButton.scale = 0.55;
			restartButton.x = this.game.stage.stageWidth / 2 - restartButton.width / 2 - 5;
			restartButton.y = congratsText.y + 70;
			this.game.addChild( restartButton );
			restartButton.addEventListener(Event.TRIGGERED, restartButtonClicked);
			
			var readMoreButton:Button = new Button( assetManager.getTexture( "button-pink" ), "READ MORE");
			readMoreButton.fontSize = 44;
			readMoreButton.fontColor = 41701;
			readMoreButton.fontName = "DK Codswallop";
			readMoreButton.alignPivot();
			readMoreButton.scale = 0.55;
			readMoreButton.x = this.game.stage.stageWidth / 2 + readMoreButton.width / 2 + 5;
			readMoreButton.y = congratsText.y + 70;
			this.game.addChild( readMoreButton );
			readMoreButton.addEventListener(Event.TRIGGERED, readMoreButtonClicked);
			
			text = new TextField( 200, 30, "About peer pressure", "Comic Sans MS", 16, 41701 );
			text.alignPivot("left", "center");
			text.y = readMoreButton.y + 40;
			text.x = readMoreButton.x - readMoreButton.width / 2 - 10;
			this.game.addChild( text );
		}
		
		private function restartButtonClicked():void {
			// Remove all content from current game
			while ( this.game.numChildren > 0 ) {
				this.game.removeChildAt( 0 );
			}
			// Start a new game
			var newGame:DailyRun = new DailyRun();
			this.game.addChild(newGame);
		}
		
		private function readMoreButtonClicked():void {
			while ( this.game.numChildren > 0 ) {
				this.game.removeChildAt( 0 );
			}
			
			var background:Image = new Image( assetManager.getTexture( "landscape_size ok" ) ); 
			this.game.addChild( background );
			
			var backgroundBlue:Quad = new Quad( this.game.stage.stageWidth - 40, this.game.stage.stageHeight - 40, 41701);
			backgroundBlue.alignPivot();
			backgroundBlue.x = this.game.stage.stageWidth / 2;
			backgroundBlue.y = this.game.stage.stageHeight/ 2;
			this.game.addChild( backgroundBlue );
			
			var text:String = "Something...... or then no?";
			var story:TextField = new TextField( 200, 200, text, "Comic Sans MS", 16, 15466636 );
			story.alignPivot();
			story.y = 40;
			story.x = game.stage.stageWidth / 2;
			this.game.addChild( story );
		}
		
		
	}
	
}
