package  {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class GoodGuy extends Sprite {

	    private var texture:Texture;
		public var isHit:Boolean;
		
		public function GoodGuy( texture:Texture ) {
			this.texture = texture;
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		private function initialize()
		{
			var guy:Image = new Image( texture );
			addChild( guy );
		}

	}
	
}
