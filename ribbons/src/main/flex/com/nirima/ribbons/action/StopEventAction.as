package com.nirima.ribbons.action
{
	public class StopEventAction implements IAction
	{
		public function StopEventAction()
		{
		}
		
		public function processEvent(event:ActionScope):Object
		{
			event.event.stopImmediatePropagation();
			return false;
		}
	}
}