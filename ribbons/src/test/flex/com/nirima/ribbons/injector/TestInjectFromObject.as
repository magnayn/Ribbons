package com.nirima.ribbons.injector
{

import com.nirima.ribbons.injector.helpers.InjectFromObjectTestContext;
import com.nirima.ribbons.injector.helpers.TestTarget;

import flash.events.EventDispatcher;

import flexunit.framework.TestCase;

public class TestInjectFromObject extends TestCase
{

    private var context:InjectFromObjectTestContext;

    private var target:TestTarget;

    public function TestInjectFromObject()
    {

    }

    public function testInjectFromSourceKey():void
    {
        TestTarget.initialValue = false;
        setupContextToInjectObject(true);
        target = context.createInstance(TestTarget);

        assertTrue(target.propertyFromSourceKey);

        TestTarget.initialValue = true;
        setupContextToInjectObject(false);
        target = context.createInstance(TestTarget);

        assertFalse(target.propertyFromSourceKey);
    }

    public function testInjectFromSourceObject():void
    {
        TestTarget.initialValue = false;
        setupContextToInjectObject(true);
        target = context.createInstance(TestTarget);

        assertTrue(target.propertyFromSourceObject);

        TestTarget.initialValue = true;
        setupContextToInjectObject(false);
        target = context.createInstance(TestTarget);

        assertFalse(target.propertyFromSourceObject);
    }

    private function setupContextToInjectObject(prop:Object):void
    {
        context = new InjectFromObjectTestContext(new EventDispatcher(), prop);
    }


}
}
