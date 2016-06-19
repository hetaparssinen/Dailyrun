package
{
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.core.Starling;

	public class MovingEnemy extends Sprite
	{
		public var assetManager:AssetManager;
		public var enemy:MovieClip;
		public var isHit:Boolean;
		
		public function MovingEnemy(assetManager:AssetManager)
		{
			this.assetManager = assetManager;
			addEventListener( Event.ADDED_TO_STAGE, initialize );
		}

		 private function initialize()
        {
			enemy = new MovieClip(assetManager.getTextures("bad_boy"), 12);
			Starling.juggler.add(enemy);
			enemy.alignPivot( "center", "bottom" );
			addChild( enemy );
		
		}
	}

}