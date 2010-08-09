package com.nirima.ribbons.event
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class EventRouterBase
	{
		protected var systemDispatcher:IEventDispatcher;
		
		protected var regCount:Object = new Object();
		
		public function EventRouterBase(dispatcher:IEventDispatcher)
		{
			this.systemDispatcher = dispatcher;
		}
		
		
		protected function register(items:Array):void
		{
			for each(var e:EventRuleRootImpl in items)
			{
				if( regCount[e.type] == 0 || regCount[e.type] == null )
				{
					if( systemDispatcher != null )
					{
						systemDispatcher.addEventListener(e.type,processEvent);	
					}
					regCount[e.type] = 1;
				}
				else
				{
					regCount[e.type] = 1 + regCount[e.type];	
				}
				
			}
		}
		
		protected function unregister(items:Array):void
		{
			for each(var e:EventRuleRootImpl in items)
			{
				if( regCount[e.type] == 1 )
				{
					if( systemDispatcher != null )
					{
						systemDispatcher.removeEventListener(e.type,processEvent);
					}
				}
				
				regCount[e.type] = regCount[e.type] - 1;
			}
		}
		
		public function dispose():void
		{
			for(var type:String in regCount)
			{
				systemDispatcher.removeEventListener(type,processEvent);
			}
			regCount = new Object();
		}
		
		
		protected function processEvent(event:Event):void
		{
			
		}
	}
}