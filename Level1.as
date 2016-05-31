/**
 * Created by Lourens on 5-5-2016.
 */
package {

import flash.display.Bitmap;

import starling.display.Image;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.tmxmaps.TMXTileMap;
import starling.utils.AssetManager;

public class Level1 implements GameState
{

    [Embed(source="assets/level1test.tmx", mimeType="application/octet-stream")]
    private static var exampleTMX:Class;

    [Embed(source = "assets/sprites.png")]
    private static var exampleTileSet:Class;

    private var game:GameStateManager;
    private var assetManager:AssetManager;
    private var config:Object;
    private var platformHeight:int;
    private var tileWidth:int;
    private var isPlaying:Boolean;
    private var levelStart:LevelStart;
	private var character:Character;
    private var mapTMX:TMXTileMap;
    private var mapWidth:int;
    
    public function Level1( game:GameStateManager ):void
    {
        this.game = game;
        this.assetManager = this.game.getAssetManager();
        trace("Level 1");

        initialize();
    }

    private function initialize():void
    {
        //Get JSON file for settings
        config = assetManager.getObject( "config" );

        //Set initial variables
        isPlaying = false;
        var mapXML:XML = XML(new exampleTMX());
        var tilesets:Vector.<Bitmap> = new Vector.<Bitmap>();
        tilesets.push(Bitmap(new exampleTileSet()));

        //Add background
        var background:Image = new Image( assetManager.getTexture( "sky" ) );
        game.addChild( background );

        //Load and render map
        tilesets.push(Bitmap(new exampleTileSet()));
        mapTMX = TMXTileMap.createMap(mapXML, tilesets);

        //Set map values
        tileWidth = mapTMX.tileWidth;
        mapWidth = mapTMX.mapWidth;

        for (var i:int = 0; i < mapTMX.layers.length; i++)
        {
            if( i != 1)
            {
                game.addChild(mapTMX.layers[i].layerSprite);
            }
        }
        
        for( var i:int = 0; i < mapTMX.layers[1].layerData.length; i++)
        {
            if( mapTMX.layers[1].layerData[i] == 1 )
            {
                var enemy:Enemy = new Enemy( assetManager.getTexture( "enemy" ));
                game.addChild( enemy );
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

        trace( mapTMX.layers[0].layerData );
    }

    private function touchEventHandler( event:TouchEvent )
    {
        var startTouch:Touch = event.getTouch( levelStart, TouchPhase.BEGAN );
        var touch:Touch = event.getTouch( game.stage, TouchPhase.BEGAN );
        if( startTouch && !isPlaying)
        {
            isPlaying = true;
            game.removeChild( levelStart );

            //Draw player
			character = new Character( assetManager );
            character.alignPivot( "center", "bottom");
			character.x = tileWidth;
			character.y = game.stage.stageHeight - tileWidth * 2;
            character.scale = 2;
			game.addChild( character );
        }
		else if ( isPlaying && !character.jumping && touch )
		{
			character.jumping = true;
			character.velocity.y = -100;
		}

    }

    public function update(deltaTime:Number)
    {

        if( isPlaying ) {

            //update character when jumping
            if (character.jumping) {
                character.update(deltaTime);
            }

            //move stage
            for ( var i:int = 0; i < mapTMX.layers.length; i++ )
            {
                mapTMX.layers[i].layerSprite.x -= 5;
            }

            var xLoc:int = ( character.x - mapTMX.layers[0].layerSprite.x ) / tileWidth;
            var yLoc:int = ( character.y - 32 ) / tileWidth;
            var tileNum:int = ( yLoc * mapWidth ) + xLoc;

            //check collision with ground underneath character and adjust character.y
            if( character.y % tileWidth > 0 && mapTMX.layers[0].layerData[tileNum + mapWidth] == 4 )
            {
                character.jumping = false;
                character.y -= character.y % tileWidth
            }
            else if( mapTMX.layers[0].layerData[tileNum + mapWidth] == 0 && character.jumping == false )
            {
                character.jumping = true;
                character.velocity.y = 0;
            }

            //check if on ascending hill
            if( ( mapTMX.layers[0].layerData[tileNum] == 1 || mapTMX.layers[0].layerData[tileNum + mapWidth] == 1 ) )
            {
                if( !character.jumping ) {
                    var groundHeight:int = ( game.stage.stageHeight - character.y ) / tileWidth;
                    groundHeight *= tileWidth;
                    var hillHeight:int = ( character.x - mapTMX.layers[0].layerSprite.x ) % tileWidth;
                    character.y = game.stage.stageHeight - groundHeight - hillHeight;
                }
            }

            //check if on descending hill
            if( ( mapTMX.layers[0].layerData[tileNum] == 2 || mapTMX.layers[0].layerData[tileNum + mapWidth] == 2 ) )
            {
                if( !character.jumping ) {
                    var groundHeight:int = character.y / tileWidth;
                    groundHeight *= tileWidth;
                    var hillHeight:int = ( character.x - mapTMX.layers[0].layerSprite.x ) % tileWidth;
                    character.y = groundHeight + hillHeight;
                }
            }

        }

    }
}
}
