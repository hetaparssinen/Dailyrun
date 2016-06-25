/**
 * Created by Lourens on 5-5-2016.
 */
package {

import flash.display.Bitmap;
import flash.net.SharedObject;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.tmxmaps.TMXTileMap;
import starling.utils.AssetManager;
import starling.text.TextField;
import starling.display.Image;
import starling.events.Event;
import flash.utils.Timer;
import flash.events.TimerEvent;
import starling.display.Button;

public class GoodLifeLevel implements GameState
{

    [Embed(source="assets/goodLifeLevel.tmx", mimeType="application/octet-stream")]
    private static var exampleTMX:Class;

    [Embed(source = "assets/sprites.png")]
    private static var exampleTileSet:Class;

    private var game:GameStateManager;
    private var assetManager:AssetManager;
    private var config:Object;
    private var tileWidth:int;
    private var isPlaying:Boolean;
    private var levelStart:LevelStart;
    private var character:Character;
    private var mapTMX:TMXTileMap;
    private var mapWidth:int;
    private var goodLifeItems:Vector.<Image>;
    private var finish:Image;
    private var gameSpeed:int;
    private var background:Background;
    public var boughtItems:Array;
	private var groundImages:Array;
    public var foundItems:Vector.<Image>;
    private var characterChosen:Boolean;
    private var color:String;
	
	private var pauseButton:Button;
	private var continueButton:Button;
	private var mainMenuButton:Button;
	private var pauseScreen:PauseScreen;

    public function GoodLifeLevel( game:GameStateManager ):void
    {
        this.game = game;
        this.assetManager = this.game.getAssetManager();
        trace("Level 1");

        initialize();
    }

    private function initialize():void
    {
        //get bought items from savedata and store them in the boughtItems array
        //saveDataObject = SharedObject.getLocal( "dailyRun" );
        boughtItems = new Array();
        boughtItems = game.saveDataObject.data.boughtItems;
		trace(boughtItems);
		
		groundImages = new Array();

        //Get JSON file for settings
        config = assetManager.getObject( "config" );

        //Set initial variables
        isPlaying = false;
        var mapXML:XML = XML(new exampleTMX());
        var tilesets:Vector.<Bitmap> = new Vector.<Bitmap>();
        tilesets.push(Bitmap(new exampleTileSet()));
        gameSpeed = 5;
        foundItems = new Vector.<Image>;
        characterChosen = false;

        //Load and render map
        tilesets.push(Bitmap(new exampleTileSet()));
        mapTMX = TMXTileMap.createMap(mapXML, tilesets);

        //Set map values
        tileWidth = mapTMX.tileWidth;
        mapWidth = mapTMX.mapWidth;

        goodLifeItems = new Vector.<Image>();

        //Add background
        background = new Background( assetManager.getTexture( "landscape4"), game.stage.stageWidth );
        game.addChild( background );

        for (var i:int = 0; i < mapTMX.layers.length; i++)
        {
            if( i == 0)
            {
                game.addChild(mapTMX.layers[i].layerSprite);
            }
        }
		
		// Add flowers / ground
		for ( i = 0; i < mapTMX.layers[0].layerData.length; i++ )
		{
			if (mapTMX.layers[0].layerData[i] == 1)
			{
				var num:Number = randomRange(1, 4);
				newGroundImage( "ground_" + num, i );
			} else if ( mapTMX.layers[0].layerData[i] == 2 ) {
				newGroundImage( "ground_down", i );
			} else if ( mapTMX.layers[0].layerData[i] == 3 ) {
				newGroundImage( "ground_up", i );
			}
		}

        //add good life items
        var itemCreationCount:int = 0;

        for( i = 0; i < mapTMX.layers[1].layerData.length; i++ )
        {
            if( mapTMX.layers[1].layerData[i] == 1 )
            {
				if ( boughtItems != null ) {
					var item:Image = new Image( assetManager.getTexture( boughtItems[ itemCreationCount % boughtItems.length ]) );
					item.scale = ( tileWidth / item.height );
					item.x = ( i % mapWidth ) * tileWidth;
					item.y = int( i / mapWidth ) * tileWidth;
					game.addChild(item);
					goodLifeItems.push( item );
					itemCreationCount++;
				}
            }
        }

        //add finish
        for( i = 0; i < mapTMX.layers[2].layerData.length; i++ )
        {
            if( mapTMX.layers[2].layerData[i] == 1 )
            {
                finish = new Image( assetManager.getTexture( "school") );

                finish.scale = 128 / finish.height;

                finish.alignPivot("left", "bottom");
                finish.x = ( i % mapWidth ) * tileWidth;
                finish.y = int( i / mapWidth ) * tileWidth + tileWidth;

                game.addChild( finish );
            }
        }

        //Add eventListener for tapping the screen
        game.addEventListener( TouchEvent.TOUCH, touchEventHandler);

        //Place start screen
        levelStart = new LevelStart( game, this );
        levelStart.alignPivot();
        levelStart.x = config.levelStart.marginX / 2;
        levelStart.y = config.levelStart.marginY / 2;
        game.addChild( levelStart );

    }

    public function startPlaying(color: String)
    {
        characterChosen = true;
        isPlaying = true;
        this.color=color;
    }

    private function touchEventHandler(event: TouchEvent)
    {
        levelStart.handleTouch(event);
        var startTouch: Touch = event.getTouch(levelStart, TouchPhase.BEGAN);
        var touch: Touch = event.getTouch(game.stage, TouchPhase.BEGAN);
		
        if (characterChosen)
        {
            game.removeChild(levelStart);

            //Draw player
            character = new Character( game, this.color );
            character.alignPivot( "center", "bottom");
            character.x = tileWidth;
            character.y = game.stage.stageHeight - tileWidth * 2;
            game.addChild(character);
            characterChosen = false;
			
			pauseButton = new Button( assetManager.getTexture( "pauseButton" ) );
			pauseButton.x = 10;
			pauseButton.y = 10;
			game.addChild( pauseButton );
			
			pauseButton.addEventListener( Event.TRIGGERED, pauseGame );
        }
        else if (isPlaying && !character.jumping && touch)
        {
            character.jumping = true;
            if ( !game.saveDataObject.data.mute ) assetManager.playSound( "jump" );
            character.velocity.y = -100;
        }

    }

    public function update(deltaTime:Number)
    {
        if( isPlaying ) {

            //update background
            background.update();

            //update character when jumping
            if (character.jumping) {
                character.update(deltaTime);
            }

            //move stage
            for ( var i:int = 0; i < mapTMX.layers.length; i++ )
            {
                mapTMX.layers[i].layerSprite.x -= gameSpeed;
            }

            //move items
            for ( i = 0; i < goodLifeItems.length; i++ )
            {
                goodLifeItems[i].x -= gameSpeed;
            }
			
			// Move flowers and remove if off the screen
			moveAndRemove( groundImages );

            // Move finish
            finish.x -= gameSpeed;

            //Check terrain if character is not above the screen
            if( character.y > 0)
            {
                checkGround();

                //Check collision with items
                for( i = goodLifeItems.length - 1; i >= 0; i-- )
                {
                    if( character.bounds.intersects( goodLifeItems[i].bounds ) )
                    {
                        game.removeChild( goodLifeItems[i] );
                        foundItems.push( goodLifeItems[i] );
                        goodLifeItems.splice( i, 1 );
                        if ( !game.saveDataObject.data.mute ) assetManager.playSound( "protection" );
                    }
                }
                
				//check if on ascending hill (3)
				checkIfHill(3);
				// check if descending hill (2)
				checkIfHill(2);
            }
            else
            {
                character.jumping = true;
            }

            //Check if finished
            if( character.bounds.intersects( finish.bounds ) )
            {
                isPlaying = false;

                var endScreen:LifeScreen = new LifeScreen( game, foundItems, color );

                trace( "FINISH" );
                if ( !game.saveDataObject.data.mute ) assetManager.playSound( "applause" );

                game.removeEventListener( Event.ENTER_FRAME, update ); //Doesn't work???
            }

        }
    }
	
	function randomRange(minNum:Number, maxNum:Number):Number
	{
		return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
	}
	
	function newGroundImage( image:String, i:int ) {
		var flower:Image = new Image( assetManager.getTexture( image ) );
		flower.x = (i % mapWidth) * tileWidth;
		flower.y = int(i / mapWidth) * tileWidth - (flower.height - tileWidth);
		game.addChild(flower);
		groundImages.push( flower );
	}

	function checkGround() {
		if ( character.y >= game.stage.stageHeight && character.jumping == true ) {
            if( character.jumping )
            {
                if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
            }

            character.jumping = false;
		}
		
		var tileNum:int = countTileNum();
		//check collision with ground underneath character and adjust character.y
		if (character.y % tileWidth > 0 && mapTMX.layers[0].layerData[tileNum + mapWidth] == 1)
		{
            if( character.jumping )
            {
                if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
            }

			character.jumping = false;
			character.y -= character.y % tileWidth
		}
		else if (mapTMX.layers[0].layerData[tileNum + mapWidth] == 0 && character.jumping == false)
		{
			character.jumping = true;
			character.velocity.y = 0;
		}
	}
	
	function checkIfHill( n:int ) {
		var tileNum:int = countTileNum();
		if ((mapTMX.layers[0].layerData[tileNum] == n || mapTMX.layers[0].layerData[tileNum + mapWidth] == n))
		{
			if ( n == 3 ) {
				ascendingHill();
			} else if ( n == 2 ) {
				descendingHill();
			}
		}
	}
	
	function ascendingHill() {
		if (!character.jumping)
		{
			var groundHeight:int = (game.stage.stageHeight - character.y) / tileWidth;
			groundHeight *= tileWidth;
			var hillHeight:int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
			character.y = game.stage.stageHeight - groundHeight - hillHeight;
		}
		else if (character.jumping)
		{
			var charTileX:int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
			var charTileY:int = (game.stage.stageHeight - character.y) % tileWidth;

			if (charTileY < charTileX)
				character.jumping = false;
                if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
		}
	}
	
	function descendingHill() {
		if (!character.jumping)
		{
			var groundHeight:int = character.y / tileWidth;
			groundHeight *= tileWidth;
			var hillHeight:int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
			character.y = groundHeight + hillHeight;
		}
		else if (character.jumping)
		{
			var charTileX: int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
			var charTileY: int = (game.stage.stageHeight - character.y) % tileWidth;

			if (charTileY < charTileX)
				character.jumping = false;
                if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
		}
	}
	
	function countTileNum():int {
		var xLoc: int = (character.x - mapTMX.layers[0].layerSprite.x) / tileWidth;
		var yLoc: int = (character.y - tileWidth) / tileWidth;
		var tileNum: int = (yLoc * mapWidth) + xLoc;
		return tileNum;
	}
	
	function moveAndRemove( objects:Array ) {
		for ( var i:int = 0; i < objects.length; i++ )
		{
			if ( objects[i].x <= -objects[i].width )
			{
				game.removeChild( objects[i] );
				objects.splice(i, 1);
			}
			else
			{
				objects[i].x -= gameSpeed;
			}
		}
	}
	
	function pauseGame( e:Event ) {
		pauseScreen = new PauseScreen( game );
		isPlaying = false;
		
		continueButton = new Button( assetManager.getTexture( "button-yellow" ), "CONTINUE" );
		initButton( continueButton );
		continueButton.y = game.stage.stageHeight / 2 - 40;
		game.addChild( continueButton );
		
		mainMenuButton = new Button( assetManager.getTexture( "button-yellow" ), "MAIN MENU" );
		initButton( mainMenuButton );
		mainMenuButton.y = game.stage.stageHeight / 2 + 40;
		game.addChild( mainMenuButton );
		
		continueButton.addEventListener( Event.TRIGGERED, continueGame );
		mainMenuButton.addEventListener( Event.TRIGGERED, toMainMenu );
	}
	
	function continueGame( e:Event ) {
		pauseScreen.remove();
		game.removeChild( continueButton );
		game.removeChild( mainMenuButton );
		isPlaying = true;
	}
	
	function toMainMenu( e:Event ) {
		while ( this.game.numChildren > 0 ) {
			this.game.removeChildAt( 0 );
		}
		this.game.setGameState( MainMenu );
	}
	
	function initButton( button:Button ) {
		button.fontColor = 16716947;
		button.fontName = "DK Codswallop";
		button.fontSize = 54;
		button.alignPivot();
		button.scale = 0.65;
		button.x = game.stage.stageWidth / 2;
	}
}
}
