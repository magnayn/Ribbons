package com.nirima.ribbons.injector.derivatives
{

import flexunit.framework.TestCase;

public class TestInjectDerivatives extends TestCase
{

    private var context:InjectDerivativesTestContext;

    private var target:Target;
    private var targetDerivative:TargetSubclass;

    public function TestInjectDerivatives()
    {

    }

    public function testInjectTarget():void
    {
        context = new InjectDerivativesTestContext(Target, false);
        target = context.createInstance(Target);
        targetDerivative = context.createInstance(TargetSubclass);

        assertTrue(target.property);
        assertFalse(targetDerivative.property);
    }

    public function testInjectTargetWithDerivatives():void
    {
        context = new InjectDerivativesTestContext(Target, true);
        target = context.createInstance(Target);
        targetDerivative = context.createInstance(TargetSubclass);

        assertTrue(target.property);
        assertTrue(targetDerivative.property);
    }

    public function testInjectITargetWithDerivatives():void
    {
        context = new InjectDerivativesTestContext(ITarget, true);
        target = context.createInstance(Target);
        targetDerivative = context.createInstance(TargetSubclass);

        assertTrue(target.property);
        assertTrue(targetDerivative.property);
    }

    public function testInjectTargetSubclassWithDerivatives():void
    {
        context = new InjectDerivativesTestContext(TargetSubclass, true);
        target = context.createInstance(Target);
        targetDerivative = context.createInstance(TargetSubclass);

        assertFalse(target.property);
        assertTrue(targetDerivative.property);
    }

}
}
