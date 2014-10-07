/**
 * Test Context for injecting values from an object.
 */
package com.nirima.ribbons.injector.derivatives
{

import com.nirima.ribbons.context.Context;

import flash.events.EventDispatcher;

public class InjectDerivativesTestContext extends Context
{

    public function InjectDerivativesTestContext(target:Class, includeDerivatives:Boolean)
    {
        super(new EventDispatcher());

        if (includeDerivatives)
        {
            injector.newRule()
                    .whenInjectingInto(target).includeDerivatives().injectProperty("property")
                    .fromSourceObject(true);
        }
        else
        {
            injector.newRule()
                    .whenInjectingInto(target).injectProperty("property")
                    .fromSourceObject(true);
        }


    }
}
}
