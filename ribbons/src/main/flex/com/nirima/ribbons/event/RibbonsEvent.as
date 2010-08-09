package com.nirima.ribbons.event
{
	import flash.events.Event;
	
	import mx.core.IVisualElement;

	public class RibbonsEvent extends Event
	{
		/*-.........................................Constants..........................................*/
		
		public static const VIEW_ADDED: String         = "viewAddedEvent";
		
		/*-.........................................Properties.........................................*/
		
		public var view:IVisualElement;
		
		public function RibbonsEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
	
}