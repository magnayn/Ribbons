package com.nirima.ribbons.dsl
{
	public interface IActionDefinitionH
	{
		function withArguments(object:*):IActionDefinition;
		
		function withoutArguments():IActionDefinition;
	}
}