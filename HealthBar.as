package  
{
	import starling.display.Sprite;
	import starling.display.Quad;
	
	public class HealthBar extends Sprite
	{
		
		private var bar:Quad
		
		public function HealthBar() 
		{
			var backdrop:Quad = new Quad (40, 4, 0x02000);
			addChild (backdrop);
			bar=new Quad (38, 2, 0xC050C9);
			bar.x=bar.y=1;
			addChild (bar);
		}
		
		public function update ( scale:Number )
		{
			bar.scaleX=scale;
		}

	}
	
}
