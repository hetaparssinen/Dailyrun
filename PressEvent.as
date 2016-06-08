package  {
	import starling.events.Event;
	
	public class PressEvent extends Event
	{
		public var parametro:Object;
		public static const newScreen:String = "newScreen";
		
		
		public function PressEvent(type:String, _parametro:Object = null, bubbles:Boolean=false) {
			
			super(type, bubbles);
			this.parametro = _parametro;
			
		}

	}
	
}
