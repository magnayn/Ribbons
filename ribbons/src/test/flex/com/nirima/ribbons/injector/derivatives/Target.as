/**
 * Created with IntelliJ IDEA.
 * User: simon
 * Date: 11/05/2012
 * Time: 20:18
 * To change this template use File | Settings | File Templates.
 */
package com.nirima.ribbons.injector.derivatives
{
public class Target implements ITarget
{
    private var _property:Boolean = false;


    public function get property():Boolean
    {
        return _property;
    }

    public function set property(value:Boolean):void
    {
        _property = value;
    }

    public function Target()
    {
    }
}
}
