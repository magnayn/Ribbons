package com.nirima.ribbons.provider
{
	public interface IProvider
	{
		function getInstance(ofClass:Class, createIfNotFound:Boolean = true, id:String=null):*;
		
		function createInstance(ofClass:Class, params:Array = null):*;
		
		function haveInstance(ofClass:Class, id:String=null):Boolean;
	}
}