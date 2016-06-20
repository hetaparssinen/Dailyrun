package  {
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	import starling.text.TextField;
	import starling.utils.AssetManager;

public class ContinueScreen extends Sprite
	{

		private var assetManager:AssetManager;
		private var game:GameStateManager;
		private var continueButton:Button;
		private var score:int;
		private var text;
		private var item:String;
		
		public function ContinueScreen( game, assetManager:AssetManager, score:int, item:String )
		{
			this.assetManager = assetManager;
			this.game = game;
			this.score = score;
			this.item = item;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, Add);
		}
		
		private function Add(event:Event):void {
			draw();
		}
		
		private function draw():void {
			var background:Quad = new Quad( game.stage.stageWidth, game.stage.stageHeight, 123456 );
			background.alpha = 0.9;
			addChild( background );

			text = new TextField( 300, 100, "GREAT, now you have a " + this.item + "!!", "Verdana", 30, 0, true );
			text.alignPivot();
			text.x = 250;
			text.y = 50;
			addChild( text );

			var explanation:TextField = new TextField( 300, 100, "Go to Next Level, good luck",
			"Verdana", 17);
			explanation.alignPivot();
			explanation.x = 250;
			explanation.y = 175;
			addChild( explanation );

			continueButton = new Button(assetManager.getTexture("button-pink"));
			continueButton.text = "Go to next level!";
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
			/*
			trace(this.game.currentState() + " current state");
			// Remove all content from current game
			while ( this.game.numChildren > 0 ) {
				this.game.removeChildAt( 0 );
			}
			// Start a new game
			var newLevel:DailyRun = new DailyRun();
			this.game.addChild(newLevel);
			*/
		}
		
	}
	
}
