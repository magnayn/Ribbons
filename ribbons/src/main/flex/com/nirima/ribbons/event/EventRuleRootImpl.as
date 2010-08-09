package com.nirima.ribbons.event
{
	import com.nirima.ribbons.action.IAction;
	import com.nirima.ribbons.action.ActionDefinitionImpl;
	import com.nirima.ribbons.action.ActionScope;
	import com.nirima.ribbons.context.Context;
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IEventRuleRoot;
	
	import flash.events.Event;

	public class EventRuleRootImpl implements IEventRuleRoot
	{
		public var type:String;
		
		public var actions:Array = [];
		
		public function EventRuleRootImpl()
		{
		}
		
		public function listenForType(type:String):IActionDefinition
		{
			this.type = type;	
			return new ActionDefinitionImpl(this);			
		}
		
		public function processEvent(event:Event, context:Context):Boolean
		{
			var actionScope:ActionScope = new ActionScope(context);
			
			actionScope.event = event;			
			
			for each(var adi:IAction in actions)
			{				
				actionScope.lastResult = adi.processEvent(actionScope);			
			}
			return true;
		}
	}
}