﻿
package {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import starling.display.Image;

	public class ScoreMenu extends Sprite {

		private var assetManager: AssetManager;
		private var game: GameStateManager;
		private var bikeButton: Button;
		private var phoneButton: Button;
		private var djembeButton: Button;
		private var laptopButton: Button;
		private var houseButton: Button;
		private var carButton: Button;
		private var gradutaionButton: Button;
		private var coinsButton: Button;
		private var earphonesButton: Button;
		private var score: int;
		private var stageWidth;
		private var stageHeight;
		private var explanation : TextField;
		private var wellDone: Image;
		private var scoreText;
		private var savedData: Array;
		private var objects: Array;
		public var choosenObjects: Array;
		private var continueButton: Button;
		
		[Embed(source = "assets/GothamRounded-Medium.otf", embedAsCFF = "false", fontFamily = "Gotham Rounded")]
		private static const FontGR: Class;

		public function ScoreMenu(game: GameStateManager, assetManager: AssetManager, score: int) {
			this.assetManager = assetManager;
			this.game = game;
			initializeBoughtItems();
			trace(savedData);
			this.stageWidth = game.stage.stageWidth;
			this.stageHeight = game.stage.stageHeight;
			this.choosenObjects = new Array();
			this.score = score;
			this.addEventListener(Event.ADDED_TO_STAGE, Add);
		}

		private function initializeBoughtItems(): void {
			if (this.game.saveDataObject.data.boughtItems != null) {
				savedData = this.game.saveDataObject.data.boughtItems;
			} else {
				savedData = new Array();
			}
		}

		private function Add(event: Event): void {
			draw();
		}

		private function draw(): void {
			var background: Quad = new Quad(stageWidth, stageHeight, 15466636);
			addChild(background);

			wellDone = new Image(assetManager.getTexture("wellDone"));
			wellDone.x = stageWidth / 2;
			wellDone.y = 30;
			wellDone.scale = 1.5;
			wellDone.alignPivot();
			addChild(wellDone);
			
			updateScore(score);
			
			addText("Spend your points to buy some of the following items ");
			
			continueButton = new Button( assetManager.getTexture("button-yellow"));
			continueButton.text = " Continue ";
			continueButton.fontName = "Gotham Rounded";
			continueButton.fontColor = 16716947;
			continueButton.fontSize = 30;
			continueButton.y = 80 ;
			continueButton.x = game.stage.stageWidth / 2 - continueButton.width / 5;
			continueButton.scale = 0.4;
			
			bikeButton = new Button(assetManager.getTexture("bike"));
			phoneButton = new Button(assetManager.getTexture("phone"));
			djembeButton = new Button(assetManager.getTexture("djembe"));
			laptopButton = new Button(assetManager.getTexture("laptop"));
			houseButton = new Button(assetManager.getTexture("house"));
			carButton = new Button(assetManager.getTexture("car"));
			coinsButton = new Button(assetManager.getTexture("coins"));
			earphonesButton = new Button(assetManager.getTexture("earphones"));

			objects = new Array(earphonesButton, djembeButton, phoneButton, laptopButton, bikeButton, coinsButton, carButton, houseButton);

			for (var i: int = 0; i < objects.length; i++) {
				if( i < 4) {
					var scoreText: TextField = new TextField(300, 20, "You need " + (i + 1)* 10, 
					"Gotham Rounded", 10, 16776960);
				} else if (i >= 4 && i < 6) {
					var scoreText: TextField = new TextField(300, 20, "You need " + i * 20, 
					"Gotham Rounded", 10, 16776960);
				} else if( i==6 ){
					var scoreText: TextField = new TextField(300, 20, "You need " + 110, 
					"Gotham Rounded", 10, 16776960);
				} else {
					var scoreText: TextField = new TextField(300, 20, "You need " + 130, 
					"Gotham Rounded", 10, 16776960);
				}
				scoreText.alignPivot("center", "top");
				scoreText.height = 20;
				if(i < 4)
				{
					scoreText.y = 120;
					scoreText.x = this.game.stage.stageWidth / (objects.length / 2 + 1) + i * (this.game.stage.stageWidth / (objects.length / 2 + 1));
					objects[i].y = 180;
					objects[i].x = this.game.stage.stageWidth / (objects.length / 2 + 1) + i * (this.game.stage.stageWidth / (objects.length / 2 + 1));
					objects[i].alignPivot();
					objects[i].scale = 0.5;
				}
				else
				{
					scoreText.y = 230;
					scoreText.x = this.game.stage.stageWidth / (objects.length / 2 + 1) + (i-4) * (this.game.stage.stageWidth / (objects.length / 2 + 1));
					objects[i].y = 280;
					objects[i].x = this.game.stage.stageWidth / (objects.length / 2 + 1) + (i-4) * (this.game.stage.stageWidth / (objects.length / 2 + 1));
					objects[i].alignPivot();
					objects[i].scale = 0.5;
				}
				this.addChild(scoreText);
				this.addChild(objects[i]);
			}

			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}

		private function onMainMenuClick(event: Event): void {
			var buttonPress: Button = event.target as Button;
			trace ( buttonPress );
			if (buttonPress == earphonesButton ) {
				clickItem( "earphones", 10 );
			} else if (buttonPress == djembeButton ) {
				clickItem( "djembe", 20 ); 
			} else if (buttonPress == phoneButton ) {
				clickItem( "phone", 30 );
			} else if (buttonPress == laptopButton ) {
				clickItem( "laptop", 40 );
			} else if( buttonPress == bikeButton ) {
				clickItem( "bike", 80 );
			} else if( buttonPress == coinsButton ) {
				clickItem( "coins", 90 );
			} else if( buttonPress == carButton ) {
				clickItem( "car", 110 );
			} else if( buttonPress == houseButton ) {
				clickItem( "house", 140 );
			} 
			if( score == 0 ) {
				addText("");
				addChild( continueButton );
				addEventListener(Event.TRIGGERED, onContinueButtonClicked);
			}
			
			
			game.saveDataObject.data.totalScore = score;

		}
		
		private function onContinueButtonClicked(e:Event): void {
				
				removeContent();	
				var continueScreen: ContinueScreen = new ContinueScreen(game, assetManager, score, choosenObjects);
				addChild(continueScreen);
		}
		
		private function updateScore(score: int)
			{
				removeChild(scoreText);
				this.score = score;
				if(this.score >= 10 ) {
					scoreText = new TextField(300, 30, "Points: " + score, "Gotham Rounded", 15, 16776960, true);
				} 
				else {
					
					scoreText = new TextField(300, 30, "You don't have points anymore", "Gotham Rounded", 15, 16776960, true);			
				}
				scoreText.alignPivot();
				scoreText.x = stageWidth / 2;
				scoreText.y = 70;
				addChild(scoreText);
			}


		private function removeContent() {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}		}

		private function pushData(object: String) {
			savedData.push(object);
			game.saveDataObject.data.boughtItems = savedData;

		}
		private function addText( text: String ) {
				removeChild( explanation );
				explanation = new TextField(450, 50, text, "Gotham Rounded", 15, 16776960);
				explanation.alignPivot();
				explanation.x = stageWidth / 2 ;
				explanation.y = 100;
				addChild(explanation);
			}
		private function clickItem( item:String, neededScore:int ) {
			if ( this.score >= neededScore ) {
				if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
				pushData( item );
				choosenObjects.push( item );
				updateScore( score - neededScore );
				addText("Spend your points to buy some of the following items " );
			} else if(this.score < neededScore ){
				addText("You don't have enough points to buy a " + item );
				
			} 
		}
	}
}