---
description: Learn more about how JSON message based plugin APIs work with GoCD
keywords: gocd plugin, gocd plugins, json message based, plugin api, plugin architecture
---

# JSON message based plugin API

## Prerequisite

If you are not already aware about GoCD plugin architecture and usage guide, please go through below links

[Plugins in GoCD](go_plugins_basics.md)

[Plugin User Guide](https://docs.gocd.org/current/extension_points/plugin_user_guide.html)

[GoCD Plugin Architecture - Only if you want to extend the architecture](../4/4.4.1.md)

## Introduction

Java interface based plugin API's makes it difficult to support backward compatibility for plugins, any change in the contract would mean plugins using older contract no longer work. Although multiple versions of API interfaces and classes can be maintained but it gets messy after sometime. JSON message based plugin API will help address this issue. Instead of implementing set of java interfaces to write a plugin, plugin authors have to implement a very thin java interface and rest of the communication between plugin and GoCD will be through JSON messages. Once JSON messages are used to enforce contract, incremental changes can be done without breaking older plugins. Below are some the benefits of this approach.

- Backward compatibility for plugins

- Easy to update plugin API contracts without effecting older plugins

- No need re-distribute plugin API when a new extension point is introduced.

## How does it work?

Each plugin will have to provide an instance of GoPluginIdentifier when asked by GoCD. GoPluginIdentifier will allow GoCD to identity type of extension plugin supports.
Interactions between GoCD and plugin for an extension point is broken down into multiple requests. Each interaction between GoCD and plugin will have extension name and request name, which determines
expected response from plugin.  Each extension will have

-  Unique extension name.


-  Extension versions. GoCD can support multiple versions of an extension point at any given point.


-  Set of request with each request having a unique name.


-  Each request has request and response message contract expressed in JSON format.


-  A request sent from GoCD to a plugin resembles HTTP request and has following parts.
    - extension name.
    - request name.
	- request body string as JSON format, synonymous to HTTP request body.
	- request parameters map, synonymous to HTTP request params.
	- request headers map, synonymous to HTTP request headers.


-  A response sent from a plugin to GoCD against a request resembles HTTP response and has following parts.
	-  response body string as JSON format, synonymous to HTTP response body.
	-  response code,  synonymous to HTTP response code
	-  response headers map,  synonymous to HTTP response headers

![](../images/json_message_based_plugin_api_interaction.png)

# What are the changes at plugin side?

Every 'JSON message based API' GoCD plugin will have to implement GoPlugin interface. GoPlugin interface is as shown below

``` {code}

    @GoPluginApiMarker
    public interface GoPlugin {

        public GoPluginIdentifier pluginIdentifier();

        public GoPluginApiResponse handle(GoPluginApiRequest requestMessage);

        public void initializeGoApplicationAccessor(GoApplicationAccessor goApplicationAccessor);
    }

```

***GoPluginIdentifier***
GoPluginIdentifier provide details about plugin itself (ex plugin id, extension). GoPluginIdentifier would help GoCD to identity type of extension supported by plugin along with extension versions supported.

***GoPluginApiRequest***
GoPluginApiRequest represents request message sent from GoCD to a plugin against specific request of a extension. As mentioned above, GoPluginApiRequest has request name, request body, request parameters and request headers.		

***GoPluginApiResponse***
GoPluginApiResponse represents response message sent from a plugin to GoCD against specific request of a extension. As mentioned above, GoPluginApiResponse has response body, response code and response headers.		

***GoApplicationAccessor***
Sometimes it is necessary for a plugin to get certain information from GoCD which might not be part of request sent. Precisely for this reason plugin would be provided an instance
of type GoApplicationAccessor which can help accessing set of JSON API's exposed specifically for plugins.

GoCD as of now supports package material extension and task extension. GoApplicationAccessor instance is not required for these extension points. More details about GoApplicationAccessor
will be provided when an extension point comes up which needs to use it.

GoCD plugin API provides an abstract implementation of GoPlugin called AbstractGoPlugin. It provides default implementation for "initializeGoApplicationAccessor" as below.  

``` {code}

    public abstract class AbstractGoPlugin implements GoPlugin {
        protected GoApplicationAccessor goApplicationAccessor;
        @Override
        public void initializeGoApplicationAccessor(GoApplicationAccessor goApplicationAccessor) {
            this.goApplicationAccessor = goApplicationAccessor;
        }
    }

```

Please refer [javadocs](overview.md#plugin-api-javadocs) for more details about API classes.

## Extension points supported by GoCD

* [Package material plugins](./package_material/package_material_plugin_overview.md)
* [SCM material plugins](./scm_material/scm_material_plugin_overview.md)
* [Task plugins](./task/task_plugin_overview.md)
* [Notification plugins](https://plugin-api.gocd.org/current/notifications)
* [Authentication plugins](./authentication/authentication_plugin_overview.md)
