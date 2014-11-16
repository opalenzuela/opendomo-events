opendomo-events
===============

This module contains the event management for OpenDomo OS 2, allowing easy configuration of automatic actions for each system event captured, for instance:

 - Play a sound when error is detected
 - Pack logs when disk is full
  
Each plugin should specify which events can generate, as it's specified in the manual page.

Event management
================

Each plugin and feature is responsible on triggering relevant events to provide more control on what is happening to the system. Triggering an event is very simple: just invoke the logevent script with several parameters (see the following example) and opendomo-events will take care of the rest:

     logevent warning odevents "Something unexpected happened"

As we can see in the example, the first parameter defines the type of event, the second is the plugin that triggered it and the third is a textual description for the user.

If the event involves a file, it can be sent as the fourth parameter (always using an absolute path).
