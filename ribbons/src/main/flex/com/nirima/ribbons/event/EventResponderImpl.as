package com.nirima.ribbons.event
{
	import com.nirima.ribbons.context.Context;
	import com.nirima.ribbons.dsl.IEventRuleRoot;
	
	import flash.events.Event;

	public class EventResponderImpl implements IEventResponder
	{
		public var listens:Array = [];
		
		public function EventResponderImpl()
		{
			
		}
		public function newListener():IEventRuleRoot
		{
			var err:EventRuleRootImpl = new EventRuleRootImpl();
			listens.push(err);
			return err;
		}
		
		public function processEvent(event:Event, ctx:Context):Boolean
		{
			for each(var eri:EventRuleRootImpl in listens)
			{
				if( eri.type == event.type )
				{
					if( !eri.processEvent(event, ctx) )
						return false;
				}
			}
			
			return true;
		}
	}
}