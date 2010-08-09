package com.nirima.ribbons.dsl
{
	public interface IInjectRuleA
	{
		function injectProperty(name:String):IInjectRuleC;
		
		function injectMap(mapClass:Class):IInjectRuleA;
	}
}