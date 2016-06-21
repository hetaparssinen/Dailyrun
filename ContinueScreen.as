package  {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	import starling.text.TextField;
	import starling.utils.AssetManager;
	import flash.net.dns.ARecord;
	import starling.display.Image;

public class ContinueScreen extends Sprite
	{

		private var assetManager:AssetManager;
		private var game:GameStateManager;
		private var continueButton:Button;
		private var score:int;
		private var text;
		private var choosenObjects:Array;
		private var objectImage: Image;
		
		public function ContinueScreen( game, assetManager:AssetManager, score:int, choosenObjects:Array )
		{
			this.assetManager = assetManager;
			this.game = game;
			this.score = score;
			this.choosenObjects = choosenObjects;
			trace(choosenObjects);
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, Add);
		}
		
		private function Add(event:Event):void {
			draw();
		}
		
		private function draw():void {
			var background:Quad = new Quad( game.stage.stageWidth, game.stage.stageHeight, 15466636);
			addChild( background );
			text = new TextField (350, 100, "Great! Now you have this items  ", "Gotham Rounded", 20, 16776960);
			text.alignPivot();
			text.x = 250;
			text.y = 50;
			addChild( text );
			
			for (var i:int = 0; i < choosenObjects.length; i++) { 
				objectImage = new Image(assetManager.getTexture(choosenObjects[i]));
				objectImage.y = game.stage.stageHeight / 2 - objectImage.height/2;
				objectImage.alignPivot();
				objectImage.x = ( game.stage.stageWidth / ( choosenObjects.length + 1 ) ) * ( i + 1 );
				objectImage.scale = 0.5;
				addChild(objectImage);	
			}

			continueButton = new Button(assetManager.getTexture("button-yellow"));
			continueButton.text = " Go to next level ";
			continueButton.fontName = "Gotham Rounded ";
			continueButton.fontColor = 16716947;
			continueButton.fontSize = 30;
			continueButton.alignPivot();
			continueButton.scale = 0.8;
			continueButton.x = 240;
			continueButton.y = 250;
			this.addChild( continueButton );
			
			continueButton.addEventListener(Event.TRIGGERED, continueClick);
		}
		
		private function continueClick(event:Event):void
		{
			game.setGameState( MainMenu );
		}
		
	}
	
}
