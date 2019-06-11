---
description: Guide to writing a GoCD plugin, starting with the basics, user guide, and architecture.
keywords: gocd plugins, gocd plugin, plugin architecture, plugin user guide, plugin basic, install plugin
---

# Guide to writing a GoCD plugin

Please go through below links before writing GoCD plugin

* [GoCD Plugin Basics](go_plugins_basics.md)

* [GoCD Plugin User Guide](https://docs.gocd.org/current/extension_points/plugin_user_guide.html)

* [GoCD Plugin Architecture - Only if you want to extend the architecture](../4/4.4.1.md)

## Writing plugins for GoCD

Traditionally, writing a plugin for GoCD involved implementing some pre-defined java interfaces which exist for the each extension point. We call them Java interface/class based plugin API. 
With time, we noticed many shortcomings in this approach, one of them being the interfaces went out of date even if a new field was added. This broke all existing plugins without providing enough time for the plugin authors to make appropriate changes to their respective plugins and make a release. 
This raised a need for an alternate approach to write plugins. With version 14.4.0 GoCD introduced support for JSON message based plugin API. This still deals with a few java classes, but the dynamic part which is the details being sent back and forth between GoCD and plugin is in the form of JSON data. 
In order to support existing plugins and provide enough time to the plugin authors to migrate these to use the newer APIs, GoCD still works with old java interface based plugin API. However, this support will be removed eventually and hence all plugin authors are adviced to write new plugins using JSON based API, and also migrate their existing plugins to the same.

JSON message based plugin API has been described in further details [here](json_message_based_plugin_api.md).

<a name="plugin-api-jar"> </a>
<a name="plugin-api-javadocs"> </a>
## Plugin API jar, javadocs and documentation

You can find the latest API jar file with its associated sources and javadocs on [Maven Central](https://search.maven.org/#search%7Cga%7C1%7Cgo-plugin-api). Details about the different extension points can be found in the [plugin documentation](https://plugin-api.gocd.org).
