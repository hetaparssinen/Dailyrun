package  {
import starling.display.Quad;
import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
import starling.text.TextField;
import starling.utils.AssetManager;

public class Screen1 extends Sprite
	{

		private var assetManager:AssetManager
		private var object1:Button;
		private var score:int;
		private var stageWidth;
		private var stageHeight;
		private var text;
		
		public function Screen1( assetManager:AssetManager, score:int )
		{
			this.assetManager = assetManager
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			this.score = score;
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, Add);
		}
		
		private function Add(event:Event):void {
			draw();
		}
		
		private function draw():void {
			var background:Quad = new Quad( stageWidth, stageHeight, 123456 );
			background.alpha = 0.9;
			addChild( background );

			text = new TextField( 300, 100, "GREAT, now you have a bike!!", "Verdana", 30, 0, true );
			text.alignPivot();
			text.x = 250;
			text.y = 50;
			addChild( text );

			/*var scoreText:TextField = new TextField( 300, 100, "Score: " + score, "Verdana", 20 );
			scoreText.alignPivot();
			scoreText.x =  2;
			scoreText.y = 110;
			addChild( scoreText );*/

			var explanation:TextField = new TextField( 300, 100, "Go to Next Level, good luck",
			"Verdana", 17);
			explanation.alignPivot();
			explanation.x = 250;
			explanation.y = 175;
			addChild( explanation );

			object1 = new Button(assetManager.getTexture("Bike"));
			object1.alignPivot();
			object1.scale = 0.4;
			object1.x = 240;
			object1.y = 250;
			this.addChild(object1);
			
			
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		private function onMainMenuClick(event:Event):void
		{
			
			var buttonPress:Button = event.target as Button;
			if((buttonPress as Button) == object1) 
			{
				trace (score);
				var scoreScreen:Screen1 = new Screen1( assetManager, score );
				addChild( scoreScreen );
				this.dispatchEvent(new PressEvent(PressEvent.newScreen, {id: "none1"}, true));
			}
			
			
		}
		
	}
	
}
