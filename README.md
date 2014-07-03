Ribbons
-------

An experimental flex framework, inspired by Mate and other IoC containers.


How the classes fit together.
-----------------------------

** Event Routing. **

You create an EventRouter with access to a dispatcher (usually either the system dispatcher (root), or a dispatcher for a dialog box popup, which is an immediate child of the sysemDispatcher).

The EventRouter will do nothing until it is asked to register for particular event types. When done so, it will register for those events on the dispatcher.

Events can be unregistered, and there is a 'dispose' method which removes all created event registrations.

When events are recieved, subclasses of EventRouterBase will do something.

- SimpleEventRouter

A SimpleEventRouter is constructed with a context. When created, it will register for all the events declared by the context, and pass them to the context when they are recieved.

This is typically used to display an isolated dialog box. The SimpleEventRouter listens for events in the dialog box, and passes them through to the context.

** View Injection **

The AutoViewInjector is the only place that listens for CREATE and REMOVE events. It is created with a dispatcher (typically either the systemDispatcher or a popup dispatcher), and a Context.

When it receives a creation event, it asks the context if it needs to inject any values into the control.

** RibbonsPopupManager **

RibbonsPopupManager is a simple class that exists to store the fact that Popup2 is logically the 'child' of Popup1. It stores a childToParentMap, where childToParentMap[Popup2] = Popup1.

The parent may be any display object.

This relationship may be used in the event bus, later on.

** Context **

The context is the core of Ribbons.

A context contains several things

- An instance cache, for (singleton) instances of objects.
- A list of injection 'rules'.
- A list of event handling 'rules'
- A collection of 'live' bindings (the results of injection rules)
- A dispatcher, which is only used for dispatching events into.

Contexts do NOT register for, or store events. That is done by EventRouters, which will register on behalf of the context, and call it back (via processEvent).

A context can be disposed(), which removes any live bindings.


** Event Bus **

An event bus is an enhanced SimpleEventRouter.

Instead of having a single Context, you may add multiple Contexts to the event bus, which may have a parent->child relationship between them.

The event bus typically registers for events at the systemDispatcher level.

When the event bus receives an event, it attempts to determine which contexts should receive the event. It will traverse any parent->child context relationships it knows about, as well as ones declared by RibbonsPopupManager.

** RibbonsApplication **

This is a convenience class for declaring the main EventBus for an application. It should be a singleton.



