﻿/**
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

	public class Level1 implements GameState
	{

    [Embed(source = "assets/level1test.tmx", mimeType = "application/octet-stream")]
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
		private var enemies: Vector.< Enemy >;
		private var goodGuys: Vector.< GoodGuy >;
		private var collectedGoodGuys: Array;
		private var friendsBubble: FriendsBubble;
		private var characterChosen: Boolean;
		private var score: int;
		private var scoreText: TextField;
		private var finish: Image;
		private var gameSpeed: int;
		private var background: Background;
		private var tapToJumpImg: Image;
		private var color: String;

		public function Level1(game: GameStateManager): void
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
			//score = 0;

			//Load and render map
			tilesets.push(Bitmap(new exampleTileSet()));
			mapTMX = TMXTileMap.createMap(mapXML, tilesets);

			//Set map values
			tileWidth = mapTMX.tileWidth;
			mapWidth = mapTMX.mapWidth;

			enemies = new Vector.< Enemy > ();
			goodGuys = new Vector.< GoodGuy > ();
			collectedGoodGuys = new Array();

			//Add background
			background = new Background(assetManager.getTexture("landscape_size ok"), game.stage.stageWidth);
			game.addChild(background);

			for (var i: int = 0; i < mapTMX.layers.length; i++)
			{
				if (i == 0)
				{
					game.addChild(mapTMX.layers[i].layerSprite);
				}
			}

			//add score indicator
			scoreText = new TextField(150, 50, "Score: " + score);
			game.addChild(scoreText);

			// Add bad boys to the screen
			for (var i: int = 0; i < mapTMX.layers[1].layerData.length; i++)
			{
				if (mapTMX.layers[1].layerData[i] == 1)
				{
					var enemy: Enemy = new Enemy(assetManager.getTexture("badBoy"));
					game.addChild(enemy);
					enemy.x = (i % mapWidth) * tileWidth;
					enemy.y = int(i / mapWidth) * tileWidth + 5;
					enemies.push(enemy);
				}
			}

			// Add good guys to the screen
			for (var i: int = 0; i < mapTMX.layers[2].layerData.length; i++)
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
			for (var i: int = 0; i < mapTMX.layers[3].layerData.length; i++)
			{
				if (mapTMX.layers[3].layerData[i] == 1)
				{
					friendsBubble = new FriendsBubble(assetManager);
					game.addChild(friendsBubble);
					friendsBubble.x = (i % mapWidth) * tileWidth;
					friendsBubble.y = int(i / mapWidth) * tileWidth;
				}
			}

			//add finish
			for (var i: int = 0; i < mapTMX.layers[4].layerData.length; i++)
			{
				if (mapTMX.layers[4].layerData[i] == 1)
				{
					finish = new Image(assetManager.getTexture("School"));

					finish.scale = 128 / finish.height;

					finish.alignPivot("left", "bottom");
					finish.x = (i % mapWidth) * tileWidth;
					finish.y = int(i / mapWidth) * tileWidth + tileWidth;

					game.addChild(finish);
				}
			}

			//Add eventListener for tapping the screen
			game.addEventListener(TouchEvent.TOUCH, touchEventHandler);

			//Place start screen
			levelStart = new LevelStart(assetManager, this);
			levelStart.alignPivot();
			levelStart.x = config.levelStart.marginX / 2;
			levelStart.y = config.levelStart.marginY / 2;
			game.addChild(levelStart);
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
			//var startTouch:Touch;
			var startTouch: Touch = event.getTouch(levelStart, TouchPhase.BEGAN);
			var touch: Touch = event.getTouch(game.stage, TouchPhase.BEGAN);
			if (characterChosen)
			{
				isPlaying = true;
				game.removeChild(levelStart);

				//Draw player
				character = new Character(assetManager, color);
				character.alignPivot("center", "bottom");
				character.x = tileWidth;
				character.y = game.stage.stageHeight - tileWidth * 2;
				//character.scale = 2;
				game.addChild(character); 
				characterChosen = false; 

				tapToJumpImg = new Image(assetManager.getTexture("tapToJump"));
				tapToJumpImg.x = 140;
				tapToJumpImg.y = 20;
				game.addChild(tapToJumpImg);
				var tapToJumpTimer: Timer = new Timer(2000);
				tapToJumpTimer.addEventListener(TimerEvent.TIMER, removeTapToJump);
				tapToJumpTimer.start(); 
			}
			else if (isPlaying && !character.jumping && touch)
			{
				character.jumping = true;
				character.velocity.y = -100;
			}

		}

		public function removeTapToJump(e: TimerEvent): void
		{
			game.removeChild(tapToJumpImg);
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

				// Move enemies and remove if off the screen
				for (var i: int = 0; i < enemies.length; i++)
				{
					if (enemies[i].x <= 0)
					{
						game.removeChild(enemies[i]);
						enemies.splice(i, 1);
					}
					else
					{
						enemies[i].x -= gameSpeed;
					}
				}

				// Move good boys and remove is off the screen
				for (var i: int = 0; i < goodGuys.length; i++)
				{
					if (goodGuys[i].x <= 0)
					{
						game.removeChild(goodGuys[i]);
						goodGuys.splice(i, 1);
					}
					else
					{
						goodGuys[i].x -= gameSpeed;
					}
				}

				// Move friends bubble and remove if off the screen
				if (friendsBubble.x <= 0)
				{
					game.removeChild(friendsBubble);
				}
				else
				{
					friendsBubble.x -= gameSpeed;
				}
				// Quick fix because it fucks up other way..... fix this later
				// (after passing the friends bubble it adds protection after first 
				// jump, even the character didn't touch the protection bubble)
				if ((friendsBubble.x + friendsBubble.width / 2) <= (character.x - character.width / 2) && !friendsBubble.isHit)
				{
					friendsBubble.block = true;
				}

				// Move finish
				finish.x -= gameSpeed;

				// Check collision with enemies
				for (var i: int = 0; i < enemies.length; i++)
				{
					if (character.bounds.intersects(enemies[i].bounds) && !enemies[i].isHit)
					{
						enemies[i].isHit = true;

						if (character.health > 0)
						{
							character.decreaseHealth();
							character.updateCharacter();
						}
						else if (character.health <= 0)
						{
							isPlaying = false;
							var gameOver: GameOver = new GameOver(assetManager.getTexture("gameOver"));
							gameOver.alignPivot();
							gameOver.x = game.stage.stageWidth / 2;
							gameOver.y = game.stage.stageHeight / 2;
							game.addChild(gameOver);
							break;
						}
					}
				}

				// Check collision with good boys
				for (var i: int = 0; i < goodGuys.length; i++)
				{
					if (character.bounds.intersects(goodGuys[i].bounds) && !goodGuys[i].isHit)
					{
						goodGuys[i].isHit = true;

						score += 10;
						scoreText.text = "Score: " + score;

						var hittedGoodGuy = new GoodGuy(assetManager.getTexture("goodBoy"));
						hittedGoodGuy.scale = 0.5;
						collectedGoodGuys.push(hittedGoodGuy);
						hittedGoodGuy.x = game.stage.stageWidth - 30 * collectedGoodGuys.length;
						hittedGoodGuy.y = 30;
						game.addChild(hittedGoodGuy);

					}
				}

				// Check collision with friends bubble
				if (character.bounds.intersects(friendsBubble.bounds) && !friendsBubble.isHit && !friendsBubble.block)
				{
					friendsBubble.isHit = true;
					score += 20;
					scoreText.text = "Score: " + score;

					game.removeChild(friendsBubble);
					character.addProtection();

				}

				var xLoc: int = (character.x - mapTMX.layers[0].layerSprite.x) / tileWidth;
				var yLoc: int = (character.y - tileWidth) / tileWidth;
				var tileNum: int = (yLoc * mapWidth) + xLoc;

				//check collision with ground underneath character and adjust character.y
				if (character.y % tileWidth > 0 && mapTMX.layers[0].layerData[tileNum + mapWidth] == 1)
				{
					character.jumping = false;
					character.y -= character.y % tileWidth
				}
				else if (mapTMX.layers[0].layerData[tileNum + mapWidth] == 0 && character.jumping == false)
				{
					character.jumping = true;
					character.velocity.y = 0;
				}

				//check if on ascending hill
				if ((mapTMX.layers[0].layerData[tileNum] == 3 || mapTMX.layers[0].layerData[tileNum + mapWidth] == 3))
				{

					if (!character.jumping)
					{
						var groundHeight: int = (game.stage.stageHeight - character.y) / tileWidth;
						groundHeight *= tileWidth;
						var hillHeight: int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
						character.y = game.stage.stageHeight - groundHeight - hillHeight;
					}
					else if (character.jumping)
					{
						var charTileX: int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
						var charTileY: int = (game.stage.stageHeight - character.y) % tileWidth;

						if (charTileY < charTileX)
							character.jumping = false;

					}
				}

				//check if on descending hill
				if ((mapTMX.layers[0].layerData[tileNum] == 2 || mapTMX.layers[0].layerData[tileNum + mapWidth] == 2))
				{
					if (!character.jumping)
					{
						var groundHeight: int = character.y / tileWidth;
						groundHeight *= tileWidth;
						var hillHeight: int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
						character.y = groundHeight + hillHeight;
					}
					else if (character.jumping)
					{
						var charTileX: int = (character.x - mapTMX.layers[0].layerSprite.x) % tileWidth;
						var charTileY: int = (game.stage.stageHeight - character.y) % tileWidth;

						if (charTileY < charTileX)
							character.jumping = false;
					}
				}

				 if( character.bounds.intersects( finish.bounds ) )
				{
					isPlaying = false;

					var scoreScreen:ScoreMenu = new ScoreMenu( assetManager, game.stage.stageWidth, game.stage.stageHeight, score );
					game.addChild( scoreScreen );
					
					if ( game.saveDataObject.data.level1HighScore == null || game.saveDataObject.data.level1HighScore < score ) {
						game.saveDataObject.data.level1HighScore = score;
						game.saveDataObject.flush();
					}

					trace( "FINISH" );
					
					game.removeEventListener( Event.ENTER_FRAME, update ); //Doesn't work???
				}
            
			}
		}
	}
}
