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

	public class GameOver extends Sprite
	{
		private var currentGame:GameStateManager;

		public function GameOver( assetManager: AssetManager, game:GameStateManager )
		{
			var assetManager:AssetManager = assetManager;
			this.currentGame = game;
			var img:Image = new Image(assetManager.getTexture("gameOver"));
			img.alignPivot();
			img.x = currentGame.stage.stageWidth / 2;
			img.y = currentGame.stage.stageHeight / 2;
			currentGame.addChild(img);

			var restartButton: Button = new Button(assetManager.getTexture("object1"), "RESTART");
			restartButton.alignPivot();
			restartButton.scale = 0.2;
			restartButton.x = currentGame.stage.stageWidth / 2;
			restartButton.y = currentGame.stage.stageHeight / 2;
			currentGame.addChild(restartButton);
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