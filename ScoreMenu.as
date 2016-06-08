package  {
import starling.display.Quad;
import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
import starling.text.TextField;
import starling.utils.AssetManager;

public class ScoreMenu extends Sprite
	{

		private var assetManager:AssetManager
		private var object1:Button;
		private var object2:Button;
		private var object3:Button;
		private var object4:Button;
		private var score:int;
		private var stageWidth;
		private var stageHeight;
		
		public function ScoreMenu( assetManager:AssetManager, stageWidth:int, stageHeight:int, score:int )
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

			var text:TextField = new TextField( 300, 100, "Well done!", "Verdana", 30, 0, true );
			text.alignPivot();
			text.x = stageWidth / 2;
			text.y = 50;
			addChild( text );

			var scoreText:TextField = new TextField( 300, 100, "Score: " + score, "Verdana", 20 );
			scoreText.alignPivot();
			scoreText.x = stageWidth / 2;
			scoreText.y = 110;
			addChild( scoreText );

			var explanation:TextField = new TextField( 300, 100, "Spend your points to buy some of the following items:",
			"Verdana", 17);
			explanation.alignPivot();
			explanation.x = stageWidth / 2;
			explanation.y = 175;
			addChild( explanation );

			object1 = new Button(assetManager.getTexture("Bike"));
			object1.alignPivot();
			object1.scale = 0.2;
			object1.x = 96;
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
			if((buttonPress as Button) == object1) {
				
				this.dispatchEvent(new PressEvent(PressEvent.newScreen, {id: "none1"}, true));
				
			}
			
			if ((buttonPress as Button ) == object2){
				this.dispatchEvent(new PressEvent(PressEvent.newScreen, {id:"none2"}, true));
			}
			
			if ((buttonPress as Button) == object3){
				this.dispatchEvent(new PressEvent(PressEvent.newScreen, {id:"none3"}, true));
			}
			if ((buttonPress as Button) == object4){
				this.dispatchEvent(new PressEvent(PressEvent.newScreen, {id:"none4"}, true));
			}
			
		}
		
	}
	
}
