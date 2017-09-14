---
description: GoCD's user documentation contains an overview of authentication plugin endpoint.
keywords: gocd plugin, gocd plugins, authentication plugins, authorization plugin endpoint, authentication plugin endpoint, extension point, JSON api
---

## Overview of authentication plugins

GoCD's user documentation has an overview of authentication plugins.

### Note

The Authorization Plugin endpoint was introduced as an extension to the existing Authentication Plugin endpoint. With this, the Authentication Plugin endpoint is deprecated as of 17.5.0. Support for this extension will be removed in 18.1 (scheduled to be release in January 2018). Plugin developers are encouraged to migrate their plugins to use the new Authorization Extension Point.

Writing a authentication plugin:
* [JSON API - Message based](json_message_based_authentication_extension.md)
