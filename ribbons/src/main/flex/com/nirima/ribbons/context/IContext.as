package com.nirima.ribbons.context
{
	import com.nirima.ribbons.injector.InjectionResult;

	public interface IContext
	{
		function injectInto(targetInstance : Object) : InjectionResult;
		
		function removeInjectionsFrom(targetInstance : Object) : void;		
	}
}