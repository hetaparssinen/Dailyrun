package  
{
	import starling.display.Sprite;
	import starling.display.Quad;
	import starling.text.TextField;
	
	public class Loader extends Sprite
	{
		
		private var bar:Quad
		
		public function Loader() 
		{
			var background:Quad = new Quad( 480, 320, 15238888 );
			addChild( background );

			var logo:TextField = new TextField( 480, 200, "DAILY RUN", "DK Codswallop", 54 );
			logo.color = 15466636;
			logo.alignPivot("center", "center");
			logo.y = 60;
			logo.x = 480 / 2;
			addChild( logo );
			var backdrop:Quad = new Quad (300, 40, 16777215);
			backdrop.x = 480 / 2 - backdrop.width / 2;
			backdrop.y = 320 / 2 - backdrop.height / 2;
			addChild (backdrop);
			bar=new Quad (300, 40, 2875959);
			bar.x = 480 / 2 - bar.width / 2;
			bar.y = 320 / 2 - bar.height / 2;
			addChild (bar);
		}
		
		public function update ( scale:Number )
		{
			bar.scaleX=scale;
		}

	}
	
}
