package  {
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.Event;
	import starling.display.Image;
	
	public class FriendsBubble extends Sprite {
		
		private var texture:Texture;
		public var isHit:Boolean;

		public function FriendsBubble( texture:Texture ) {
			this.texture = texture;
	        addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		private function initialize():void {
			var friends:Image = new Image( this.texture );
			addChild( friends );
		}

	}
	
}
