/**
 * Created by Lourens on 5-5-2016.
 */
package {
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.text.TextFieldAutoSize;
import starling.utils.AssetManager;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.display.Image;

public class LevelStart extends Sprite
{

    private var assetManager:AssetManager;
    private var config:Object;
	
	private var characterYellow:Image;
	

    public function LevelStart( assetManager:AssetManager )
    {
        this.assetManager = assetManager;
        config = assetManager.getObject( "config" );
        addEventListener( Event.ADDED_TO_STAGE, initialize );
    }
    
    private function initialize()
    {
        //Place border
        var border:Quad = new Quad( stage.stageWidth - config.levelStart.marginX, stage.stageHeight - config.levelStart.marginY, 16711680 );
        addChild( border );

        //place box
        var box:Quad = new Quad( border.width - config.levelStart.borderThickness, border.height - config.levelStart.borderThickness, 16776960 );
        box.alignPivot();
        box.x = this.width / 2;
        box.y = this.height / 2;
        addChild( box );

        //place text
        var text:TextField = new TextField( box.width, 100, "Tap the screen to start", "Verdana", 30 );
        text.alignPivot();
        text.x = box.width / 2 + config.levelStart.borderThickness / 2;
        text.y = box.height / 2 + config.levelStart.borderThickness / 2;
        addChild( text );
		
		characterYellow = new Image( assetManager.getTexture( "yellowCharacter_static" ) );
		addChild( characterYellow );
    }
	
	public function handleTouch( event:TouchEvent ):void {
		var clickYellow:Touch= event.getTouch( characterYellow, TouchPhase.BEGAN );
		
		if (clickYellow) {
			trace("HUHUHUUUUUUUUUUUU you cliked the yellow woop woop");
		}
	}
}
}
