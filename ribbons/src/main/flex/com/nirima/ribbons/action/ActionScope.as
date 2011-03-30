package com.nirima.ribbons.action
{
	import com.nirima.ribbons.context.Context;
	import com.nirima.ribbons.provider.IProvider;
	
	import flash.events.Event;

	public class ActionScope
	{
		public var event:Event;
		public var lastResult:*;
		
		private var provider:IProvider;
		
		public function getObject(klass:Class):*
		{
			return provider.getInstance(klass);
		}
		
		public function ActionScope(provider:IProvider)
		{
			this.provider = provider;
		}
		
		public function get context():Context
		{
			return provider as Context;
		}
	}
}