package com.nirima.ribbons.provider
{	
	import flash.utils.Dictionary;
	
	public class CacheProvider implements IProvider
	{
		public var cache:Dictionary = new Dictionary();
		public var nextProvider:IProvider;
		
		public function CacheProvider(next:IProvider = null)
		{
			this.nextProvider = next;
		}
		
		public function getInstance( ofClass:Class, createIfNotFound:Boolean = true, id:String=null):*
		{
			if( cache[ofClass] == null && nextProvider != null && createIfNotFound )
			{
				cache[ofClass] = nextProvider.getInstance(ofClass,true,id);
			}
			return cache[ofClass];
		}
		
		public function createInstance(ofClass:Class, parameters:Array = null ):*
		{
			if( cache[ofClass] != null )
				throw new Error("Already have an instance of that class");
			
			cache[ofClass] = nextProvider.createInstance(ofClass, parameters);
			
			return cache[ofClass];
		}
		
		public function haveInstance(ofClass:Class, id:String=null):Boolean
		{
			if( cache[ofClass] != null )
				return true;
			
			if( nextProvider != null )
				return nextProvider.haveInstance(ofClass,id);
			
			return false; 
		}
		
		
	}
}