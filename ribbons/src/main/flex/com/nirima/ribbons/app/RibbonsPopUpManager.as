package com.nirima.ribbons.app
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	import mx.core.IFlexDisplayObject;
	import mx.core.IFlexModuleFactory;
	import mx.managers.PopUpManager;

	public class RibbonsPopUpManager
	{
		public static var childToParentMap:Dictionary = new Dictionary();
		
		public function RibbonsPopUpManager()
		{
		}
		
		public static function createPopUp(parent:DisplayObject,className:Class,modal:Boolean=false,childList:String=null,moduleFactory:IFlexModuleFactory = null):IFlexDisplayObject
		{
			var displayObject:IFlexDisplayObject = PopUpManager.createPopUp(parent,className,modal,childList,moduleFactory);
			
			childToParentMap[displayObject] = parent;
			
			return displayObject;
		}
		
		public static function removePopUp(o:IFlexDisplayObject):void
		{
			PopUpManager.removePopUp(o);
			delete childToParentMap[o];
		}
	}
}