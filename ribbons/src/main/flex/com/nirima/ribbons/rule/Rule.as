package com.nirima.ribbons.rule
{
	import com.nirima.ribbons.dsl.IInjectRuleA;
	import com.nirima.ribbons.dsl.IInjectRuleB;
	import com.nirima.ribbons.dsl.IInjectRuleC;
	import com.nirima.ribbons.dsl.IInjectRuleD;

	public class Rule implements IInjectRuleB, IInjectRuleC, IInjectRuleD
	{
		public var _includeDerivatives:Boolean = false;
		public var targetPropertyName:String;
		
		public var sourceClass:Class;
		public var sourceObject:Object;
		public var sourceKey:String;
		
		public var mapClass:Class;
		
		
		private var ruleFactory:RuleFactory;
		
		public function Rule(rf:RuleFactory)
		{
			this.ruleFactory = rf;
		}
		
		public function includeDerivatives():IInjectRuleA
		{
			this._includeDerivatives = true;
			return this;
		}
		
		public function inObject(obj:Object):IInjectRuleA
		{
			this.sourceObject = obj;
			return ruleFactory.ruleComplete(this);
		}
		
		public function injectProperty(name:String):IInjectRuleC
		{
			this.targetPropertyName = name;
			return this;
		}
		
		public function fromClass(clazz:Class):IInjectRuleA
		{
			return this;	
		}
		
		public function fromSourceKey(name:String):IInjectRuleD
		{
			this.sourceKey = name;
			return this;
		}
		
		public function inClass(clazz:Class):IInjectRuleA
		{
			this.sourceClass = clazz;
			return ruleFactory.ruleComplete(this);
		}
		
		public function injectMap(mapClass:Class):IInjectRuleA
		{
			this.mapClass = mapClass;
			return this;
		}
	}
}