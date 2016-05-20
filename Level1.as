/**
 * Created by Lourens on 5-5-2016.
 */
package {

import flash.events.TimerEvent;
import flash.utils.Timer;

import starling.display.Image;
import starling.display.Quad;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
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
    private var lastScreen:Boolean;
    private var levelStart:LevelStart;
	private var character:Character;
    private var timer:Timer;
    private var goodGuyTimer:Timer;
    private var endGameTimer:Timer;
    private var enemies:Vector.<Enemy>;
    private var goodGuys:Vector.<GoodGuy>;
	private var collectedGoodGuys:Array;
    private var healthBar:HealthBar;
    private var timerDelay:TextField;
    
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
        lastScreen = false;
        enemies = new Vector.<Enemy>();
        goodGuys = new Vector.<GoodGuy>();
        collectedGoodGuys = new Array();

        //Add background
        var background:Image = new Image( assetManager.getTexture( "sky" ) );
        game.addChild( background );

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

    private function setTimer():void
    {
        timer = new Timer( config.timer.initialValue, 1 );
        timer.start();
        timer.addEventListener( TimerEvent.TIMER, timerHandler );
    }

	private function setGoodGuyTimer():void
	{
		// Limit good guys to three
		goodGuyTimer = new Timer( config.timer.goodGuyInitial, 3 );
		goodGuyTimer.start();
		goodGuyTimer.addEventListener( TimerEvent.TIMER, goodGuyTimerHandler );
	}

	private function setEndGameTimer():void 
	{
		endGameTimer = new Timer( config.level1.levelDuration, 1 );
		endGameTimer.start();
		endGameTimer.addEventListener( TimerEvent.TIMER, endGameTimerHandler );
	}

    private function timerHandler( e:TimerEvent ):void
    {
        timer.delay = timer.delay * config.timer.decreaseRate;
        timer.reset();
        timer.start();
        spawnEnemy();
    }

	private function goodGuyTimerHandler( e:TimerEvent ):void
	{
		var goodGuy:GoodGuy = new GoodGuy( assetManager.getTexture( "goodGuy" ) );
		goodGuy.x = game.stage.stageWidth;
		goodGuy.y = game.stage.stageHeight - (platformHeight * tileWidth) - tileWidth;
		game.addChild( goodGuy );
		goodGuys.push( goodGuy );
	}

	private function endGameTimerHandler ( e:TimerEvent ):void
	{
		lastScreen = true;
	}

    private function spawnEnemy():void
    {
        var enemy:Enemy = new Enemy( assetManager.getTexture( "enemy" ) );
        enemy.x = game.stage.stageWidth;
        enemy.y = game.stage.stageHeight - (platformHeight * tileWidth) - tileWidth;
        game.addChild( enemy );
        enemies.push( enemy );
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
			character.alignPivot();
			character.x = config.level1.playerX;
			character.y = game.stage.stageHeight - character.height / 2 - platformHeight * tileWidth;
			game.addChild( character );

            //draw healthbar
            healthBar = new HealthBar();
            healthBar.alignPivot();
            healthBar.x = character.x;
            healthBar.y = character.y - ( character.height / 2 ) - 10;
            game.addChild( healthBar );

            //start the timer and spawn first enemy
            spawnEnemy();
            setTimer();
			setGoodGuyTimer();
			setEndGameTimer();

            //Display timer delay on screen (testing purpose)
            timerDelay = new TextField( 50, 30, String( timer.delay ) );
            timerDelay.alignPivot( "right", "top" );
            timerDelay.x = game.stage.stageWidth;
            game.addChild( timerDelay );

        } 
		else if ( isPlaying && !character.jumping && touch )
		{
			character.jumping = true;
			character.velocity.y = -100;
		}

    }

    public function update(deltaTime:Number)
    {
        var newPlatforms:Boolean = false;
        var spawnX:int = 0;

        
        if( isPlaying && !lastScreen ) {
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
			
			checkCharacterJump( deltaTime );

            //Move enemies and remove them if they left the screen
            for (var i:int = enemies.length - 1; i > 0; i--) {
                if( enemies[i].x < -tileWidth )
                {
                    game.removeChild( enemies[i] );
                    enemies.splice( i, 1 );
                }
                else {
                    enemies[i].x -= Math.floor(150 * deltaTime);
                }
            }

            //Move goodGuys and remove them if they left the screen
            for (var i:int = 0; i < goodGuys.length; i++) {
                if( goodGuys[i].x < -tileWidth )
                {
                    game.removeChild( goodGuys[i] );
                    goodGuys.splice( i, 1 );
                }
                else {
                    goodGuys[i].x -= Math.floor(150 * deltaTime);
                }
            }

			//check collision with good guys
            for ( var i:int = 0; i < goodGuys.length; i++ )
			{
				if( character.bounds.intersects( goodGuys[i].bounds ) && !goodGuys[i].isHit )
				{
					goodGuys[i].isHit = true;
					var hittedGoodGuy = new GoodGuy( assetManager.getTexture( "goodGuy" ) );
					collectedGoodGuys.push( hittedGoodGuy );
					hittedGoodGuy.x = game.stage.stageWidth - 30 * collectedGoodGuys.length;
					hittedGoodGuy.y = 30;
					game.addChild( hittedGoodGuy );
				}
			}
        }

		//check collision with enemies
		for ( var i:int = enemies.length -1; i > 0; i-- )
		{
			if( character.bounds.intersects( enemies[i].bounds ) && !enemies[i].isHit )
			{
				enemies[i].isHit = true;
				if( character.health > 0 ) {
					character.health -= 1;
				}
				healthBar.update( character.health / character.maxHealth );

				//Check health
				if( character.health <= 0 )
				{
					isPlaying = false;
					var gameOver:GameOver = new GameOver( assetManager.getTexture( "gameOver" ));
					gameOver.alignPivot();
					gameOver.x = game.stage.stageWidth / 2;
					gameOver.y = game.stage.stageHeight / 2;
					game.addChild( gameOver );
					game.addChild( timerDelay );
					break;
				}
			}
		}

		if ( lastScreen ) {
			character.x += Math.floor(150 * deltaTime);
			if ( character.x >= game.stage.stageWidth - 30 ) {
				character.x = game.stage.stageWidth - 30;
				lastScreen = false;
				isPlaying = false;
			}
			checkCharacterJump( deltaTime );
		}

        if( isPlaying )
        {
            //move healthbar
            healthBar.y = character.y - ( character.height / 2 ) - 10;

            game.addChild( character );
            timerDelay.text = String( Math.floor( timer.delay ) );
        }

    }

	public function checkCharacterJump( deltaTime:Number ) {
		trace(character.jumping + " IS JUMPING");
		if (character.jumping) {
			character.platformHeight = game.stage.stageHeight - platformHeight * tileWidth;
			character.update(deltaTime);
		}
	}
}
}
