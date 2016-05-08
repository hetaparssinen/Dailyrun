/**
 * Created by Lourens on 5-5-2016.
 */
package {

import starling.display.Image;
import starling.display.Quad;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.utils.AssetManager;

public class Level1 implements GameState
{
    private var game:GameStateManager;
    private var assetManager:AssetManager;
    private var config:Object;
    private var platforms:Vector.<Image>;
    private var platformHeight:int;
    private var tileWidth:int;
    private var screenWidth:int;
    private var stageHeight:int;
    private var stageWidth:int;
    private var isPlaying:Boolean;
    private var levelStart:LevelStart;
    
    public function Level1( game:GameStateManager ):void
    {
        this.game = game;
        this.assetManager = this.game.getAssetManager();
        trace("Level 1")

        initialize();
    }

    private function initialize():void
    {
        //Get JSON file for settings
        config = assetManager.getObject( "config" );

        //Set initial variables
        platforms = new Vector.<Image>();
        platformHeight = config.level1.platformHeight;
        tileWidth = 32;
        screenWidth = game.stage.stageWidth / tileWidth;
        stageHeight = game.stage.stageHeight;
        stageWidth = game.stage.stageWidth;
        isPlaying = false;

        //Set and display initial platforms
        for( var i:int = 0; i < platformHeight; i++ ) {
            for (var j:int = 0; j < screenWidth + 3; j++) {
                var platform:Image = new Image(assetManager.getTexture("grassDirtBlock"));
                platform.x = j * tileWidth;
                platform.y = stageHeight - (i * tileWidth) - 32;
                this.game.addChild( platform );
                platforms.push(platform)
            }
        }

        //Add eventListener for tapping the screen
        game.addEventListener( TouchEvent.TOUCH, touchEventHandler);

        //Place start screen
        levelStart = new LevelStart( assetManager );
        levelStart.alignPivot();
        levelStart.x = config.levelStart.marginX / 2;
        levelStart.y = config.levelStart.marginY / 2;
        game.addChild( levelStart );
    }

    private function touchEventHandler( event:TouchEvent )
    {
        var startTouch:Touch = event.getTouch( levelStart, TouchPhase.BEGAN );
        if( startTouch && !isPlaying)
        {
            isPlaying = true;
            game.removeChild( levelStart );
        }

    }

    public function update(deltaTime:Number)
    {
        var newPlatforms:Boolean = false;
        var spawnX:int = 0;

        
        if( isPlaying ) {
            //Check if platforms are going off stage and determine the x coordinate for new platforms
            for (var i:int = platforms.length - 1; i > 0; i--) {
                if (platforms[i].x <= -tileWidth) {
                    game.removeChild(platforms[i]);
                    platforms.splice(i, 1);
                    newPlatforms = true;
                }
                if (platforms[i].x > spawnX - tileWidth) {
                    spawnX = platforms[i].x + tileWidth;
                }
            }

            //Create new platforms if needed
            if (newPlatforms) {
                for (var i:int = 0; i < platformHeight; i++) {
                    var platform:Image = new Image(assetManager.getTexture("grassDirtBlock"));
                    platform.x = spawnX;
                    platform.y = stageHeight - (i * tileWidth) - 32;
                    this.game.addChild(platform);
                    platforms.push(platform)
                }
            }

            //Move all platforms
            for (var i:int = platforms.length - 1; i > 0; i--) {
                platforms[i].x -= Math.floor(150 * deltaTime);
            }
        }
    }
}
}
