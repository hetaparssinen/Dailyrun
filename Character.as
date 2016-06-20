package
{
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.utils.AssetManager;
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import flash.geom.Point;
	import starling.display.MovieClip;

	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import flash.filesystem.File;

	import starling.display.Image;
	import flash.ui.Keyboard;
	import starling.events.KeyboardEvent;
	import starling.utils.ArrayUtil;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	public class Character extends Sprite
	{

		private var assetManager: AssetManager;

		private var mainCharacter: MovieClip;

		public var jumping = false;

		public var velocity: Point = new Point(0, 0);

		public var health: Number;
		public var maxHealth: Number;
		public var protection: Boolean = false;

		private var config: Object;

		private var protectionTimer: Timer;
		private var protectionBubble:Image;
		
		private var color:String;

		//var levelStart: LevelStart();

		public function Character(assetManager: AssetManager, color: String)
		{
			this.assetManager = assetManager;

			config = assetManager.getObject("config");
			this.color = color;
			
			mainCharacter = new MovieClip(assetManager.getTextures(color + "Character"), 12);

			addChild(mainCharacter);
			Starling.juggler.add(mainCharacter);
			// Fix this and use same size of assets
			this.height = 64;
			this.velocity.y = -100;

			health = maxHealth = config.character.maxHealth;
		}

		public function update(deltaTime: Number)
		{
			if (jumping)
			{
				this.y += this.velocity.y * deltaTime * 3;

				this.velocity.y += 5;
			}
		}

		public function decreaseHealth()
		{
			this.health -= 1;
		}

		public function updateCharacter(): void
		{
			if (health == 1)
			{
				removeChild(mainCharacter);
				Starling.juggler.remove(mainCharacter);
				mainCharacter = new MovieClip(assetManager.getTextures("illGirl"), 12);
				addChild(mainCharacter);
				Starling.juggler.add(mainCharacter);
				this.alignPivot("center", "bottom");
			}
			else if (health == 0)
			{
				removeChild(mainCharacter);
				Starling.juggler.remove(mainCharacter);
				mainCharacter = new MovieClip(assetManager.getTextures("pregnantGirl"), 12);
				addChild(mainCharacter);
				Starling.juggler.add(mainCharacter);
				this.alignPivot("center", "bottom");
			}
		}

		public function addProtection(): void
		{
			protection = true;
			protectionTimer = new Timer(config.character.protectionTime);
			protectionTimer.start();
			protectionTimer.addEventListener(TimerEvent.TIMER, protectionTimerHandler);
			protectionBubble = new Image( assetManager.getTexture( "protectionBubble" ) );
			protectionBubble.alignPivot();
			protectionBubble.x = mainCharacter.x + mainCharacter.width / 2;
			protectionBubble.y = mainCharacter.y + mainCharacter.height / 2;
			addChild( protectionBubble );
			
		}

		private function protectionTimerHandler(e: TimerEvent): void
		{
			protection = false;
			protectionTimer.stop();
			removeChild( protectionBubble );
		}

	}

}