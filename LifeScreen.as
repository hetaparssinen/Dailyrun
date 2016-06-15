package  {
	import starling.display.Image;
	import starling.display.Quad;
	import starling.utils.AssetManager;
	import starling.text.TextField;
	
	public class LifeScreen {
		
		private var game:GameStateManager;

		public function LifeScreen( game:GameStateManager, items:Vector.<Image>, color:String) {
			this.game = game;
			removeContent();
			addLifeScreen( items, color );
		}
		
		private function removeContent():void {
			while ( this.game.numChildren > 0 ) {
				this.game.removeChildAt( 0 );
			}
		}
		
		private function addLifeScreen( items:Vector.<Image>, color:String ):void {
			var foundItems:Vector.<Image> = items;
			
			var assetManager:AssetManager = game.getAssetManager();

			var background:Image = new Image( assetManager.getTexture( "landscape_size ok" ) ); 
			this.game.addChild( background );
			
			var congratsText:TextField = new TextField( game.stage.stageWidth, 200, "CONGRATULATIONS!", "DK Codswallop", 44 );
			congratsText.color = 15466636;
			congratsText.alignPivot();
			congratsText.y = 50;
			congratsText.x = game.stage.stageWidth / 2;
			this.game.addChild( congratsText );
			
			var character:Image = new Image( assetManager.getTexture( color ) );
			character.alignPivot();
			character.scale = 1.5;
			character.x = 50;
			character.y = game.stage.stageHeight - character.height;
			this.game.addChild( character );

			for ( var i:int = 0; i < foundItems.length; i++ ) {
				foundItems[i].scale = 0.2;
				foundItems[i].alignPivot();
				foundItems[i].x = 140 + i * 70;
				foundItems[i].y = game.stage.stageHeight - character.height;
				this.game.addChild( foundItems[i] );
			}
		}

	}
	
}
