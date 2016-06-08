/**
 * Created by Lourens on 10/05/16.
 */
package {
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.textures.Texture;

public class GameOver extends Sprite
{
    public function GameOver( texture:Texture )
    {

        var backGround:Quad = new Quad( texture.width + 20, texture.height + 10, 1677215);
        addChild( backGround );

        var img:Image = new Image( texture );
        img.alignPivot();
        img.x = this.width / 2;
        img.y = this.height / 2;
        addChild( img );
    }
}
}
