package com.nirima.ribbons.action
{
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IActionDefinitionG;
	
	import flash.events.Event;

	public class AnnounceEventAction implements IAction, IActionDefinitionG
	{
		protected var actionDefinition:IActionDefinition;
		protected var type:String
		protected var eventClass:Class;
		
		public function AnnounceEventAction(ad:IActionDefinition, eventClass:Class)
		{
			this.actionDefinition = ad;
			this.eventClass = eventClass;
		}
		
		public function ofType(type:String):IActionDefinition
		{
			this.type =  type;
			return actionDefinition;
		}
		
		public function processEvent(event:ActionScope):Object
		{
			var e:Event;
			if( type == null )
			{
				e = new eventClass();
			}
			else
			{
				e = new eventClass(type);
			}
			
			event.context.dispatcher.dispatchEvent(e);
			
			return true;
		}
	}
}