package com.nirima.ribbons.dsl
{
	public interface IInjectRuleD
	{
		function inClass(clazz:Class):IInjectRuleA;
		
		
		
		function inObject(obj:Object):IInjectRuleA;
	}
}