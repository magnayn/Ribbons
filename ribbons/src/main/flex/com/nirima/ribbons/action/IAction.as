package com.nirima.ribbons.action
{
	import flash.events.Event;

	public interface IAction
	{
		function processEvent(event:ActionScope):Object;	
	}
}