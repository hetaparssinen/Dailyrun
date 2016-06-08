/**
 * Created by Lourens on 2-6-2016.
 */
package {
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class Background extends Sprite{
    
    private var texture:Texture;
    private var backgrounds:Vector.<Image>;
    private var speed:int;
    private var stageWidth;
    
    public function Background( backgroundTexture:Texture, stageWidth )
    {
        this.stageWidth = stageWidth;
        texture = backgroundTexture;
        addEventListener( Event.ADDED_TO_STAGE, initialize );
    }
    
    private function initialize()
    {
        backgrounds = new Vector.<Image>();
        speed = 1;
        
        //add background
        var background:Image = new Image( texture );
        addChild(background);
        backgrounds.push( background );
    }
    
    public function update()
    {

        for( var i:int = backgrounds.length - 1; i >= 0; i-- )
        {
            backgrounds[i].x -= speed;
        }

        if( backgrounds[ backgrounds.length - 1 ].x + backgrounds[ backgrounds.length - 1 ].width <= stageWidth )
        {
            var background:Image = new Image( texture );
            background.x = backgrounds[backgrounds.length - 1].x + backgrounds[backgrounds.length - 1].width;
            addChild( background );
            backgrounds.push( background );
        }
        if( backgrounds[0].x + backgrounds[0].width <= 0 )
        {
            removeChild( backgrounds[0] );
            backgrounds.splice( 0, 1 );
        }
    }
}
}
