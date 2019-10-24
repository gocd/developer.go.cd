---
description: The objective of this guide is to explain how to write a SCM material plugin for GoCD
keywords: scm material, json api, message based api, gocd plugin, gocd plugins, scm configuration
---

# SCM material plugin - JSON API - Message based

The objective of this guide is to explain how to write a [SCM material plugin](scm_material_plugin_overview.md), for GoCD.

Useful references:
* [Overview of SCM material plugins - External link to GoCD's user documentation ](https://docs.gocd.org/current/extension_points/scm_extension.html)
* [Overview of message-based APIs](../json_message_based_plugin_api.md)
* [Structure of a plugin and writing one](../go_plugins_basics.md)
* [A sample SCM material plugin - JGit](https://github.com/gocd/go-plugins/tree/master/plugins-for-tests/test-scm-plugin)

A SCM material plugin is a GoCD plugin, which claims to support to extension name `scm` in its identifier, and responds to the messages mentioned below, appropriately. It's probably easiest to learn from the sample plugin mentioned above.

## Messages to be handled by the plugin - ***version 1.0***

[SCM Configuration](version_1_0/scm_configuration.md)

[SCM View](version_1_0/view.md)

[Validate SCM Configuration](version_1_0/validate_scm_configuration.md)

[Check SCM Connection](version_1_0/check_scm_connection.md)

[Latest SCM Revision](version_1_0/latest_revision.md)

[Latest SCM Revisions Since](version_1_0/latest_revisions_since.md)

[Checkout](version_1_0/checkout.md)

## Other information

* Availability: GoCD version 15.1.0 onwards
* Extension Name: `scm`
