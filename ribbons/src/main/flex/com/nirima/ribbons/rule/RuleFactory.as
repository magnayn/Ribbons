package com.nirima.ribbons.rule
{
	import com.nirima.ribbons.dsl.IInjectRuleA;
	import com.nirima.ribbons.dsl.IInjectRuleB;
	import com.nirima.ribbons.dsl.IInjectRuleC;
	import com.nirima.ribbons.dsl.IInjectRuleD;
	import com.nirima.ribbons.dsl.IInjectorRuleRoot;
	import com.nirima.ribbons.injector.InjectorImpl;

	public class RuleFactory implements IInjectorRuleRoot
	{
		public var injector:InjectorImpl;
		public var targetClass:Class;
		public var rules:Array = [];
		
		public function RuleFactory( injector:InjectorImpl )
		{
			this.injector = injector;
		}
		
		public function whenInjectingInto(clazz : Class) : IInjectRuleB
		{
			this.targetClass = clazz;
						
			return newRule();
		}
		
		protected function newRule():Rule
		{
			return new Rule(this);
		}
		
		internal function ruleComplete(rule:Rule):Rule
		{
			this.rules.push(rule);
			
			return newRule();
		}
		
	}
}