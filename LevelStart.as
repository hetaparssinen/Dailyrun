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
			//Place border
			var border: Quad = new Quad(stage.stageWidth - config.levelStart.marginX, stage.stageHeight - config.levelStart.marginY, 16711680);
			addChild(border);

			//place box
			var box: Quad = new Quad(border.width - config.levelStart.borderThickness, border.height - config.levelStart.borderThickness, 16776960);
			box.alignPivot();
			box.x = this.width / 2;
			box.y = this.height / 2;
			addChild(box);
			

			//place text
			var text: TextField = new TextField(box.width, 50, "Choose your character", "Verdana", 30);
			text.alignPivot();
			text.x = box.width / 2 + config.levelStart.borderThickness / 2;
			text.y = 40;
			addChild(text);
			
			
			
			
			//Adding the characters for the choosing screen
		

			characterYellow = new Image(assetManager.getTexture("yellow"));
			characterYellow.x = 30;
			characterYellow.y = 100;
			characterYellow.scale=1.5;
			addChild(characterYellow);
			
			
			characterBlue=new Image(assetManager.getTexture("blue"));
			characterBlue.x=110;
			characterBlue.y=100;
			characterBlue.scale=1.5;
			addChild(characterBlue);
			
			characterGreen=new Image(assetManager.getTexture("green"));
			characterGreen.x=190;
			characterGreen.y=100;
			characterGreen.scale=1.5;
			addChild(characterGreen);
			
			characterPink=new Image(assetManager.getTexture("pink"));
			characterPink.x=270;
			characterPink.y=100;
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
				level.startPlaying("yellow");
			}
			else
				if(clickBlue)
					
			{
				trace("You touched blue");
				level.startPlaying("blue");
				
			}
			else
				if(clickGreen)
				{
					trace("You touched green");
					level.startPlaying("green");
				}
			else
				if(clickPink)
				{
					trace("you touched pink");
					level.startPlaying("pink");
				}
				
			
		}
	}
}
