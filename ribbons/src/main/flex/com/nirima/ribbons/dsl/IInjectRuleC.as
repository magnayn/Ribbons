package com.nirima.ribbons.dsl
{
	public interface IInjectRuleC
	{
		
		
		function fromSourceKey(name:String):IInjectRuleD;
		
		function fromSourceClass(clazz:Class):IInjectRuleA;
		
		function fromSourceObject(obj:Object):IInjectRuleA;
		
	}
}