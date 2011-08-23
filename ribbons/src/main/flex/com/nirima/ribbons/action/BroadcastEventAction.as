package com.nirima.ribbons.action
{
	import com.nirima.ribbons.app.RibbonsApplication;
	import com.nirima.ribbons.dsl.IActionDefinition;

	public class BroadcastEventAction implements IAction
	{
		public function BroadcastEventAction(ad:IActionDefinition)
		{
		}
		
		public function processEvent(event:ActionScope):Object
		{
			RibbonsApplication.Instance.bus.broadcastEvent(event.event, event.context);
			return true;
		}
	}
}