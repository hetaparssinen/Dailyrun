package  {
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	
	public class ScoreMenu extends Sprite
	{

		var object1:Button;
		var object2:Button;
		var object3:Button;
		var object4:Button;
		var score:int;
		
		public function ScoreMenu()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE, Add);		
		}
		
		private function Add(event:Event):void {
			draw();
		}
		
		private function draw():void {
			
			object1 = new Button(AssetLoader.getTexture("object1"));
			object1.x = 300;
			object1.y = 25;
			this.addChild(object1);
			
			object2 = new Button(AssetLoader.getTexture("object2"));
			object2.x = 300;
			object2.y = 100;
			this.addChild(object2);
			
			object3 = new Button(AssetLoader.getTexture("object3"));
			object3.x = 300;
			object3.y = 175;
			this.addChild(object3);
			
			object4 = new Button(AssetLoader.getTexture("highScoreBtn"));
			object4.x = 300;
			object4.y = 250;
			this.addChild(object4);
			
			this.addEventListener(Event.TRIGGERED, onMainMenuClick);
		}
		
		public function initialize():void {
			
			this.visible = true;
			
		}
		
		private function onMainMenuClick(event:Event):void
		{
			
			var buttonClicked:Button = event.target as Button;
			if((buttonClicked as Button) == object1) {
				
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id: "none1"}, true));
				
			}
			
			if ((buttonClicked as Button ) == object2){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:"none2"}, true));
			}
			
			if ((buttonClicked as Button) == object3){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:"none3"}, true));
			}
			if ((buttonClicked as Button) == object4){
				this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, {id:"none4"}, true));
			}
			
		}

		public function disposeTemporarily():void 
		{
			this.visible = false;
		}
		
	}
	
}
