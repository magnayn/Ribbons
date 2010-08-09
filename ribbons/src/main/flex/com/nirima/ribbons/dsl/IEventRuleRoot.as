package com.nirima.ribbons.dsl
{
	public interface IEventRuleRoot
	{
		//<EventHandlers debug="true" type="{FormEvent.SAVE}">	
		//	<MethodInvoker generator="{FormsManager}" method="saveForm" arguments="{[event.formType, event.episode, event.formData]}"/>	
		//	<EventAnnouncer generator="{NavigationEvent}" type="{NavigationEvent.WARD}"/>
		//</EventHandlers>
		function listenForType(type:String):IActionDefinition;
	}
}