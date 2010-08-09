package com.nirima.ribbons.action
{
	import com.nirima.ribbons.context.Bind;
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IActionDefinitionF;
	import com.nirima.ribbons.dsl.IActionDefinitionH;
	
	import flash.events.Event;
	import flash.utils.Proxy;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class InvokeMethodAction implements IAction, IActionDefinitionF, IActionDefinitionH
	{
		protected var actionDefinition:IActionDefinition;
		
		protected var klass:Class;
		protected var method:String;
		protected var args:*;
		
		public function InvokeMethodAction(ad:IActionDefinition, method:String)
		{
			this.actionDefinition = ad;
			this.method = method;
		}
		
		public function onType(klass:Class):IActionDefinitionH
		{
			this.klass = klass;
			return this;
		}
		
		public function withArguments(object:*):IActionDefinition
		{
			this.args = object;
			return actionDefinition;
		}
		
		public function withoutArguments():IActionDefinition
		{
			return actionDefinition;
		}
		
		public function processEvent(event:ActionScope):Object
		{
			var instance:Object = event.getObject(klass);
			
			if(!args)
			{				
				return instance[method]();
			}
			else
			{
				var parameters:Array = calculateParameters(event);
				return (instance[method] as Function).apply(instance, parameters);
			}
			
			return true;
		}
		
		private function calculateParameters(scope:ActionScope):Array
		{
			var r:Array = [];
			
			if( args is Array )
			{
				var inArgs:Array = args as Array;
				for each( var arg:Object in inArgs )
				{
					r.push( calculateParameter(scope, arg) );
				}
			}
			else 
			{
				r.push( calculateParameter(scope, args) );
			}
			return r;
		}
		
		private function calculateParameter(scope:ActionScope, item:Object):Object
		{
			if( item is Bind )
			{
				return Bind(item).evaluate(scope);	
			}
			else
			{
				return item;
			}
			
		}
		
		
	}
}