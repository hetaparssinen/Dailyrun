package  {
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.utils.AssetManager;
	import flash.display.Bitmap;
	import starling.textures.Texture;
	import flash.geom.Point;
	
	public class Character extends Sprite {
		
		public var jumping = false;
		public var platformHeight:int;
		
		public var velocity:Point = new Point(0, 0);

		public function Character() {
			[Embed(source="assets/character.png")]
			var Character:Class;
			var bitmap:Bitmap = new Character();
			var texture:Texture = Texture.fromEmbeddedAsset(Character);
			var characterImg:Image = new Image(texture);
			addChild(characterImg);
			this.velocity.y = -100;
		}

		public function update( deltaTime:Number ) {
			if (jumping) {
				this.y += this.velocity.y * deltaTime;
			
				this.velocity.y += 5;
				
				if ( this.y >= platformHeight - this.height / 2 ) {
					jumping = false;
					this.y = platformHeight - this.height / 2;
					this.velocity.y = 0;
				}
			}
		}

	}
	
}
