package  {
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.utils.AssetManager;
	import starling.core.Starling;
	
	public class FriendsBubble extends Sprite {
		
		private var assetManager:AssetManager;
		public var isHit:Boolean;
		public var block:Boolean = false;

		public function FriendsBubble( assetManager:AssetManager ) {
			this.assetManager = assetManager;
	        addEventListener( Event.ADDED_TO_STAGE, initialize );
		}
		
		private function initialize():void {
			var friends:MovieClip = new MovieClip( this.assetManager.getTextures( "friendsBubble" ), 12 );
			addChild( friends );
			Starling.juggler.add( friends );
		}

	}
	
}
