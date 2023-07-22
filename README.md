# Documentation for GoCD - Continuous Delivery server

This repository contains the developer documentation for [GoCD](https://www.gocd.org).

## Build and run locally

### Install [honkit](https://github.com/honkit/honkit)

```
$ npm install
```

### Serve the documentation locally

```
$ npm run server
```

Point your browser to [http://localhost:4000/](http://localhost:4000/)

### Generating the static website

```
$ npm run build
```

### Publishing changes

The contents of the `_book` directory needs to be pushed out to the *[gh-pages](https://github.com/gocd/developer.go.cd/tree/gh-pages)* branch of the repository.

## Contributing

We encourage you to contribute to GoCD. For information on contributing to this project, please see our [contributor's guide](https://www.gocd.org/contribute).
A lot of useful information like links to user documentation, design documentation, mailing lists etc. can be found in the [resources](https://www.gocd.org/community/resources.html) section.

## License

```plain
Copyright 2022 Thoughtworks, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
