package  {
	import starling.display.Image;
	import starling.display.Quad;
	import starling.utils.AssetManager;
	import starling.text.TextField;
	import starling.display.Button;
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.core.Starling;
	
	public class LifeScreen {
		
		private var game:GameStateManager;
		
		private var assetManager:AssetManager;
		
		private var congratsText:TextField;
		private var continueButton:Button;
		
		private var readMoreItems:Array;

		public function LifeScreen( game:GameStateManager, items:Vector.<Image>, color:String) {
			this.game = game;
			assetManager = game.getAssetManager();
			removeContent();
			addLifeScreen( items, color );
			
			this.readMoreItems = new Array();
		}
		
		private function removeContent():void {
			while ( this.game.numChildren > 0 ) {
				this.game.removeChildAt( 0 );
			}
		}
		
		private function addLifeScreen( items:Vector.<Image>, color:String ):void {
			var foundItems:Vector.<Image> = items;
			
			var background:Image = new Image( assetManager.getTexture( "landscape4" ) ); 
			this.game.addChild( background );
			
	
			congratsText = new TextField( game.stage.stageWidth, 100, "Congratulations! You didn't get pregnant! Now it's easier to fulfill your dreams!", "Gotham Rounded",25, 16716947);
			congratsText.alignPivot();
			congratsText.y = 50;
			congratsText.x = game.stage.stageWidth / 2;
			this.game.addChild( congratsText );
			
			continueButton = new Button( assetManager.getTexture( "button-pink" ), "Start again");
			continueButton.fontSize = 44;
			continueButton.fontColor = 16776960;
			continueButton.fontName = "Gotham Rounded";
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

			if ( foundItems != null ) {
				for ( var i:int = 0; i < foundItems.length; i++ ) {
					foundItems[i].scale = 0.5;
					foundItems[i].alignPivot();
					if ( i > 3 ) {
						foundItems[i].y = game.stage.stageHeight - character.height + 50;
						foundItems[i].x = 140 + (i - 4) * 80;
					} else {
						foundItems[i].y = game.stage.stageHeight - character.height - 20;
						foundItems[i].x = 140 + i * 80;
					}
					this.game.addChild( foundItems[i] );
				}
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
			
			var restartButton:Button = new Button( assetManager.getTexture( "button-pink" ), "Go to Main Menu");
			restartButton.fontSize = 25;
			restartButton.fontColor = 16776960;
			restartButton.fontName = "Gotham Rounded";
			restartButton.alignPivot();
			restartButton.scale = 0.55;
			restartButton.x = this.game.stage.stageWidth / 2 - restartButton.width / 2 - 5;
			restartButton.y = congratsText.y + 70;
			this.game.addChild( restartButton );
			restartButton.addEventListener(Event.TRIGGERED, restartButtonClicked);
			
			var readMoreButton:Button = new Button( assetManager.getTexture( "button-pink" ), "Read More about peer presure");
			readMoreButton.fontSize = 25;
			readMoreButton.fontColor = 16776960;
			readMoreButton.fontName = "Gotham Rounded";
			readMoreButton.alignPivot();
			readMoreButton.scale = 0.55;
			readMoreButton.x = this.game.stage.stageWidth / 2 + readMoreButton.width / 2 + 5;
			readMoreButton.y = congratsText.y + 70;
			this.game.addChild( readMoreButton );
			readMoreButton.addEventListener(Event.TRIGGERED, readMoreButtonClicked);
			
			/*text = new TextField( 200, 30, "About peer pressure", "Gotham Rounded", 16, 16776960 );
			text.alignPivot("left", "center");
			text.y = readMoreButton.y + 40;
			text.x = readMoreButton.x - readMoreButton.width / 2 - 10;
			this.game.addChild( text );*/
		}
		
		private function restartButtonClicked():void {
			removeContent();
			this.game.setGameState( MainMenu );
		}
		
		private function readMoreButtonClicked():void {			
			var backgroundBlue:Quad = new Quad( this.game.stage.stageWidth - 20, this.game.stage.stageHeight - 20, 41701);
			backgroundBlue.alignPivot();
			backgroundBlue.x = this.game.stage.stageWidth / 2;
			backgroundBlue.y = this.game.stage.stageHeight/ 2;
			this.game.addChild( backgroundBlue );
			this.readMoreItems.push( backgroundBlue );
			
			var text:String = "Thank you for playing Daily Run! We hope you had fun while playing it. Of course fun is an important part in our game, but this game is also about having a good life.";
			addText( text, 65 );
			
			text = "Although pregnancy and having a child is one of the most beautiful things in life for a lot of people, it might be a good idea to not get children early in your life. Early pregnancy might let you drop out of school and get you in situations you don't want to be in. Without education and a stable life it's hard to find a job, take care for your children and fulfil the dreams you have about the future.";
			addText( text, 210 );
			
			var backButton = new Button( assetManager.getTexture( "arrowLeft" ) );
			backButton.x = 10;
			backButton.y = 20;
			this.game.addChild( backButton );
			this.readMoreItems.push( backButton );
			
			backButton.addEventListener( Event.TRIGGERED, goBack );
		}
		
		function addText( text:String, y:int ) {
			var story:TextField = new TextField( game.stage.stageWidth - 80, 200, text, "Gotham Rounded", 16, 0 );
			story.alignPivot();
			story.y = y;
			story.x = game.stage.stageWidth / 2;
			this.game.addChild( story );
			this.readMoreItems.push( story );
		}
		
		function goBack( e:Event ) {
			for ( var i:int = 0; i < this.readMoreItems.length; i++ ) {
				game.removeChild( readMoreItems[i] );
			}
		}
	}
	
}
