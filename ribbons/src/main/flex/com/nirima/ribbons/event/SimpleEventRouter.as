package com.nirima.ribbons.event
{
	import com.nirima.ribbons.context.Context;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * A very simple event router, that processes events by passing them
	 * through to a Context object.
	 */
	public class SimpleEventRouter extends EventRouterBase
	{
		private var ctx:Context;
		public function SimpleEventRouter(dispatcher:IEventDispatcher, ctx:Context)
		{
			super(dispatcher);
			this.ctx = ctx;
			register(ctx.listens);
		}
		
		/**
		 * We have recieved some kind of event!
		 */
		protected override function processEvent(event:Event):void
		{			
			ctx.processEvent(event);					
		}
	}
}