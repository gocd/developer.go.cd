---
description: Introduction to GoCD Developer documentation, providing help into making open source contributions to GoCD. 
keywords: open source contribution, continuous delivery open source, code contribution, gocd plugins, open source plugins, continuous delivery plugins
---

## GoCD Developer Documentation

This documentation is a work-in-progress which is not seeing much work at this point. Turns out documenting code is a bit of a wasteful process. If you are looking to contribute code, feel free to talk to the developers on [Gitter](https://gitter.im/gocd/gocd).

The [Getting Started page](2/2.1.md) is probably the one that is most up-to-date and is useful to set your code up for local development.

### Status Legend

* Not Done ![NOT DONE](./images/red.png)
* In Progress ![IN PROGRESS](images/yellow.png)
* Pending Review ![PENDING REVIEW](images/blue.png)
* Done ![DONE](images/green.png)


### Index

#### 1. Concepts in GoCD
* 1.1 [Domain](1/1.1.md) ![DONE](images/green.png)
* 1.2 Implementation ![NOT DONE](images/red.png)

#### 2. Getting Started
* 2.1 [Setting up your development environment](./2/2.1.md) ![DONE](images/green.png)
* 2.2 [How to go about making changes to the codebase](./2/2.2.md) ![DONE](images/green.png)
* 2.3 [How to add a configuration migration](./2/2.3.md) ![DONE](images/green.png)
* 2.4 [How to add a database migration](./2/2.4.md) ![DONE](images/green.png)

#### 3. Technology Stack
* 3.1 Plugins Architecture - OSGi ![NOT DONE](images/red.png)
* 3.2 [Object Relation Mapping (ORM) - Hibernate & IBatis](3/3.2.md) ![DONE](images/green.png)
* 3.3 [Caching - EhCache](3/3.3.md) ![DONE](images/green.png)
* 3.4 [Dependency Injection (DI) - Spring](3/3.4.md) ![DONE](images/green.png)
* 3.5 Model View Controller (MVC) ![NOT DONE](images/red.png)
* 3.6 [User Interface (UI) - jQuery & Prototype, SCSS, HTML](3/3.6.md) ![DONE](images/green.png)
* 3.7 Build Tool - Buildr ![NOT DONE](images/red.png)

#### 4. Architecture of Go
* 4.1 [Overview](4/4.1.md) ![IN PROGRESS](images/green.png)
* 4.2 [GoCD Server](4/4.2.md) ![DONE](images/green.png)
* 4.3 [GoCD Agent](4/4.3.md) ![DONE](images/green.png)
* 4.4 [Common](4/4.4.md) ![IN PROGRESS](images/yellow.png)
* 4.5 [Build Infrastructure](4/4.5.md) ![DONE](images/green.png)

#### 5. Features
* 5.1 [Dashboard](5/5.1.md) ![DONE](images/green.png)
* 5.2 [Fan-in](5/5.2.md) ![DONE](images/green.png)
* 5.3 [Value Stream Map](5/5.3.md) ![DONE](images/green.png)
* 5.4 [Compare Pipeline](5/5.4.md) ![DONE](images/green.png)
* 5.5 [PackageRepository](5/5.5.md) ![DONE](images/green.png)
* 5.6 Command Repository ![NOT DONE](images/red.png)
* 5.7 [Environments](5/5.7.md) ![DONE](images/green.png)
* 5.8 Templates ![NOT DONE](images/red.png)
* 5.9 Shine ![NOT DONE](images/red.png)
* 5.10 [OAuth Gadgets](5/5.10.md) ![DONE](images/green.png)
* 5.11 [Backup](5/5.11.md) ![DONE](images/green.png)

#### 6. CD in practice

* 6.1 Build GoCD Using GoCD ![NOT DONE](images/red.png)
* 6.2 Test Infrastructure ![NOT DONE](images/red.png)
* 6.3 Continuous Deployment ![NOT DONE](images/red.png)

#### 7. Miscellaneous
   * 7.1 [Technical Debt](7/7.1.md) ![DONE](images/green.png)

#### 8. Writing Go Plugins
* [Overview](writing_go_plugins/overview.md)
* [GoCD Plugin Architecture](4/4.4.1.md)
* [GoCD Plugin Basics](writing_go_plugins/go_plugins_basics.md)
* [GoCD Plugin User Guide](https://docs.gocd.org/current/extension_points/plugin_user_guide.html)
* [GoCD Plugin API](writing_go_plugins/go_plugin_api.md)
* [Package Repository Extension](https://docs.gocd.org/current/extension_points/package_repository_extension.html)
* [Package repository plugin using JSON message based plugin API](writing_go_plugins/package_material/json_message_based_package_material_extension.md)
* [Task Extension](https://docs.gocd.org/current/extension_points/task_extension.html)
* [Task plugin using JSON message based plugin API](writing_go_plugins/task/json_message_based_task_extension.md)
