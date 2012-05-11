package com.nirima.ribbons.injector
{
	import com.nirima.ribbons.dsl.IInjectorRuleRoot;
	import com.nirima.ribbons.provider.IProvider;
	import com.nirima.ribbons.rule.RuleFactory;

	public class InjectorImpl implements IInjector
	{
		private var rules:Array = [];
		
		public function InjectorImpl()
		{
		}
		
		public function newRule() : IInjectorRuleRoot
		{
			var x:RuleFactory = new RuleFactory(this);
			rules.push(x);
			
			return x;
		}
		
		/**
		 * Manually request injection into an object
		 */
		public function injectInto(targetInstance : Object, scope:IProvider) : InjectionResult
		{
			var injectionResult:InjectionResult = new InjectionResult();
			
			for each( var rule:RuleFactory in rules )
			{
				if( targetInstance is rule.targetClass )
				{
					injectionResult.inject(targetInstance, rule, scope);
				}
			}
			
			return injectionResult;
		}
		
	}
}