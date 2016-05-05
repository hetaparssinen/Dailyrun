/**
 * Created by Lourens on 5-5-2016.
 */
package {

import starling.display.Image;
import starling.utils.AssetManager;

public class Level1 implements GameState
{
    private var game:GameStateManager;
    private var assetManager:AssetManager;
    private var config:Object;
    private var platforms:Vector.<Image>;
    var platformHeight:int;
    var tileWidth:int;
    var screenWidth:int;
    var stageHeight:int;
    var stageWidth:int;
    
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

        //Set initial platformHeight and screenwidth( in tiles )
        platforms = new Vector.<Image>();
        platformHeight = config.level1.platformHeight;
        tileWidth = 32;
        screenWidth = game.stage.stageWidth / tileWidth;
        stageHeight = game.stage.stageHeight;
        stageWidth = game.stage.stageWidth;

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
    }

    public function update(deltaTime:Number)
    {
        var newPlatforms:Boolean = false;
        var spawnX:int = 0;
        for( var i:int = platforms.length - 1; i > 0; i-- )
        {
            if( platforms[i].x <= -tileWidth )
            {
                game.removeChild( platforms[i] );
                platforms.splice( i, 1 );
                newPlatforms = true;
            }
            if( platforms[i].x > spawnX - tileWidth )
            {
                spawnX = platforms[i].x + tileWidth;
            }
        }

        if( newPlatforms ) {
            for (var i:int = 0; i < platformHeight; i++) {
                var platform:Image = new Image(assetManager.getTexture("grassDirtBlock"));
                platform.x = spawnX;
                platform.y = stageHeight - (i * tileWidth) - 32;
                this.game.addChild(platform);
                platforms.push(platform)
            }
        }

        for( var i:int = platforms.length - 1; i > 0; i-- )
        {
            platforms[i].x -= 5;
        }
    }
}
}
