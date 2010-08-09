package com.nirima.ribbons.dsl
{
	public interface IInjectorRuleRoot
	{
		
		/**
		 * Inject by target class
		 */
		function whenInjectingInto(clazz : Class) : IInjectRuleB;
	}
}