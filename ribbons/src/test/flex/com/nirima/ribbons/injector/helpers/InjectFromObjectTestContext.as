/**
 * Test Context for injecting values from an object.
 */
package com.nirima.ribbons.injector.helpers
{

import com.nirima.ribbons.context.Context;

import flash.events.IEventDispatcher;

public class InjectFromObjectTestContext extends Context
{

    public var sourceProperty:Object;

    public function InjectFromObjectTestContext(dispatcher:IEventDispatcher, valueToInject:Object)
    {
        this.sourceProperty = valueToInject;
        super(dispatcher);

        injector.newRule()
                .whenInjectingInto(TestTarget).injectProperty("propertyFromSourceKey")
                .fromSourceKey("sourceProperty").inObject(this);

        injector.newRule()
                .whenInjectingInto(TestTarget).injectProperty("propertyFromSourceKey")
                .fromSourceKey("sourceProperty").inObject(this);

        injector.newRule()
                .whenInjectingInto(TestTarget).injectProperty("propertyFromSourceObject")
                .fromSourceObject(valueToInject);

        injector.newRule()
                .whenInjectingInto(TestTarget).injectProperty("propertyFromSourceObject")
                .fromSourceObject(valueToInject);


    }
}
}
