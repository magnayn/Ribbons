package com.nirima.ribbons.utils
{	
	import mx.binding.utils.BindingUtils;
	import mx.binding.utils.ChangeWatcher;
	
	/**
	 * Binder is a helper class used to bind properties of two objects
	 *
	 */
	public class Binder
	{
		private var watcher:ChangeWatcher;
		
		protected var soft:Boolean;
		public function Binder( soft:Boolean = false )
		{
			this.soft = soft;
		}
		
		public function unbind():void
		{
			if( watcher != null )
			{
				watcher.unwatch();		
				watcher = null;
			}
		}
		
		/**
		 * The function that implements the binding between two objects.
		 */
		public function bind(target:Object, targetKey:String, source:Object, sourceKey:String):Boolean
		{
			var isWatching:Boolean;
			//var logInfo:LogInfo;
			if(target && targetKey && source && sourceKey)
			{
				var chainSourceKey:Object = sourceKey;
				var multipleLevels:int = chainSourceKey.indexOf(".");
				if(multipleLevels > 0)
				{
					chainSourceKey = sourceKey.split(".");
				}
				try
				{
					if( soft )
					{
						var softWacher:ChangeWatcher = BindingUtils.bindProperty(target, targetKey, source, chainSourceKey, false, true);
						if(softWacher.isWatching()) isWatching = true;
						this.watcher = softWacher;
					}
					else
					{
						var wacher:ChangeWatcher = BindingUtils.bindProperty(target, targetKey, source, chainSourceKey);
						if(wacher.isWatching()) isWatching = true;
						this.watcher = wacher;
					}
				}
				catch(error:ReferenceError)
				{
					//logInfo = new LogInfo( scope, source, error, null, null,sourceKey );
					//logInfo.data = {target:target, targetKey:targetKey};
					//scope.getLogger().error(LogTypes.CANNOT_BIND, logInfo);
					trace("Error: " + error);
					isWatching = false;
				}
				catch(error:TypeError)
				{
					//logInfo = new LogInfo( scope, source, error,null, null,sourceKey );
					//logInfo.data = {target:target, targetKey:targetKey, source:source, sourceKey:sourceKey};
					//scope.getLogger().error(LogTypes.PROPERTY_TYPE_ERROR, logInfo);
					trace("Error: " + error);
					isWatching = false;
				}
			}
			else if(target && targetKey && source)
			{
				try
				{
					target[targetKey] = source;
				}
				catch(error:ReferenceError)
				{
					//logInfo = new LogInfo( scope, target, error, null, null,targetKey );
					//scope.getLogger().error(LogTypes.PROPERTY_NOT_FOUND, logInfo);
					trace("Error: " + error);
					isWatching = false;
				}
				catch(error:TypeError)
				{
					//logInfo = new LogInfo( scope, source, error);
					//logInfo.data = {target:target, targetKey:targetKey, source:source};
					//scope.getLogger().error(LogTypes.PROPERTY_TYPE_ERROR, logInfo);
					trace("Error: " + error);
					isWatching = false;
				}
			}
			else
			{
				isWatching = false;
				if(!targetKey)
				{
					//logInfo = new LogInfo( scope);
					//scope.getLogger().error(LogTypes.TARGET_KEY_UNDEFINED, logInfo);
					
				}
				else if(!target)
				{
					//logInfo = new LogInfo( scope);
					//scope.getLogger().error(LogTypes.TARGET_UNDEFINED, logInfo);
				}
				else if(!source)
				{
					//logInfo = new LogInfo( scope);
					//scope.getLogger().error(LogTypes.SOURCE_UNDEFINED, logInfo);
				}
			}
			if(!isWatching)
			{
				//logInfo = new LogInfo( scope);
				//logInfo.data = {targetKey:targetKey};
				//scope.getLogger().info(LogTypes.NOT_BINDING, logInfo);
			}
			return isWatching;
		}
		
	}
}