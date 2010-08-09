package com.nirima.ribbons.event
{
	import flash.events.Event;

	public interface IEventHandler
	{
		function processEvent(event:Event):Boolean;
	}
}