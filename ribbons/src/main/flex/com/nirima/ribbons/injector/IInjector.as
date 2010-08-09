package com.nirima.ribbons.injector
{
	import com.nirima.ribbons.dsl.IInjectorRuleRoot;
	import com.nirima.ribbons.provider.IProvider;

	public interface IInjector
	{	
//		/**
//		 * Create an InjectorRule
//		 */
//		function newRule() : IInjectorRuleRoot;
		
		/**
		 * Manually request injection into an object
		 */
		function injectInto(targetInstance : Object, scope:IProvider) : InjectionResult;	
	}
}