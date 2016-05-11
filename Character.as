package  {
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

	
	public class Character extends Sprite {
		
		private var assetManager:AssetManager;
		
		public var jumping = false;
		public var platformHeight:int;
		
		public var velocity:Point = new Point(0, 0);
		
		public var health:Number;
		public var maxHealth:Number;

		private var config:Object;

		public function Character( assetManager:AssetManager )
		{
			this.assetManager = assetManager;

			config = assetManager.getObject( "config" );

			[Embed(source="assets/character.png")]
			var Character:Class;
			var bitmap:Bitmap = new Character();
			var texture:Texture = Texture.fromEmbeddedAsset(Character);
			var characterImg:Image = new Image(texture);
			addChild(characterImg);
			this.velocity.y = -100;
			
			health = maxHealth = config.character.maxHealth;
		}

		public function update( deltaTime:Number ) {
			if (jumping) {
				this.y += this.velocity.y * deltaTime * 2;
			
				this.velocity.y += 7;
				
				if ( this.y >= platformHeight - this.height / 2 ) {
					jumping = false;
					this.y = platformHeight - this.height / 2;
					this.velocity.y = 0;
				}
			}
			
			
		}

	}
	
}
