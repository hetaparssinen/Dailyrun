﻿﻿
/**
 * Created by Lourens on 5-5-2016.
 */
package
{

	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.tmxmaps.TMXTileMap;
	import starling.utils.AssetManager;
	import starling.text.TextField;
	import flash.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import starling.display.Button;

	public class Level3 implements GameState
	{

    [Embed(source = "assets/level3.tmx", mimeType = "application/octet-stream")]
		private static var exampleTMX: Class;

    [Embed(source = "assets/sprites.png")]
		private static var exampleTileSet: Class;

		private var game: GameStateManager;
		private var assetManager: AssetManager;
		private var config: Object;
		private var tileWidth: int;
		private var isPlaying: Boolean;
		private var levelStart: LevelStart;
		private var character: Character;
		private var mapTMX: TMXTileMap;
		private var mapWidth: int;
		private var enemies:Array;
		private var goodGuys:Array;
		private var collectedGoodGuys:Array;
		private var groundImages:Array;
		private var smallGrassImages:Array;
		private var friendsBubbles:Array;
		private var characterChosen: Boolean;
		private var score: int;
		private var scoreText: TextField;
		private var finish: Image;
		private var start:Image;
		private var protectionBubble:Image;
		private var gameSpeed: int;
		private var background: Background;
		private var color:String;
		private var shakeBack = false;
		
		private var blur:Image;
		private var blurImages:Array;
		
		private var pauseButton:Button;
		private var continueButton:Button;
		private var mainMenuButton:Button;
		private var pauseScreen:PauseScreen;
		
		private var pointsTimer:Timer;
		private var protectionTimer:Timer;

		public function Level3(game: GameStateManager): void
		{
			this.game = game;
			this.assetManager = this.game.getAssetManager();
			trace("Level 1");

			initialize();
		}

		private function initialize(): void
		{
			//Get JSON file for settings
			config = assetManager.getObject("config");

			//Set initial variables
			isPlaying = false;
			var mapXML: XML = XML(new exampleTMX());
			var tilesets: Vector.< Bitmap > = new Vector.< Bitmap > ();
			tilesets.push(Bitmap(new exampleTileSet()));
			gameSpeed = 5;
		//	score = game.saveDataObject.data.totalScore;
			score=0;
			//Load and render map
			tilesets.push(Bitmap(new exampleTileSet()));
			mapTMX = TMXTileMap.createMap(mapXML, tilesets);

			//Set map values
			tileWidth = mapTMX.tileWidth;
			mapWidth = mapTMX.mapWidth;

			enemies = new Array();
			goodGuys = new Array();
			groundImages = new Array();
			collectedGoodGuys = new Array();
			friendsBubbles = new Array();
			blurImages = new Array();
			smallGrassImages = new Array();

			//Add background
			background = new Background(assetManager.getTexture("landscape3"), game.stage.stageWidth);
			game.addChild(background);

			for (var i: int = 0; i < mapTMX.layers.length; i++)
			{
				if (i == 0)
				{
					game.addChild(mapTMX.layers[i].layerSprite);
				}
			}

			//add score indicator
			scoreText = new TextField(150, 50, "Score: " + score, "Gotham Rounded",12,16776960);
			game.addChild(scoreText);
			
			// Add flowers / ground
			for ( i = 0; i < mapTMX.layers[0].layerData.length; i++ )
			{
				if (mapTMX.layers[0].layerData[i] == 1)
				{
					var num:Number = randomRange(1, 2);
					newGroundImage( "ground_" + num, i );
				} else if ( mapTMX.layers[0].layerData[i] == 2 ) {
					newGroundImage( "ground_down", i );
				} else if ( mapTMX.layers[0].layerData[i] == 3 ) {
					newGroundImage( "ground_up", i );
				}
			}
			for ( i = 0; i < game.stage.stageWidth / tileWidth + 1; i++ ) {
				var grass:Image = new Image( assetManager.getTexture( "smallGrass" ) );
				grass.alignPivot( "left", "bottom" );
				grass.x = i * tileWidth;
				grass.y = game.stage.stageHeight;
				game.addChild( grass );
				smallGrassImages.push( grass );
			}

			// Add bad boys to the screen
			for ( i = 0; i < mapTMX.layers[1].layerData.length; i++ )
			{
				if (mapTMX.layers[1].layerData[i] == 1)
				{
					var enemy:MovingEnemy = new MovingEnemy(assetManager);
					game.addChild(enemy);
					enemy.x = (i % mapWidth) * tileWidth;
					enemy.y = int(i / mapWidth) * tileWidth + tileWidth;
					enemies.push(enemy);
				} else if ( mapTMX.layers[1].layerData[i] == 2 ) {
					var enemystatic = new Enemy( assetManager.getTexture( "badBoy" ) );
					game.addChild(enemystatic);
					enemystatic.x = (i % mapWidth) * tileWidth;
					enemystatic.y = int(i / mapWidth) * tileWidth;
					enemies.push(enemystatic);
				}
			}

			// Add good guys to the screen
			for ( i = 0; i < mapTMX.layers[2].layerData.length; i++ )
			{
				if (mapTMX.layers[2].layerData[i] == 1)
				{
					// change assets names in some point....
					var goodGuy: GoodGuy = new GoodGuy(assetManager.getTexture("goodBoy"));
					game.addChild(goodGuy);
					goodGuy.x = (i % mapWidth) * tileWidth;
					goodGuy.y = int(i / mapWidth) * tileWidth;
					goodGuys.push(goodGuy);
				}
			}

			// Add friends bubble to the screen
			for ( i = 0; i < mapTMX.layers[3].layerData.length; i++ )
			{
				if (mapTMX.layers[3].layerData[i] == 1)
				{
					var friendsBubble:FriendsBubble = new FriendsBubble(assetManager);
					friendsBubble.x = (i % mapWidth) * tileWidth;
					friendsBubble.y = int(i / mapWidth) * tileWidth;
					game.addChild(friendsBubble);
					friendsBubbles.push( friendsBubble );
				}
			}

			//add finish
			for ( i = 0; i < mapTMX.layers[4].layerData.length; i++ )
			{
				if (mapTMX.layers[4].layerData[i] == 1)
				{
					finish = new Image(assetManager.getTexture("home"));

					finish.alignPivot("left", "bottom");
					finish.x = (i % mapWidth) * tileWidth;
					finish.y = int(i / mapWidth) * tileWidth + tileWidth + 10;

					game.addChild(finish);
				}
			}
			
			// Add start
			start = new Image(assetManager.getTexture("goal_r"));
			start.alignPivot("left", "bottom");
			start.x = -20;
			start.y = game.stage.stageHeight;
			game.addChild(start);

			//Add eventListener for tapping the screen
			game.addEventListener(TouchEvent.TOUCH, touchEventHandler);

			//Place start screen
			levelStart = new LevelStart(game, this);
			levelStart.alignPivot();
			levelStart.x = config.levelStart.marginX / 2;
			levelStart.y = config.levelStart.marginY / 2;
			game.addChild(levelStart);
		}

		public function startPlaying(color: String)
		{
			characterChosen = true;
			isPlaying = true;
			this.color = color;
		}

		private function touchEventHandler(event: TouchEvent)
		{
			levelStart.handleTouch(event);
			//var startTouch:Touch;
			var startTouch: Touch = event.getTouch(levelStart, TouchPhase.BEGAN);
			var touch: Touch = event.getTouch(game.stage, TouchPhase.BEGAN);
			if (characterChosen)
			{
				isPlaying = true;
				game.removeChild(levelStart);

				//Draw player
				character = new Character(game, color);
				character.alignPivot("center", "bottom");
				character.x = tileWidth;
				character.y = game.stage.stageHeight - tileWidth * 2;
				//character.scale = 2;
				game.addChild(character);
				characterChosen = false;

				pauseButton = new Button( assetManager.getTexture( "pauseButton" ) );
				pauseButton.x = 10;
				pauseButton.y = 10;
				game.addChild( pauseButton );
				
				pauseButton.addEventListener( Event.TRIGGERED, pauseGame );
				
				pointsTimer = new Timer( 5000, 100 );
				pointsTimer.addEventListener( TimerEvent.TIMER, pointsTimerHandler );
				pointsTimer.start();
			}
			else if (isPlaying && !character.jumping && touch)
			{
				character.jumping = true;
				character.jumpingSound = true;
				character.velocity.y = -100;
			}
		}		
		
		public function update(deltaTime: Number)
		{
			if (isPlaying)
			{
				//update background
				background.update();

				//update character when jumping
				if (character.jumping)
				{
					character.update(deltaTime);
				}

				//move stage
				for (var i: int = 0; i < mapTMX.layers.length; i++)
				{
					mapTMX.layers[i].layerSprite.x -= gameSpeed;
				}
				
				// Move flowers and remove if off the screen
				moveAndRemove( groundImages );
				
				moveAndRemove( smallGrassImages, true );

				// Move enemies and remove if off the screen
				moveAndRemoveMoving( enemies );

				// Move good boys and remove is off the screen
				moveAndRemove( goodGuys );

				// Move friends bubble and remove if off the screen
				moveAndRemove( friendsBubbles );

				// Move finish
				finish.x -= gameSpeed;
				
				// Move and remove start
				if ( start.x + start.width < 0 ) {
					game.removeChild( start );
				} else {
					start.x -= gameSpeed;
				}

				// Check collision with enemies
				if ( checkCollision( enemies ) != -1 ) {
					enemyHit();
				}
		
				// Check collision with good boys
				if ( checkCollision( goodGuys ) != -1 ) {
					goodGuyHit();
				}

				// Check collision with friends bubble
				var bubble:int = checkCollision( friendsBubbles );
				if ( bubble != -1 ) {
					friendsBubbleHit( bubble );
				}
				
				if ( protectionBubble ) {
					protectionBubble.x = character.x;
					protectionBubble.y = character.y - character.height / 2;
				}
				
				checkGround();
				//check if on ascending hill (3)
				checkIfHill(3);
				// check if descending hill (2)
				checkIfHill(2);
				
				for ( i = 0; i < enemies.length; i++ ) {
					if ( enemies[i] is MovingEnemy ) {
						checkEnemyHill( enemies[i] );
					}
				}
				
				// If finish
				 if( character.bounds.intersects( finish.bounds ) )
				{
					isPlaying = false;

					var scoreScreen: ScoreMenu = new ScoreMenu(game, assetManager, score);
					game.addChild(scoreScreen);

					if (game.saveDataObject.data.level3HighScore == null || game.saveDataObject.data.level3HighScore < score)
					{
						//game.saveDataObject.data.level3HighScore = score;
						game.saveDataObject.flush();
					}

					trace("FINISH");
					//game.saveDataObject.data.totalLevel = score;
					
					game.removeEventListener(Event.ENTER_FRAME, update); //Doesn't work???
				}
			}
		}
		
		function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}

		function shake( event:TimerEvent ) {
			if ( shakeBack ) {
				background.x -= 3;
				shakeBack = false;
			} else {
				background.x += 3;
				shakeBack = true;
			}
		}
		
		function checkGround() {
			if ( character.y >= game.stage.stageHeight && character.jumping == true ) {
				character.jumping = false;
				character.y = game.stage.stageHeight;
				if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
				character.updateCharacter();
			}
			
			var tileNum:int = countTileNum();
			//check collision with ground underneath character and adjust character.y
			if (character.y % tileWidth > 0 && mapTMX.layers[0].layerData[tileNum + mapWidth] == 1)
			{
				if( character.jumping )
				{
					if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
					character.updateCharacter();
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

				if (charTileY < charTileX) {
					character.jumping = false;
					if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
					character.updateCharacter();
				}
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

				if (charTileY < charTileX) {
					character.jumping = false;
					if ( !game.saveDataObject.data.mute ) assetManager.playSound( "landing" );
					character.updateCharacter();
				}
			}
		}
		
		function checkEnemyHill( enemy:MovingEnemy ) {
			var xLoc: int = (enemy.x - mapTMX.layers[0].layerSprite.x) / tileWidth;
			var yLoc: int = (enemy.y - tileWidth) / tileWidth;
			var tileNum: int = (yLoc * mapWidth) + xLoc;
			if ((mapTMX.layers[0].layerData[tileNum] == 2 || mapTMX.layers[0].layerData[tileNum + mapWidth] == 2))
			{
				var groundHeight:int = (game.stage.stageHeight - enemy.y) / tileWidth;
				groundHeight *= tileWidth;
				var hillHeight:int = tileWidth - (enemy.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
				enemy.y = game.stage.stageHeight - groundHeight - hillHeight;
			}
		}
		
		function countTileNum():int {
			var xLoc: int = (character.x - mapTMX.layers[0].layerSprite.x) / tileWidth;
			var yLoc: int = (character.y - tileWidth) / tileWidth;
			var tileNum: int = (yLoc * mapWidth) + xLoc;
			return tileNum;
		}
		
		function newGroundImage( image:String, i:int ) {
			var flower:Image = new Image( assetManager.getTexture( image ) );
			flower.x = (i % mapWidth) * tileWidth;
			flower.y = int(i / mapWidth) * tileWidth - (flower.height - tileWidth);
			game.addChild(flower);
			groundImages.push( flower );
		}
		
		function moveAndRemoveMoving(objects:Array) {
			for ( var i:int = 0; i < objects.length; i++ )
			{
				if ( objects[i].x <= -objects[i].width )
				{
					game.removeChild( objects[i] );
					objects.splice(i, 1);
				}
				else if ( objects[i].x < game.stage.stageWidth && objects[i].x > 0 ) 
				{
					if ( objects[i] is MovingEnemy ) {
						objects[i].x -= gameSpeed + 2;
					} else {
						objects[i].x -= gameSpeed;
					}
				}
				else
				{
					objects[i].x -= gameSpeed;
				}
			}
		}
		
		function moveAndRemove( objects:Array, addMore:Boolean=false ) {
			for ( var i:int = 0; i < objects.length; i++ )
			{
				if ( objects[i].x <= -objects[i].width )
				{
					game.removeChild( objects[i] );
					objects.splice(i, 1);
					if ( addMore ) addSmallGrass();
				}
				else
				{
					objects[i].x -= gameSpeed;
				}
			}
		}
		
		function addSmallGrass() {
			var grass:Image = new Image( assetManager.getTexture( "smallGrass" ) );
			grass.alignPivot( "left", "bottom" );
			grass.x = game.stage.stageWidth;
			grass.y = game.stage.stageHeight;
			game.addChild( grass );
			smallGrassImages.push( grass );
		}
		
		function checkCollision( objects:Array ):int {
			for ( var i:int = 0; i < objects.length; i++ ) {
				if ( character.bounds.intersects( objects[i].bounds ) && !objects[i].isHit ) {
					objects[i].isHit = true;
					return i;
				}
			}
			return -1;
		}
		
		function enemyHit() {
			if ( !character.protection ) {
				blur = new Image( assetManager.getTexture( "blur" ) );
				game.addChild( blur );
				game.addChild( pauseButton );
				blurImages.push( blur );
				
				var timerShake:Timer = new Timer( 50, 10 );
				timerShake.addEventListener(TimerEvent.TIMER, shake);
				timerShake.start();

				if ( !game.saveDataObject.data.mute ) assetManager.playSound("hitBadBoy");
			
				if (character.health > 0)
				{
					character.decreaseHealth();
					character.updateCharacter();

					updateScore( -20 );
				}
				else if (character.health <= 0)
				{
					isPlaying = false;
					var gameOver: GameOver = new GameOver( assetManager, game );
					gameOver.alignPivot();
					gameOver.x = game.stage.stageWidth / 2;
					gameOver.y = game.stage.stageHeight / 2;

					game.addChild(gameOver);
				}
			}
		}
		
		function goodGuyHit() {
			var hittedGoodGuy = new GoodGuy(assetManager.getTexture("goodBoy"));
			hittedGoodGuy.scale = 0.5;
			collectedGoodGuys.push(hittedGoodGuy);
			hittedGoodGuy.x = game.stage.stageWidth - 30 * collectedGoodGuys.length;
			hittedGoodGuy.y = 30;
			game.addChild(hittedGoodGuy);

			if ( !game.saveDataObject.data.mute ) assetManager.playSound( "hitGoodBoy" );
			
			if ( blurImages != null ) {
				game.removeChild( blurImages[0] );
				blurImages.splice( 0, 1 );
			}
		}
		
		function friendsBubbleHit( i:int ) {
			if ( !game.saveDataObject.data.mute ) assetManager.playSound( "protection" );

			game.removeChild( friendsBubbles[i] );
			friendsBubbles.splice( i, 1 );
			character.protection = true;
			protectionTimer = new Timer(config.character.protectionTime);
			protectionTimer.start();
			protectionTimer.addEventListener(TimerEvent.TIMER, protectionTimerHandler);
			protectionBubble = new Image( assetManager.getTexture( "protectionBubble" ) );
			protectionBubble.alignPivot();
			protectionBubble.x = character.x + character.width / 2;
			protectionBubble.y = character.y + character.height / 2;
			game.addChild( protectionBubble );
		}
		
		private function protectionTimerHandler(e: TimerEvent): void
		{
			character.protection = false;
			protectionTimer.stop();
			game.removeChild( protectionBubble );
		}
		
		function updateScore( scoreAdd:int ) {
			this.score += scoreAdd;
			scoreText.text = "Score: " + this.score;
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
		
		function pointsTimerHandler( e:TimerEvent ) {
			updateScore( 10 );
		}
	}
}