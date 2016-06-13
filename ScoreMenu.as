﻿package  
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	import starling.text.TextField;
	import starling.utils.AssetManager;

public class ScoreMenu extends Sprite
	{

		private var assetManager:AssetManager;
		private var game:GameStateManager;
		private var bikeButton:Button;
		private var guitarButton:Button;
		private var djembeButton:Button;
		private var laptopButton:Button;
		private var score:int;
		private var stageWidth;
		private var stageHeight;
		private var explanation;
		private var text;
		private var scoreText;
		private var scoreBike;
		private var scoreGuitar;
		private var scoreDjembe;
		private var scorelaptop;
		private var savedData:Array;
		private var objects:Array;
		
		public function ScoreMenu( game:GameStateManager, assetManager:AssetManager, score:int )
		{
			this.assetManager = assetManager;
			this.game = game;
			initializeBoughtItems();
			trace(savedData);
			this.stageWidth = game.stage.stageWidth;
			this.stageHeight = game.stage.stageHeight;
			this.score = score;
			this.addEventListener(Event.ADDED_TO_STAGE, Add);
		}
		
		private function initializeBoughtItems():void {
			if ( this.game.saveDataObject.data.boughtItems != null ) {
				savedData = this.game.saveDataObject.data.boughtItems;
			} else {
				savedData = new Array();
			}
		}
		
		private function Add(event:Event):void {
			draw();
		}
		
		private function draw():void {
			var background:Quad = new Quad( stageWidth, stageHeight, 123456 );
			background.alpha = 0.9;
			addChild( background );

			text = new TextField( 300, 100, "Well done!", "Verdana", 30, 0, true );
			text.alignPivot();
			text.x = stageWidth / 2;
			text.y = 50;
			addChild( text );

			scoreText = new TextField( 300, 100, "Score: " + score, "Verdana", 20 );
			scoreText.alignPivot();
			scoreText.x = stageWidth / 2;
			scoreText.y = 110;
			addChild( scoreText );
			
			explanation = new TextField( 300, 100, "Spend your points to buy some of the following items:",
			"Verdana", 17);
			explanation.alignPivot();
			explanation.x = stageWidth / 2;
			explanation.y = 160;
			addChild( explanation );
			
			bikeButton = new Button(assetManager.getTexture("bike"));
			guitarButton = new Button(assetManager.getTexture("guitar"));
			djembeButton = new Button(assetManager.getTexture("djembe"));
			laptopButton = new Button(assetManager.getTexture("laptop"));

			objects = new Array(bikeButton, guitarButton, djembeButton, laptopButton);
			
			for ( var i:int = 0; i < objects.length; i++) {
				var scoreText:TextField = new TextField( 300, 100, "You need " + (i + 1) + "0" , "Verdana", 10 );
				scoreText.alignPivot("center", "top");
				scoreText.height = 20;
				scoreText.y = 190;
				scoreText.x = this.game.stage.stageWidth / (objects.length + 1) + i * ( this.game.stage.stageWidth / (objects.length + 1) );
				this.addChild( scoreText );
				objects[i].alignPivot();
				objects[i].scale = 0.2;
				objects[i].y = 250;
				objects[i].x = this.game.stage.stageWidth / (objects.length + 1) + i * ( this.game.stage.stageWidth / (objects.length + 1) );
				this.addChild( objects[i] );
			}
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}		
		
		private function onMainMenuClick(event:Event):void
		{
			var buttonPress:Button = event.target as Button;
			if ( buttonPress == bikeButton && score >= 10 ) {
				removeContent();
				pushData("bike");
			} else if ( buttonPress == guitarButton && score >= 20 ) {
				removeContent();
				pushData("guitar");
			} else if ( buttonPress == djembeButton && score >= 30 ) {
				removeContent();
				pushData("djembe");
			} else if ( buttonPress == laptopButton && score >= 40 ) {
				removeContent();
				pushData("laptop");
			}
		}
		
		private function removeContent() {
			while ( this.numChildren > 0 ) {
				this.removeChildAt( 0 );
			}
			var background:Quad = new Quad( stageWidth, stageHeight, 123456 );
			background.alpha = 0.9;
			addChild( background );
		}
		
		private function pushData( object:String ) {
			savedData.push( object );
			game.saveDataObject.data.boughtItems = savedData;

			var continueScreen:ContinueScreen= new ContinueScreen( game, assetManager, score, object );
			addChild( continueScreen );
		}
	}
}