/**
 * Test Context for injecting values from an object.
 */
package com.nirima.ribbons.injector.sources
{

import com.nirima.ribbons.context.Context;

import flash.events.EventDispatcher;

public class InjectFromObjectTestContext extends Context
{

    public var sourceProperty:Object;

    public function InjectFromObjectTestContext(valueToInject:Object)
    {
        this.sourceProperty = valueToInject;
        super(new EventDispatcher());

        injector.newRule()
                .whenInjectingInto(TestTarget).injectProperty("propertyFromSourceKey")
                .fromSourceKey("sourceProperty").inObject(this);

        injector.newRule()
                .whenInjectingInto(TestTarget).injectProperty("propertyFromSourceObject")
                .fromSourceObject(valueToInject);
    }
}
}
