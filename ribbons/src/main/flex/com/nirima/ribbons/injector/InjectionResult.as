package com.nirima.ribbons.injector
{
	import com.nirima.ribbons.app.RibbonsApplication;
	import com.nirima.ribbons.context.Context;
	import com.nirima.ribbons.provider.IProvider;
	import com.nirima.ribbons.rule.Rule;
	import com.nirima.ribbons.rule.RuleFactory;
	import com.nirima.ribbons.utils.Binder;
	
	import flash.events.IEventDispatcher;

	public class InjectionResult
	{
		public var bindings:Array = [];
		public var contexts:Array = [];
		
		public function InjectionResult()
		{
		}
		
		public function inject(targetInstance:Object, rf:RuleFactory, scope:IProvider):void
		{
			for each(var rule:Rule in rf.rules )
			{
				if( rule.mapClass )
				{
					mapClass(targetInstance, rule, scope);
				}
				else
				{
					var object:Object = rule.sourceObject;
					if( object == null )
					{
						object = scope.getInstance(rule.sourceClass);
					}
					
					var b:Binder = new Binder();
					b.bind(targetInstance, rule.targetPropertyName, object, rule.sourceKey);
					
					bindings.push(b);
				}
			}
		}
		
		public function remove():void
		{
			for each(var binding:Binder in bindings)
			{
				binding.unbind();
			}
			
			for each(var context:Context in contexts)
			{
				RibbonsApplication.Instance.bus.removeFromBus(context);
			}
		}
		
		public function isEmpty():Boolean
		{
			return bindings.length == 0;
		}
		
		protected function mapClass(targetInstance:Object, rule:Rule, scope:IProvider):void
		{
			if( scope is Context )
			{
				var context:Context = scope as Context;
				
				var newContext:Context = scope.createInstance(rule.mapClass, [IEventDispatcher(targetInstance)]) as Context;
				
				RibbonsApplication.Instance.bus.addToBus(newContext, context);
				
				newContext.injectInto(targetInstance);
				
				contexts.push(newContext);	
			}
			else
			{
				throw new Error("Cannot automatically map a class if the scope is not a context");
			}
			
		}
	}
}