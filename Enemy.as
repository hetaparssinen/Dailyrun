/**
 * Created by Lourens on 09/05/16.
 */
package {
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class Enemy extends Sprite
{
    
    private var texture:Texture;
    public var isHit:Boolean;

    public function Enemy( enemyTexture:Texture )
    {
        this.texture = enemyTexture;
        touchable = false;
        addEventListener( Event.ADDED_TO_STAGE, initialize );
    }

    private function initialize()
    {
        var enemy:Image = new Image( texture );
        addChild( enemy );
    }
}
}