package com.nirima.ribbons.action
{
	import com.nirima.ribbons.context.Bind;
	import com.nirima.ribbons.dsl.IActionDefinition;
	import com.nirima.ribbons.dsl.IActionDefinitionH;
	import com.nirima.ribbons.dsl.IActionDefinitionJ;
	import com.nirima.ribbons.dsl.IActionDefinitionK;
	
	import flash.events.Event;

	/**
	 * Implement property such as
	 * .setProperty("patient").onType(PatientDetailsManager).from( binding("event.item") );
	*/			
	public class SetPropertyAction implements IAction, IActionDefinitionJ, IActionDefinitionK
	{
		public var actionDefinition:IActionDefinition;
		
		internal var klass:Class;
		internal var source:Object;
		
		internal var property:String;
		
		public function SetPropertyAction(ad:IActionDefinition, property:String)
		{
			this.property = property;
			this.actionDefinition = ad;
		}
		
		public function onType(clazz:Class):IActionDefinitionK
		{
			this.klass = clazz;
			return this;
		}
		
		public function from(source:*):IActionDefinition
		{
			this.source = source;
			return actionDefinition;
		}
		
		/*public function withArguments(object:Object):IActionDefinition
		{
			this.args = object;
			return actionDefinition;
		}
		
		public function withoutArguments():IActionDefinition
		{
			return actionDefinition;	
		}*/
	
		public function processEvent(event:ActionScope):Object
		{
			var instance:Object = event.getObject(klass);
			
			instance[property] = calculateParameter(event, source);
			
			return true;
			
		}
		
		private function calculateParameter(scope:ActionScope, item:Object):Object
		{
			if( item is Bind )
			{
				return Bind(item).evaluate(scope);	
			}
			else
			{
				return item;
			}
			
		}
	}
}