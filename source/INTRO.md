---
description: Introduction to GoCD Developer documentation, providing help into making open source contributions to GoCD.
keywords: open source contribution, continuous delivery open source, code contribution, gocd plugins, open source plugins, continuous delivery plugins, gocd environment, development environment, gocd open source, open source continuous delivery, setup gocd locally
---

## GoCD Developer Documentation

This documentation should allow you to setup your development environment to work on the [codebase](https://github.com/gocd/gocd) for [GoCD](https://www.gocd.org), a free and open-source Continuous Delivery server.

---

# Setting up your development environment

## Step 1: Get the code and run a local build

GoCD requires the following software packages to do a basic build without running all the functional/integration tests.

- Git (https://git-scm.com/downloads)
- 64-bit JDK 21+ (We recommend installing an Eclipse Temurin build from [Adoptium](https://adoptium.net))
- NodeJS >= 22 (https://nodejs.org/en/download/) with [corepack](https://nodejs.org/api/corepack.html) enabled

### For Mac Users

[Homebrew](https://brew.sh) is the easiest way to install the prerequisite packages

```bash
brew install git temurin21 nodejs
corepack enable
```

For more control over versions; a generic version manager such as [Mise](https://github.com/jdx/mise#quickstart) or [ASDF](https://asdf-vm.com/) is a good choice. GoCD includes a [`.tool-versions`](https://github.com/gocd/gocd/blob/master/.tool-versions) to install precise versions with either Mise or ASDF.

```bash
brew install git
mise install # Installs recommended/validated JDK & NodeJS versions
corepack enable
```

### For Windows Users

The easiest way to get the prerequisite packages is by using [Chocolatey](https://chocolatey.org)

From an elevated command prompt run the following commands:

```powershell
choco install git temurin21 nodejs-lts
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned # See https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy
corepack enable
```

### Clone the repository

The main repository is: https://github.com/gocd/gocd

It is highly recommended to fork the main repository and clone your fork for development. You can then add the main repository as an upstream remote:

```bash
# Assuming your github username is `developer-extraordinaire`, clone your forked repo
git clone https://github.com/developer-extraordinaire/gocd
cd gocd
# Add the main repo as the remote `upstream`
git remote add upstream https://github.com/gocd/gocd
```

To pull changes from upstream into your local development branches:

```bash
git fetch upstream
git rebase upstream/master # alternatively, you can merge instead
```

### Validate that you can build the zip installers

Execute the following commands to build GoCD server and agent installers:

```bash
$ unset GEM_HOME GEM_PATH # if you're using rvm
$ ./gradlew clean agentGenericZip serverGenericZip
```

After a successful build, the ZIP installers for GoCD Server and GoCD Agent are outputted to `installers/target/distributions/zip/`

```bash
$ ls installers/target/distributions/zip/
go-agent-16.7.0-3795.zip  go-server-16.7.0-3795.zip
```

Compiled bytecode and other build artifacts can be found in each module's `target/` subdirectory:

```bash
$ find . -name target -type d
./addon-api/database/target
./agent/target
...
./tfs-impl/target
./util/target
```

If all went well, you should be in good shape to set up your IDE.

## Step 2: Setup IntelliJ

The core team use IntelliJ IDEA as the IDE for GoCD development (at least for Java code and related derivatives). If you use another IDE, it will be up to you to figure out a working configuration based off of these instructions. Either the the Community Edition or the paid Ultimate edition will work.

For TypeScript, JavaScript, Sass, Ruby, and other parts, some of us use other editors, such as Visual Studio Code, Sublime Text, Vim, Emacs, etc. That is completely optional.

1. Prior to importing a GoCD project in IntelliJ IDEA, one needs to build some prerequisite code to prepare one's working directory. This is done with the following command -- it may take a few minutes to run the first time, so maybe go grab a coffee :)

    ```bash
    $ ./gradlew clean prepare
    ```

2. After the preparation phase has succeeded, open the project in IDEA by opening the `build.gradle` file in the top level of the working directory and choosing to "Open as Project".

- At this point, IntelliJ IDEA is probably prompting you if you want to import the project using gradle. Click *Import Gradle Project*.

  ![](./images/GradleImport.png)

- Open project settings.

   - Select a Java 17 JDK. While other JDKs might work, GoCD now ships with LTS versions only and you will be safest with that.
   - Change the project language level to Java 11.

   ![](images/ProjectSettings.png)

   - **OPTIONAL for IDEA Ultimate Edition**: Setup a JRuby SDK (use `$GOCD_HOME/server/scripts/jruby`) as the JRuby binary (Ruby support is only available to Ultimate Edition users)

   ![](images/JRubySDK.png)

- Open Gradle Settings

  - Use the same JDK that you are using with the project.

    ![](images/GradleSettings.png)

- Install the Lombok IntelliJ plugin

  - Find `Lombok` in the plugin settings and install it

    ![](images/Lombok.png)

  - More info here https://projectlombok.org/setup/intellij
  - Restart IntelliJ IDEA after installing Lombok

- Configure annotation processing

  - The Lombok plugin will prompt you to setup an annotation processor
  - Enable annotation processing, setting IDEA to obtain processors from the project classpath (the default setting)

  ![](images/ConfigureAnnotationProcessor.png)

### 2.1: Running the Development Server via IntelliJ IDEA

- Open the class `DevelopmentServer`
- Right click and select *Create 'DevelopmentServer.main()'*

  <img src="images/DevelopmentServerCreate.png" width="300px"/>

- Configure the DevelopmentServer JVM args
  - **VM Options**: `-Xmx2g --add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED --add-opens=java.base/sun.nio.ch=ALL-UNNAMED --add-opens=java.base/java.io=ALL-UNNAMED`)
    
     _For Java 16+ compatibility_. GoCD server requires certain JDK packages to have [internals opened for access](https://blogs.oracle.com/javamagazine/post/a-peek-into-java-17-continuing-the-drive-to-encapsulate-the-java-runtime-internals) due to the way it was originally designed. There are
      also some additional `--add-opens` required when in debugging mode for use with Rails and `sass-embedded` compared
      to production mode. If something isn't working, you can check the most up-to-date list of required opens by referring
      to the `JvmModuleOpensArgs` within the [server Gradle config here](https://github.com/gocd/gocd/blob/master/buildSrc/src/main/groovy/com/thoughtworks/go/build/InstallerTypeServer.groovy) and the latest `master` version of the Gradle configuration [here](https://github.com/gocd/gocd/blob/a368f012f063b0b1b6cd6b346c98ee0bd655e379/server/rails.gradle#L252-L256)
  - **Working dir**: `server`
  - Select the same JDK you are using for Gradle, and as the project SDK

    ![](images/DevelopmentServerConfig.png)

### 2.2: Running Development Agent via IntelliJ IDEA

- Open the class `DevelopmentAgent`
- Right click and select *Create 'DevelopmentAgent.main()'*

  <img src="images/DevelopmentAgentCreate.png" width="300px"/>

- Configure the DevelopmentAgent working dir `agent`

  ![](images/DevelopmentAgentConfig.png)

### 2.3: Configure a default JUnit template for running tests via IntelliJ IDEA

- **For Java 16+ compatibility**, GoCD server requires certain JDK packages to have [internals opened for access](https://blogs.oracle.com/javamagazine/post/a-peek-into-java-17-continuing-the-drive-to-encapsulate-the-java-runtime-internals) as mentioned above. The Gradle configurations will do this automatically when running tests against the server, however if you choose to run test tests using IntelliJ IDEA itself, you will find tests failing with access errors. To make each JUnit configuration start with the required access you can edit the default template:
- Open `Run -> Edit configurations...`
- Click `Edit Configuration Templates...` and find the `JUnit` default configuration
- In the **VM Options** box that should start containing `-ea`,
  - add `--add-opens=java.base/java.lang=ALL-UNNAMED --add-opens=java.base/java.util=ALL-UNNAMED` to allow the GoCD server to access certain required JVM internals. For the most up-to-date list of required opens, refer to the `JvmModuleOpensArgs` within the [server Gradle config here](https://github.com/gocd/gocd/blob/master/buildSrc/src/main/groovy/com/thoughtworks/go/build/InstallerTypeServer.groovy) that reflect the production config.
- After this, each JUnit run configuration that is manually or dynamically created should have the necessary configuration to work without issue.

## Step 3: Running tests

### 3.1: Pre-requisites for Java/Server tests

#### Manual setup

Running some of the Java tests requires some additional dependencies, mainly for SCM tools used to validate integrations of
materials and some tool-specific task runners. If you are not worried about running ALL tests or tests in these areas, you can skip this and install pieces when necessary.

- Subversion
- Mercurial
- Helix Core Server (`2024.1` specific version required) & Perforce Client (`2022.1+` will likely work, version doesn't have to match)
- Apache Ant
- Ruby w/ Rake (pre-installed on MacOS)
- NAnt (Windows-only)

#### For Mac Users

[Homebrew](https://brew.sh) is the easiest way to install the additional packages

```bash
brew install ant subversion mercurial perforce
```

#### For Windows Users

The easiest way to get the additional packages is by using [Chocolatey](https://chocolatey.org)

From an elevated command prompt run the following commands:

```powershell
choco install ant nant sliksvn hg p4 ruby
```

**Install the Perforce Helix Core server**
- Download https://cdist2.perforce.com/perforce/r24.2/bin.ntx64/helix-core-server-x64.exe
- Install it.
  - You don't need to install the client and can uncheck its box, since you installed with Choco above
  - It will create a service and ask you for a repository root folder. I'd suggest putting it somewhere you don't care about and
    then disabling the service. GoCD's tests don't need `p4d` to be running or rely on this root folder - they only need 
    the binary to be available on the `PATH` which the installer does for you.

### 3.2: Running Java/Server tests from the command line

As GoCD is a multi-project Gradle setup, there are many combinations you can run. However some common ones are:

```bash
./gradlew allTests # All the quicker tests across projects. Excludes server integration tests.
./gradlew server:fastUnitTest # Only the quicker unit tests for the server
./gradlew server:integrationTest # The server slow integration tests
./gradlew common:test --tests P4MaterialTest # Example filtering for a specific test
```

### 3.3: Running JRuby/Rails RSpec tests from the command line

Here are some RSpec specific commands you may find useful —

```bash
./gradlew rspec # run all specs, with default arguments
./gradlew rspec -Popts='--pattern spec/controllers/**/*_spec.rb' # to run controller specs
./gradlew rspec -Popts='--pattern spec/foo/bar_spec.rb' # to run a single spec
```


### 3.3b: [OPTIONAL for Ultimate Edition] Running JRuby/Rails RSpec tests from IntelliJ IDEA Ultimate Edition

1. Ensure that your project module "server>server_test" is setup properly.

    1. Click "File menu > Project Structure"
    2. Select "Modules" in the "Project Structure" dialog
    3. Navigate to "server>server_test" and right-click to add "JRuby" (select the right jruby version). Then right click to add "JRuby on Rails"

    ![](images/idea-configure-module-add-jruby.png)

    ![](images/idea-configure-module-add-rails.png)

2. Configure the default RSpec run configuration

  1. Open `Run -> Edit configurations...`
  2. Click `Edit configuration templates...` and find the `RSpec` default configuration
  3. Check the `Use custom RSpec runner script` checkbox
  4. Select `rspec` from `<project-directory>/server/scripts/jruby/rspec`
  5. Set the working directory to `<project-directory>/server/src/main/webapp/WEB-INF/rails`
  6. Set the `Ruby SDK` option to `Use other SDK and 'rspec' gem` with the dropdown set to the correct version of JRuby that you configured above, e.g `jruby-9.3.7.0`
     ![](images/idea-configure-rspec.png)
  7. Click `Apply` to save
  8. Open a spec file and run it `Run -> Run 'somefile_spec.rb'`, or `Ctrl+Shift+F10`

### 3.4: Working on TypeScript/Webpack single page apps

If you're working on some of the newer pages in GoCD (almost everything exception stage/job details pages), this will 
watch your filesystem for any JS changes you make and keep compiling the JS in the background. This usually takes a 
couple of seconds to compile, after you hit save.

```bash
# forking in a subshell won't change the directory after interrupting/exiting
$ (cd server/src/main/webapp/WEB-INF/rails && yarn run webpack-watch)
```

### 3.5: Running Javascript tests

To run javascript tests —

#### In development environment (very quick)

Visit the following URLs:
* http://localhost:8153/go/assets/webpack/_specRunner.html (Most pages use MithrilJS 1.0). Ensure that you are running the [webpack watcher](#24-working-on-single-page-apps) to have changes reflected.

In order to run old/"legacy" raw javascript specs through browser, run following command to start server -

```bash
$ ./gradlew jasmineOldServer
```

Open a browser and navigate to `http://localhost:8888/`

#### In CI environment (very slow for running tests after every change)

```bash
$ ./gradlew jasmine
```

# Troubleshooting / Common FAQ

## Development Server problems

Generally, when investigating issues you should
* look at the console stdout/stderr logs in your IDE. Some basic errors go here
* look at `server/logs/go-server.log` - this is where most detail will go for the running server
* if the server starts, but is not behaving how you expect, sometimes the support api can be useful to see the environment and system properties being used `curl http://admin:badger@localhost:8153/go/api/support` (with the default dev username/pass)

**General problems with weird errors**

When in doubt, try another `./gradlew prepare`. If things seem really messed up, try a `./gradlew clean prepare` (slower, and will delete any local DB you have).

**Exception in thread "main" java.io.FileNotFoundException: Source 'src/main/webapp/WEB-INF/rails/webpack/rails-shared/plugin-endpoint.js' does not exist**

This probably means the working directory of your server (`DevelopmentServer` run configuration) is not correct. If you
have specified a relative folder, try specifying an absolute path.

You can check the `user.dir` system property via the `/go/api/support` response if you want to understand what working directory your
server is seeing at startup.

**Blank login page with server log showing `Caused by: java.lang.RuntimeException: Could not load compiled manifest from 'webpack/manifest.json'`**

Try `./gradlew prepare` again. An alternative which _might_ not require restarting your server is putting webpack into watch mode per `Working on TypeScript/Webpack single page apps` above.

_Explanation_: You, or Gradle might have cleaned or removed webpack assets since you last started your server.

**Blank login page with server log showing `org.jruby.rack.RackInitializationException: Could not find sass-embedded-x.xx.x in any of the sources`**

Ensure that are using the _same major Java version_ (e.g `11`, `17` etc) with `./gradlew prepare` as you are using to launch the `DevelopmentServer` within your IDE.
* If you run Gradle from within the IDE, check the Gradle SDK settings as noted above.
* If you run Gradle from a shell/command line, check the `java -version` being used to launch Gradle.

_Explanation_: The reason this happens specifically for `sass-embedded`, is that this gem installs a Ruby 'extension' (which is actually a downloaded native binary for sass) into a platform folder such as `universal-java-11`, `universal-java-17` etc. At runtime this cannot be located if the versions are different. This only affects development mode, where assets are compiled dynamically.

## Development Agent problems

**Agent won't connect to server**

Try `rm agent/config/token` and restart the agent.

_Explanation_: If you did `./gradlew clean` at some point on your server, or changed the `cruise-config.xml` your server's identity may have changed and the agent's token is no longer trusted.
