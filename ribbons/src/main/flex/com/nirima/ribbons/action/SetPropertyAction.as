package com.nirima.ribbons.action
{
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IActionDefinitionH;
	import com.nirima.ribbons.dsl.IActionDefinitionJ;
	import com.nirima.ribbons.dsl.IActionDefinitionK;
	
	import flash.events.Event;

	public class SetPropertyAction implements IAction, IActionDefinitionJ, IActionDefinitionK
	{
		public var actionDefinition:IActionDefinition;
		public function SetPropertyAction(ad:IActionDefinition, property:String)
		{
			this.actionDefinition = ad;
		}
		
		public function onType(clazz:Class):IActionDefinitionK
		{
			return this;
		}
		
		public function from(source:*):IActionDefinition
		{
			return actionDefinition;
		}
		
		public function withArguments(object:Object):IActionDefinition
		{
			
			return actionDefinition;
		}
		
		public function withoutArguments():IActionDefinition
		{
			return actionDefinition;	
		}
	
		public function processEvent(event:ActionScope):Object
		{
			return true;
		}
	}
}