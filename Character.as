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
		
		private var mainCharacter:MovieClip;
		
		public var jumping = false;
		
		public var velocity:Point = new Point(0, 0);
		
		public var health:Number;
		public var maxHealth:Number;

		private var config:Object;

		public function Character( assetManager:AssetManager )
		{
			this.assetManager = assetManager;

			config = assetManager.getObject( "config" );

			mainCharacter = new MovieClip( assetManager.getTextures( "mainCharacter" ), 12 );
			addChild( mainCharacter );
			Starling.juggler.add( mainCharacter );
			// Fix this and use same size of assets
			this.height = 64;
			this.velocity.y = -100;
			
			health = maxHealth = config.character.maxHealth;
		}

		public function update( deltaTime:Number ) {
			if (jumping) {
				this.y += this.velocity.y * deltaTime * 3;
			
				this.velocity.y += 6;
			}
		}
		
		public function updateCharacter():void {
			if ( health == 1 ) {
				removeChild( mainCharacter );
				Starling.juggler.remove( mainCharacter );
				mainCharacter = new MovieClip( assetManager.getTextures( "pregnantGirl" ), 12 );
				addChild( mainCharacter );
				Starling.juggler.add( mainCharacter );
				// Fix this and use same size of assets
				this.height = 64;
				this.alignPivot( "center", "bottom" );
			} else if ( health == 0 ) {
				
			}
		}

	}
	
}
