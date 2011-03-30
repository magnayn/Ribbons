package com.nirima.ribbons.event
{
	import com.nirima.ribbons.app.RibbonsPopUpManager;
	import com.nirima.ribbons.context.Context;
	import com.nirima.ribbons.context.IContext;
	import com.nirima.ribbons.injector.InjectionResult;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	/**
	 * The EventBus is the single place where events bubbling up through
	 * the system are caught. They are then dispatched in order to the 
	 * relevant EventResponders.
	 * 
	 * You would normally expect one event bus per application (?)
	 */
	public class EventBus extends EventRouterBase implements IContext
	{
		
		
		
		protected var parents:Dictionary = new Dictionary();
		
		protected var defaultContext:Context;
		
		public function EventBus(dispatcher:IEventDispatcher = null)
		{
			super(dispatcher);
		}
		
		public function get dispatcher():IEventDispatcher
		{
			return this.systemDispatcher;
		}
		
		public function set dispatcher(dispatcher:IEventDispatcher):void
		{
			var parentsBak:Dictionary = new Dictionary();
			
			if( this.systemDispatcher != null )
			{
				for(var ctx:Object in parents)
				{
					parentsBak[ctx] = parents[ctx];
					removeFromBus(ctx as Context);
				}
			}
			this.systemDispatcher = dispatcher;
			for(var ctx2:Object in parentsBak)
			{
				addToBus(ctx2 as Context);
			}			
		}
		
		/**
		 * An application may have at most 1 'default' context.
		 * This context will get called if a context cannot be found - 
		 * for example, from a child dialog. It is useful for simple
		 * applications that do not need parent-child relationships.
		 */
		public function addDefaultContextToBus(ctx:Context):void
		{
			addToBus(ctx);
			defaultContext = ctx;
		}
		
		/**
		 * Add a context to the bus.
		 * This must be a context rather than an EventReponder directly, because
		 * in order to determine where the event came from and which set of
		 * actions is closest, we need access to a dispatcher which is held
		 * in the context itself.
		 */
		public function addToBus(ctx:Context, parentContext:Context=null):void
		{
			register(ctx.listens);	
			parents[ctx] = parentContext;
		}
		
		
		public function removeFromBus(ctx:Context):void
		{
			unregister(ctx.listens);	
			delete parents[ctx];
		}
		
		
		
		public function injectInto(targetInstance : Object) : InjectionResult
		{
			// To which context does this object belong?
			var ctx:Context = findContextFor(targetInstance);
			
			if( ctx == null && defaultContext != null )
			{
				return defaultContext.injectInto(targetInstance);				
			}
			
			var ir:InjectionResult = new InjectionResult();
			
			while( ctx != null )
			{
				// Exit if the context does not want us to continue.
				var irl:InjectionResult = ctx.injectInto(targetInstance);
				// TODO: This may be 0 length
				if( irl != null )
				{
					ir.bindings.push(irl.bindings);
				}
				
				// look for the parent, and try again
				ctx = parents[ctx];
			}
			
			return ir;
		}
		
		public function removeInjectionsFrom(targetInstance:Object):void
		{
			// To which context does this object belong?
			var ctx:Context = findContextFor(targetInstance);
			
			if( ctx == null && defaultContext != null )
			{
				return defaultContext.removeInjectionsFrom(targetInstance);				
			}
			
			var ir:InjectionResult = new InjectionResult();
			
			while( ctx != null )
			{
				// Exit if the context does not want us to continue.
				ctx.removeInjectionsFrom(targetInstance);
				
				// look for the parent, and try again
				ctx = parents[ctx];
			}
			
		}
	
		
		/**
		 * We have recieved some kind of event!
		 */
		protected override function processEvent(event:Event):void
		{
			trace("Event Bus : Process Event " + event);
			// To which context does this event belong?
			var ctx:Context = findContextFor(event.target);
			
			if( ctx == null && defaultContext != null )
			{
				defaultContext.processEvent(event);
				return;
			}
			
			
			while( ctx != null )
			{
				// Exit if the context does not want us to continue.
				if( !ctx.processEvent(event) )
					return;
				
				// look for the parent, and try again
				ctx = parents[ctx];
			}
		}
		
		
		
	
		protected function findContextFor(o:Object):Context
		{
			while(o != null)
			{
				for ( var ctx:Object in parents )
				{
					if( ctx.dispatcher == o )
						return ctx as Context;
				}
				
				if( RibbonsPopUpManager.childToParentMap[o] != null )
				{
					o = RibbonsPopUpManager.childToParentMap[o];
				}
				else
				{				
					o = o.parent;
				}
			}
			return null;
		}
	}
}