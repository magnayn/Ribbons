package com.nirima.ribbons.event
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * An event router listens for events from rules that have been passed
	 * to it in register, and processes them.
	 * 
	 */
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
						trace(".. Register " + e.type + " on " + systemDispatcher);
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
						trace(".. Unregister " + e.type + " on " + systemDispatcher);
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
				trace(".. dispose " + type + " on " + systemDispatcher);
				systemDispatcher.removeEventListener(type,processEvent);
			}
			regCount = new Object();
		}
		
		/**
		 * Subclasses should implement this function to determine
		 * what processing to do.
		 */ 
		protected function processEvent(event:Event):void
		{
			
		}
	}
}