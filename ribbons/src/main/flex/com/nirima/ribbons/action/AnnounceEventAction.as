package com.nirima.ribbons.action
{
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IActionDefinitionG;
	
	import flash.events.Event;

	public class AnnounceEventAction implements IAction, IActionDefinitionG
	{
		protected var actionDefinition:IActionDefinition;
		public function AnnounceEventAction(ad:IActionDefinition, eventClass:Class)
		{
			this.actionDefinition = ad;
		}
		
		public function ofType(type:String):IActionDefinition
		{
			return actionDefinition;
		}
		
		public function processEvent(event:ActionScope):Object
		{
			return true;
		}
	}
}