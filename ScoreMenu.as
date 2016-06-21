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
		private var explanation;
		private var wellDone: Image;
		private var scoreText;
		private var scoreBike;
		private var scorePhone;
		private var scoreDjembe;
		private var scorelaptop;
		private var savedData: Array;
		private var objects: Array;
		[Embed(source = "assets/GothamRounded-Medium.otf", embedAsCFF = "false", fontFamily = "Gotham Rounded")]
		private static const FontGR: Class;

		public function ScoreMenu(game: GameStateManager, assetManager: AssetManager, score: int) {
			this.assetManager = assetManager;
			this.game = game;
			initializeBoughtItems();
			trace(savedData);
			this.stageWidth = game.stage.stageWidth;
			this.stageHeight = game.stage.stageHeight;
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
			var background: Quad = new Quad(stageWidth, stageHeight, 16716947);
			background.alpha = 0.9;
			addChild(background);

			wellDone = new Image(assetManager.getTexture("wellDone"));
			wellDone.x = stageWidth / 2;
			wellDone.y = 30;
			wellDone.scale = 1.5;
			wellDone.alignPivot();
			addChild(wellDone);
			
			scoreText = new TextField(300, 30, "Score: " + score, "Gotham Rounded", 15, 16776960);
			scoreText.alignPivot();
			scoreText.x = stageWidth / 2;
			scoreText.y = 70;
			addChild(scoreText);

			explanation = new TextField(300, 50, "Spend your points to buy some of the following items:",
				"Gotham Rounded", 15, 16776960);
			explanation.alignPivot();
			explanation.x = stageWidth / 2;
			explanation.y = 100;
			addChild(explanation);

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
				
				var scoreText: TextField = new TextField(300, 20, "You need " + (i + 1)* 10, 
				"Gotham Rounded", 10, 16776960);
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
					trace(objects[i].y + "////" + objects[i].x);
				}
				else
				{
					scoreText.y = 230;
					scoreText.x = this.game.stage.stageWidth / (objects.length / 2 + 1) + (i-4) * (this.game.stage.stageWidth / (objects.length / 2 + 1));
					objects[i].y = 280;
					objects[i].x = this.game.stage.stageWidth / (objects.length / 2 + 1) + (i-4) * (this.game.stage.stageWidth / (objects.length / 2 + 1));
					objects[i].alignPivot();
					objects[i].scale = 0.5;
					trace(objects[i].y + "////" + objects[i].x);
				}
				this.addChild(scoreText);
				this.addChild(objects[i]);
			}

			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}

		private function onMainMenuClick(event: Event): void {
			var buttonPress: Button = event.target as Button;
			if (buttonPress == bikeButton && score >= 10) {
				removeContent();
				if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
				pushData("bike");
				score -= 10;
				trace(score);
			} else if (buttonPress == phoneButton && score >= 20) {
				removeContent();
				if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
				pushData("phone");
				score = score - 20;
			} else if (buttonPress == djembeButton && score >= 30) {
				removeContent();
				if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
				pushData("djembe");
				score = score - 30;
			} else if (buttonPress == laptopButton && score >= 40) {
				removeContent();
				if ( !game.saveDataObject.data.mute ) assetManager.playSound( "mouseClick" );
				pushData("laptop");
				score = score - 40;
			}
			game.saveDataObject.data.totalScore = score;

		}

		private function removeContent() {
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			var background: Quad = new Quad(stageWidth, stageHeight, 123456);
			background.alpha = 0.9;
			addChild(background);
		}

		private function pushData(object: String) {
			savedData.push(object);
			game.saveDataObject.data.boughtItems = savedData;

			var continueScreen: ContinueScreen = new ContinueScreen(game, assetManager, score, object);
			addChild(continueScreen);
		}
	}
}