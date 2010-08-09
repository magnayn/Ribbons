package com.nirima.ribbons.action
{
	import com.nirima.ribbons.context.Bind;
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IActionDefinitionH;
	
	import flash.events.Event;

	public class InlineInvokeAction implements IAction, IActionDefinitionH
	{
		protected var actionDefinition:IActionDefinition;
		
		protected var hasParameters:Boolean = false;
		protected var args:*;
		protected var func:Function;
		
		public function InlineInvokeAction(ad:IActionDefinition, func:Function)
		{
			this.actionDefinition = ad;
			this.func = func;
		}
		
		public function withArguments(object:*):IActionDefinition
		{
			this.args = object;
			this.hasParameters = true;
			return actionDefinition;
		}
		
		public function withoutArguments():IActionDefinition
		{
			return actionDefinition;
		}
		
		public function processEvent(event:ActionScope):Object
		{
			if( !hasParameters )
				func();
			else
			{
				var params:Array = calculateParameters(event); 
				func.apply(null, params);
				
				
					
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