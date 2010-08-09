package com.nirima.ribbons.event
{
	import com.nirima.ribbons.dsl.IEventRuleRoot;
	
	import flash.events.Event;

	public interface IEventResponder
	{
		function newListener():IEventRuleRoot;	
		
		
	}
}