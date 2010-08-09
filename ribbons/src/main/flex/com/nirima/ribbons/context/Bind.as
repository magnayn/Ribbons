package com.nirima.ribbons.context
{
	import com.nirima.ribbons.action.ActionScope;

	public class Bind
	{
		public var name:String;
		
		public function Bind(name:String)
		{
			this.name = name;
		}
		
		public function evaluate(scope:ActionScope):Object
		{
			var o:Object = scope;
			
			var items:Array = name.split('.');
			
			for each(var part:String in items)
			{
				o = o[part];	
			}
			
			return o;
		}
		
	}
}