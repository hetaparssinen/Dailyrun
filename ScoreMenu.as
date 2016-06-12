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
		private var object1:Button;
		private var object2:Button;
		private var object3:Button;
		private var object4:Button;
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
		
		public function ScoreMenu( game:GameStateManager, assetManager:AssetManager, score:int )
		{
			this.assetManager = assetManager;
			this.game = game;
			initializeBoughtItems();
			trace(savedData);
			this.stageWidth = game.stage.stageWidth;
			this.stageHeight = game.stage.stageHeight;
			this.score = score;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, Add);
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
			
			scoreBike = new TextField( 300, 100, "You need 10", "Verdana", 10 );
			scoreBike.alignPivot();
			scoreBike.x = 75;
			scoreBike.y = 200;
			addChild( scoreBike );
			
			scoreGuitar = new TextField( 300, 100, "You need 20", "Verdana", 10 );
			scoreGuitar.alignPivot();
			scoreGuitar.x = 190;
			scoreGuitar.y = 200;
			addChild( scoreGuitar );
			
			scoreDjembe = new TextField( 300, 100, "You need 30", "Verdana", 10 );
			scoreDjembe.alignPivot();
			scoreDjembe.x = 290;
			scoreDjembe.y = 200;
			addChild( scoreDjembe );
			
			scorelaptop = new TextField( 300, 100, "You need 40", "Verdana", 10 );
			scorelaptop.alignPivot();
			scorelaptop.x = 400;
			scorelaptop.y = 200;
			addChild( scorelaptop );
			

			object1 = new Button(assetManager.getTexture("Bike"));
			object1.alignPivot();
			object1.scale = 0.2;
			object1.x = 80;
			object1.y = 250;
			this.addChild(object1);
			
			object2 = new Button(assetManager.getTexture("Guitar"));
			object2.alignPivot();
			object2.scale = 0.2;
			object2.x = 192;
			object2.y = 250;
			this.addChild(object2);
			
			object3 = new Button(assetManager.getTexture("Djembe"));
			object3.alignPivot();
			object3.scale = 0.2;
			object3.x = 288;
			object3.y = 250;
			this.addChild(object3);
			
			object4 = new Button(assetManager.getTexture("laptop"));
			object4.alignPivot();
			object4.scale = 0.2;
			object4.x = 384;
			object4.y = 250;
			this.addChild(object4);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		
		private function onMainMenuClick(event:Event):void
		{
			
			var buttonPress:Button = event.target as Button;
			if((buttonPress as Button) == object1) 
			{
				trace (score);
				if (score >= 10)
				{
					removeContent();
					
					savedData.push( "Bike" );
					game.saveDataObject.data.boughtItems = savedData;
		
					var screen1:Screen1 = new Screen1( assetManager, score );
					addChild( screen1 );
				}
					//this.dispatchEvent(new PressEvent(PressEvent.newScreen, {id:"none2"}, true));
			
			}
			
			if ((buttonPress as Button ) == object2)
				{
				trace (score);
				if (score >= 20)
				{
					removeContent();
					
					savedData.push( "Guitar" );
					game.saveDataObject.data.boughtItems = savedData;
		
					var screen2:Screen2 = new Screen2 (assetManager, score );
					addChild( screen2 );
				}
			}
			
			if ((buttonPress as Button) == object3)
				{
				trace (score);
				if (score >= 30)
				{
					removeContent();
					
					savedData.push( "Djembe" );
					game.saveDataObject.data.boughtItems = savedData;
		
					var screen3:Screen3 = new Screen3 (assetManager, score );
					addChild( screen3 );
				}
			}
			if ((buttonPress as Button) == object4)
				{
				trace (score);
				if (score >= 40)
				{
					removeContent();
					
					savedData.push( "laptop" );
					game.saveDataObject.data.boughtItems = savedData;
		
					var screen4:Screen4 = new Screen4(assetManager, score );
					addChild( screen4);
				}
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
	}
}