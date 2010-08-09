package com.nirima.ribbons.dsl
{
	public interface IActionDefinition
	{
			
		
		// <MethodInvoker generator="{FormsManager}" method="saveForm" arguments="{[event.formType, event.episode, event.formData]}"/>			
		function invokeMethod(method:String):IActionDefinitionF;
		
		// <AnnounceEvent>
		function announceEvent(eventClass:Class):IActionDefinitionG;
		
		function inlineInvokeMethod(method:Function):IActionDefinitionH;
		
		function setProperty(propertyName:String):IActionDefinitionJ;
		
		function stopEvent():IActionDefinition;
	}
}