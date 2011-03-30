package com.nirima.ribbons.app
{
	import com.nirima.ribbons.context.Context;
	import com.nirima.ribbons.context.IContext;
	import com.nirima.ribbons.event.EventBus;
	import com.nirima.ribbons.injector.AutoViewInjector;
	
	import flash.events.IEventDispatcher;
	
	import mx.events.FlexEvent;

	/**
	 * Singleton instance for a ribbons application
	 */
	public class RibbonsApplication
	{
		public var app:IEventDispatcher;
		
		public var autoViewInjector:AutoViewInjector;
		public var bus:EventBus;		
		
		protected static var __instance:RibbonsApplication;
		
		public static function get Instance():RibbonsApplication
		{
			return __instance;
		}
		
		/**
		 * parent: the root, parent application object
		 * contextClass: the class name of the 'main' context to create
		 * and add to the bus. 
		 */
		public function RibbonsApplication(parent:Object, contextClass:Class)
		{
			trace("App");
			this.app = IEventDispatcher(parent);
			
			bus = new EventBus(app);
			
			var ctx:Context = new contextClass(app);
			
			autoViewInjector = new AutoViewInjector(bus, app);
			
			//bus.addDefaultContextToBus(ctx);
			bus.addToBus(ctx);
			
			IEventDispatcher(app).addEventListener(FlexEvent.CREATION_COMPLETE,
				appCreationCompleteHandler);
			
			__instance = this;
		}
		
		public function appCreationCompleteHandler(event:FlexEvent):void
		{
			// The system manager is now ready, so shuffle the bus and the autoview
			// injector to look at this instead.
			var dispatcher:IEventDispatcher = Object(app).systemManager;
			
			bus.dispatcher = dispatcher;
			autoViewInjector.dispatcher = dispatcher;			
		}
	}
}