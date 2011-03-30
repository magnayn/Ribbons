package com.nirima.ribbons.provider
{
	/**
	 * The constructor provider does not cache instances, and will
	 * always create a new item
	 */
	public class ConstructorProvider implements IProvider
	{
		public function ConstructorProvider()
		{
			
		}
		
		public function getInstance(ofClass:Class, create:Boolean=true, id:String=null):*
		{
			if( create )
				return new ofClass();
			else
				return null;
		}
		
		public function createInstance(template:Class, p:Array = null):*
		{
			var newInstance:Object;
			if(!p || p.length == 0 )
			{
				newInstance = new template();
				
			}
			else
			{
				// ugly way to call a constructor. 
				// if someone knows a better way please let me know (nahuel at asfusion dot com).
				switch(p.length)
				{
					case 1:	newInstance = new template(p[0]); break;
					case 2:	newInstance = new template(p[0], p[1]); break;
					case 3:	newInstance = new template(p[0], p[1], p[2]); break;
					case 4:	newInstance = new template(p[0], p[1], p[2], p[3]); break;
					case 5:	newInstance = new template(p[0], p[1], p[2], p[3], p[4]); break;
					case 6:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5]); break;
					case 7:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6]); break;
					case 8:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]); break;
					case 9:	newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]); break;
					case 10:newInstance = new template(p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8], p[9]); break;
				}
			}
			return newInstance;
		}
		
		public function haveInstance(ofClass:Class, id:String=null):Boolean
		{			
			return false; 
		}
	}
}