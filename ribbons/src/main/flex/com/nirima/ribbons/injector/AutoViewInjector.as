package com.nirima.ribbons.injector
{
	import com.nirima.ribbons.context.IContext;
	import com.nirima.ribbons.event.EventBus;
	import com.nirima.ribbons.event.RibbonsEvent;
	
	import flash.events.IEventDispatcher;
	
	import mx.events.FlexEvent;

	/**
	 * The auto view injector listens for creation events of controls.
	 * On creation, it asks the context whether it wants to inject any values. If so,
	 * it registers for the removal event - when this happens, it calls the event
	 * bus back in order to have it remove any live injections.
	 */
	public class AutoViewInjector
	{
		private var _dispatcher:IEventDispatcher;
		private var _eventBus:IContext;
		
		/**
		 * eventBus = the Context or Bus to send created and removed events to.
		 * dispatcher = the dispatcher to listen for these events in
		 */
		public function AutoViewInjector(eventBus:IContext, dispatcher:IEventDispatcher)
		{
			this.dispatcher = dispatcher;
			this._eventBus  = eventBus;
		}
		
		public function get dispatcher():IEventDispatcher
		{
			return this.dispatcher;
		}
		
		public function set dispatcher(d:IEventDispatcher):void
		{
			if( _dispatcher != null )
			{
				_dispatcher.removeEventListener(FlexEvent.CREATION_COMPLETE, creationComplete);
				_dispatcher.removeEventListener(FlexEvent.CREATION_COMPLETE, creationComplete, true);
				
				_dispatcher.removeEventListener(RibbonsEvent.VIEW_ADDED, added, false);
				_dispatcher.removeEventListener(RibbonsEvent.VIEW_REMOVED, removed2, false);
			}
			
			_dispatcher = d;
			
			if( _dispatcher != null )
			{
				// Add creationcomplete twice.
				
				// If, for example, _dispatcher is pointing at a popup window.
				// The capture event will get all creation complete events for children (at capture time).
				// However, the creation for the object *itself* will only appear AT_TARGET, and that
				// is only captured in non-use-capture event listeners.
				
				// We add as weak references - the events won't keep the auto view injector around, which is
				// what we want (though should not make any difference as this is a 1-way binding).
				
				_dispatcher.addEventListener(FlexEvent.CREATION_COMPLETE, creationComplete, false, 0, true);
				_dispatcher.addEventListener(FlexEvent.CREATION_COMPLETE, creationComplete, true, 0, true);
				_dispatcher.addEventListener(RibbonsEvent.VIEW_ADDED, added, false, 0, true);
				_dispatcher.addEventListener(RibbonsEvent.VIEW_REMOVED, removed2, false, 0, true);
			}
		}
		
		
		protected function creationComplete(event:FlexEvent):void
		{
			//getLogger().warn(">>> CreateEvent on " + event.target );
			var injectionResult:InjectionResult = _eventBus.injectInto(event.target);
			if( injectionResult != null && !injectionResult.isEmpty() )
			{
				trace("Register for Remove events on " + event.target);	
				event.target.addEventListener(FlexEvent.REMOVE, removed, false, 0, true);
			}
		}
		
		protected function removed(event:FlexEvent):void
		{
			//trace(event + " -" + event.target );
			_eventBus.removeInjectionsFrom(event.target);
			event.target.removeEventListener(FlexEvent.REMOVE, removed);
		}
		
		protected function removed2(event:RibbonsEvent):void
		{
			//trace(event + " -" + event.target );
			_eventBus.removeInjectionsFrom(event.view);			
		}
		
		protected function added(event:RibbonsEvent):void
		{
			//trace(event + " +" + event.view );
			var injectionResult:InjectionResult = _eventBus.injectInto(event.view);
			if( injectionResult != null && !injectionResult.isEmpty() )
			{
				event.view.addEventListener(FlexEvent.REMOVE, removed, false, 0, true);
			}
		}
		
		public function dispose():void
		{
			// Unhook all events..
			dispatcher = null;
		}
		
	}
}