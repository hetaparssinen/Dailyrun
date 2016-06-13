package  {
	import starling.display.Image;
	import starling.display.Quad;
	
	public class LifeScreen {
		
		private var game:GameStateManager;

		public function LifeScreen( game:GameStateManager, items:Vector.<Image> ) {
			this.game = game;
			removeContent();
			addLifeScreen( items );
		}
		
		private function removeContent():void {
			while ( this.game.numChildren > 0 ) {
				this.game.removeChildAt( 0 );
			}
		}
		
		private function addLifeScreen( items:Vector.<Image> ):void {
			var foundItems:Vector.<Image> = items;

			var background:Quad = new Quad( game.stage.stageWidth, game.stage.stageHeight, 123456 );
			background.alpha = 0.9;
			game.addChild( background );
			
			for ( var i:int = 0; i < foundItems.length; i++ ) {
				foundItems[i].x = i * 80;
				this.game.addChild( foundItems[i] );
			}
		}

	}
	
}
