package com.nirima.ribbons.context
{
	import com.nirima.ribbons.event.EventResponderImpl;
	import com.nirima.ribbons.event.IEventHandler;
	import com.nirima.ribbons.event.IEventResponder;
	import com.nirima.ribbons.injector.IInjector;
	import com.nirima.ribbons.injector.InjectionResult;
	import com.nirima.ribbons.injector.InjectorImpl;
	import com.nirima.ribbons.provider.CacheProvider;
	import com.nirima.ribbons.provider.ConstructorProvider;
	import com.nirima.ribbons.provider.IProvider;
	import com.nirima.ribbons.utils.Binder;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;

	public class Context implements IEventHandler, IContext, IProvider
	{
		protected var provider:CacheProvider = new CacheProvider( new ConstructorProvider() );
		
		protected var injector:InjectorImpl = new InjectorImpl();
		
		protected var eventHandler:EventResponderImpl = new EventResponderImpl();
		
		private var _liveInjections:Dictionary = new Dictionary();
		
		protected var _dispatcher:IEventDispatcher;
		
			
		public function processEvent(event:Event):Boolean
		{			
			var retval:Boolean = eventHandler.processEvent(event, this);
			return retval;
		}
		
		public function get dispatcher():IEventDispatcher
		{
			return _dispatcher;
		}		
		
		public function Context( dispatcher:IEventDispatcher )		
		{
			this._dispatcher = dispatcher;
		}
		
		// ---------------------------------------------------------------------------------
		// IProvider functions
		
		public function getInstance(ofClass:Class, createIfNotFound:Boolean = true, id:String=null):*
		{
			var instance:* = provider.getInstance(ofClass, createIfNotFound, id);
			injectInto(	instance );
			
			return instance;			
		}
		
		public function haveInstance(ofClass:Class, id:String=null):Boolean
		{
			return provider.haveInstance(ofClass, id);
		}
		
		public function createInstance(ofClass:Class, params:Array = null):*
		{
			var item:Object = provider.createInstance(ofClass, params);
			injectInto(item);
			return item;
		}
		
		public function injectInto(targetInstance : Object) : InjectionResult
		{			
			if( _liveInjections[ targetInstance ] != null )
			{
				return _liveInjections[ targetInstance ];
			}
			
			var injectionResult:InjectionResult = injector.injectInto(targetInstance, this);
			
			// NM: I believe this is a bug. IT is attempting to optimise away the case
			// where there are no rules fired - but the InjectionResult may have additional
			// bindings added by the user, therefore we want it to be in the live injections map,
			// otherwise those bindings will never be cleared.
			
			//if( injectionResult == null || injectionResult.isEmpty() )
			//{
			//	return injectionResult;
			//}
			
			_liveInjections[ targetInstance ] =  injectionResult ;
			return injectionResult;
		}
		
		public function removeInjectionsFrom(targetInstance : Object) : void
		{
			var injectionResult:InjectionResult = _liveInjections[targetInstance];
			if( injectionResult != null )
			{
				injectionResult.remove();
				delete _liveInjections[targetInstance];
			}
		}
		
		public function get listens():Array
		{
			return eventHandler.listens;
		}
		
		
		public  function binding(name:String):Bind
		{
			return new Bind(name);
		}
		
		public function dispose():void
		{
			for each(var injectionResult:InjectionResult in _liveInjections)
			{
				injectionResult.remove();
			}
			
			_liveInjections = new Dictionary();
		}
		

	}
}