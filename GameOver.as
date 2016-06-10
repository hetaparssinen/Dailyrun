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
	import starling.text.TextField;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.utils.AssetManager;
	import starling.events.Event;
	import flash.ui.GameInput;

	public class GameOver extends Sprite
	{
		private var level: GameState;
		private var img: Image;
		private var newGame: GameStateManager;
		private var assetManager: AssetManager;
		public var gameOverButtonTouched: Boolean = false;
		private var sprite: Sprite = new Sprite();

		public function GameOver(assetManager: AssetManager)
		{
			this.assetManager = assetManager;
			img = new Image(assetManager.getTexture("gameOver"));
			img.alignPivot();
			img.x = this.width / 2;
			img.y = this.height / 2;
			sprite.addChild(img);

			var restartButton: Button = new Button(assetManager.getTexture("object1"), "RESTART");
			restartButton.alignPivot();
			restartButton.scale = 0.2;
			restartButton.x = this.width / 2;
			restartButton.y = this.height / 2;
			sprite.addChild(restartButton);
			addChild(sprite);
			restartButton.addEventListener(Event.TRIGGERED, onRestartButtonClicked);

		}
		public function onRestartButtonClicked(event: Event): void
		{

			var game: DailyRun = new DailyRun();
			game.x = -240;
			game.y = -160;
			removeChild(sprite);
			addChild(game);
		}

	}
}