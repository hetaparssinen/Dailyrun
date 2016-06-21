package  {
	import starling.display.Quad;
	import starling.display.Button;
	import starling.utils.AssetManager;
	import starling.events.Event;
	import flash.text.ReturnKeyLabel;
	
	public class PauseScreen {
		
		var game:GameStateManager;
		var assetManager:AssetManager;
		var isPause:Boolean;
		var background:Quad;

		public function PauseScreen( game:GameStateManager ) {
			this.game = game;
			this.assetManager = game.getAssetManager();
			this.isPause = true;
			
			background = new Quad( game.stage.stageWidth, game.stage.stageHeight, 16716947);
			background.alpha = 0.9;
			game.addChild(background);
		}
		
		function continueGame( e:Event ) {
			this.isPause = false;
		}
		
		public function remove() {
			this.game.removeChild( background );
		}

	}
	
}
