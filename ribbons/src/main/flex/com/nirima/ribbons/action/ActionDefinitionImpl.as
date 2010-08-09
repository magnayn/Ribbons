package com.nirima.ribbons.action
{
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IActionDefinitionF;
	import com.nirima.ribbons.dsl.IActionDefinitionG;
	import com.nirima.ribbons.dsl.IActionDefinitionH;
	import com.nirima.ribbons.dsl.IActionDefinitionJ;
	import com.nirima.ribbons.dsl.IEventRuleRoot;
	import com.nirima.ribbons.event.EventRuleRootImpl;

	public class ActionDefinitionImpl implements IActionDefinition
	{
		protected var eventRuleRoot:EventRuleRootImpl;
		
		
		public function ActionDefinitionImpl(e:EventRuleRootImpl)
		{
			eventRuleRoot = e;
		}
		
		public function invokeMethod(method:String):IActionDefinitionF
		{
			var item:IActionDefinitionF = new InvokeMethodAction(this, method) ;
			eventRuleRoot.actions.push( item );
			return item;
		}
		
		// <AnnounceEvent>
		public function announceEvent(eventClass:Class):IActionDefinitionG
		{
			var item:IActionDefinitionG = new AnnounceEventAction(this, eventClass);
			eventRuleRoot.actions.push( item );
			return item;
		}
		
		public function inlineInvokeMethod(method:Function):IActionDefinitionH
		{
			var item:IActionDefinitionH = new InlineInvokeAction(this, method);
			eventRuleRoot.actions.push( item );
			return item;
		}
		
		public function setProperty(propertyName:String):IActionDefinitionJ
		{
			var item:IActionDefinitionJ = new SetPropertyAction(this, propertyName);
			eventRuleRoot.actions.push( item );
			return item;
		}
		
		public function stopEvent():IActionDefinition
		{
			var item:IAction = new StopEventAction();
			eventRuleRoot.actions.push( item );
			return this;
		}
	}
}