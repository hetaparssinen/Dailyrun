/**
 * Created by Lourens on 10/05/16.
 */
package
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Button;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.utils.AssetManager;
	import starling.events.Event;
	import starling.text.TextField;

	public class GameOver extends Sprite
	{
		private var currentGame:GameStateManager;
		private var assetManager:AssetManager;

		public function GameOver( assetManager: AssetManager, game:GameStateManager )
		{
			this.assetManager = assetManager;
			this.currentGame = game;
			drawGameOver();
		}
		
		public function drawGameOver():void {
			//Place background
			var background:Quad = new Quad( currentGame.stage.stageWidth, currentGame.stage.stageHeight, 41701);
			addChild( background );
			
			var img:Image = new Image( assetManager.getTexture( "gameOver" ) );
			img.scale = 0.5;
			img.alignPivot();
			img.x = currentGame.stage.stageWidth / 2;
			img.y = 60;
			addChild(img);

			var logo:TextField = new TextField( currentGame.stage.stageWidth, 200, "Oh! You are pregnant! Now it's gonna be harder to fulfill your dreams!", "Gotham Rounded", 24,16776960 );
			logo.alignPivot();
			logo.y = currentGame.stage.stageHeight / 2;
			logo.x = currentGame.stage.stageWidth / 2;
			addChild( logo );
			
			var restartButton: Button = new Button( assetManager.getTexture( "button-pink" ), "PLAY AGAIN");
			restartButton.fontSize = 54;
			restartButton.fontColor = 16776960;
			restartButton.fontName = "DK Codswallop";
			restartButton.alignPivot();
			restartButton.scale = 0.65;
			restartButton.x = currentGame.stage.stageWidth / 2;
			restartButton.y = 270;
			addChild(restartButton);
			restartButton.addEventListener(Event.TRIGGERED, onRestartButtonClicked);
		}
		
		public function onRestartButtonClicked(event: Event): void
		{
			// Remove all content from current game
			while ( currentGame.numChildren > 0 ) {
				currentGame.removeChildAt( 0 );
			}
			// Start a new game
			var game:DailyRun = new DailyRun();
			currentGame.addChild(game);
		}

	}
}