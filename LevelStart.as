/**
 * Created by Lourens on 5-5-2016.
 */
package
{
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
		private var assetManager: AssetManager;
		private var config: Object;
		private var level:GameState;
		private var characterYellow: Image;
		private var characterBlue:Image;
		private var characterPink: Image;
		private var characterGreen: Image;

		public function LevelStart(assetManager:AssetManager, level:GameState)
		{
			this.level = level;
			this.assetManager = assetManager;
			config = assetManager.getObject("config");
			addEventListener(Event.ADDED_TO_STAGE, initialize);
		}

		private function initialize()
		{
			//Place background
			var background:Quad = new Quad(stage.stageWidth - config.levelStart.marginX, stage.stageHeight - config.levelStart.marginY, 41701);
			addChild( background );

			//place text
			var text:Image = new Image( assetManager.getTexture( "chooseTheCharacter" ) );
			text.alignPivot();
			text.x = background.width / 2;
			text.y = 70;
			addChild(text);
			
			//Adding the characters for the choosing screen
			characterYellow = new Image(assetManager.getTexture("yellow"));
			characterYellow.x = 30;
			characterYellow.y = 140;
			characterYellow.scale=1.5;
			addChild(characterYellow);
			
			characterBlue=new Image(assetManager.getTexture("blue"));
			characterBlue.x=110;
			characterBlue.y=140;
			characterBlue.scale=1.5;
			addChild(characterBlue);
			
			characterGreen=new Image(assetManager.getTexture("green"));
			characterGreen.x=190;
			characterGreen.y=140;
			characterGreen.scale=1.5;
			addChild(characterGreen);
			
			characterPink=new Image(assetManager.getTexture("pink"));
			characterPink.x=270;
			characterPink.y=140;
			characterPink.scale=1.5;
			addChild(characterPink);
		}

		public function handleTouch(event: TouchEvent): void
		{
			var clickYellow: Touch = event.getTouch(characterYellow, TouchPhase.BEGAN);
			var clickBlue:Touch=event.getTouch(characterBlue,TouchPhase.BEGAN);
			var clickGreen:Touch=event.getTouch(characterGreen,TouchPhase.BEGAN);
			var clickPink:Touch=event.getTouch(characterPink,TouchPhase.BEGAN);
			
			if (clickYellow)
			{
				trace("You touched yellow");
				assetManager.playSound( "mouseClick" );
				level.startPlaying("yellow");
			}
			else if(clickBlue)		
			{
				trace("You touched blue");
				assetManager.playSound( "mouseClick" );
				level.startPlaying("blue");
			}
			else
				if(clickGreen)
				{
					trace("You touched green");
					assetManager.playSound( "mouseClick" );
					level.startPlaying("green");
				}
			else
				if(clickPink)
				{
					trace("you touched pink");
					assetManager.playSound( "mouseClick" );
					level.startPlaying("pink");
				}
		}
	}
}
