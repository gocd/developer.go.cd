---
description: The objective of this guide is to explain how to write a task plugin for GoCD.
keywords: task plugin json api, message based api, gocd plugin, gocd plugins
---

# Task plugin - JSON API - Message based

The objective of this guide is to explain how to write a [task plugin](task_plugin_overview.md), for GoCD.

Useful references:
* [Overview of task plugins - External link to GoCD's user documentation ](https://docs.gocd.org/current/extension_points/task_extension.html)
* [Overview of message-based APIs](../json_message_based_plugin_api.md)
* [Structure of a plugin and writing one](../go_plugins_basics.md)
* [A sample task plugin - curl](https://github.com/gocd/sample-plugins/tree/master/curl-plugin)

A task plugin is a GoCD plugin, which claims to support to extension name ```task``` in its identifier, and responds to the messages mentioned below, appropriately. It's probably easiest to learn from the sample plugin mentioned above.

## Messages to be handled by the plugin - ***version 1.0***

These are the messages that need to be handled by a plugin, which implements the task plugin JSON message-based API.

[Task Configuration](version_1_0/configuration.md)

[Task View](version_1_0/view.md)

[Validate Configuration](version_1_0/validate.md)

[Execute Task](version_1_0/execute.md)

## Other information

* Availability: GoCD version 14.4.0 onwards
* Extension Name: ```task```

