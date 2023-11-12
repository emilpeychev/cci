# More on Runtime Environment

## Executors in CircleCI

Executors define the environment in which your job runs. They encapsulate details like the underlying operating system, resource specifications, and any additional tools or dependencies needed for your job.

## Docker Executor

```sh
version: 2.1
jobs:
  build:
    docker:
      - image: node:14
    steps:
      - checkout
      - run:
          name: Install Dependencies
          command: npm install
      - run:
          name: Run Tests
          command: npm test

```

* Explanation
This executor uses a Docker container based on the Node.js 14 image. It provides an isolated environment with Node.js pre-installed, ensuring consistency and reproducibility.

## Machine Executor

```sh
version: 2.1
jobs:
  build:
    machine:
      image: ubuntu-2004:202201-01
    steps:
      - checkout
      - run:
          name: Install Dependencies
          command: apt-get update && apt-get install -y curl
      - run:
          name: Run Tests
          command: curl --version

```

* Explanation

The machine executor allocates a dedicated VM (Virtual Machine) for the job. In this example, it uses an Ubuntu 20.04 image, allowing greater flexibility in configuring the environment.

## MacOS Executor

```sh
version: 2.1
jobs:
  build:
    macos:
      xcode: 12.4.0
    steps:
      - checkout
      - run:
          name: Install Dependencies
          command: brew install curl
      - run:
          name: Run Tests
          command: curl --version

```

* Explanation
The macos executor is designed for macOS-based jobs. It allows specifying the Xcode version and provides a macOS environment. Here, Homebrew is used to install dependencies.

## Custom Executors

```sh
version: 2.1
executors:
  custom-executor:
    docker:
      - image: my-custom-image:latest
    resource_class: medium
    cpu: 4
    memory: 8GB

jobs:
  build:
    executor: custom-executor
    steps:
      - checkout
      - run:
          name: Custom Step
          command: ./custom-script.sh

```

* Explanation

This example creates a custom executor using a specific Docker image, a medium resource class, and allocating 4 CPUs with 8GB of memory. It provides a customized environment for jobs with specific requirements.

## All Runtime Environments with Custom Executer

```text
These examples illustrate how you can use a custom executor with specific resource settings across different runtime environments in CircleCI. 
Adjust the my-custom-image:latest, resource class, CPU, and memory values according to your project's requirements.
```

### Docker Executor with Custom Executor

```sh
version: 2.1
executors:
  custom-executor:
    docker:
      - image: my-custom-image:latest
    resource_class: medium
    cpu: 4
    memory: 8GB

jobs:
  build:
    executor: custom-executor
    steps:
      - checkout
      - run:
          name: Custom Step
          command: ./custom-script.sh

```

### Machine Executor with Custom Executor

```sh
version: 2.1
executors:
  custom-executor:
    docker:
      - image: my-custom-image:latest
    resource_class: medium
    cpu: 4
    memory: 8GB

jobs:
  build:
    machine:
      image: ubuntu-2004:202201-01
    executor: custom-executor
    steps:
      - checkout
      - run:
          name: Custom Step
          command: ./custom-script.sh

```

### MacOS Executor with Custom Executor

```sh
version: 2.1
executors:
  custom-executor:
    docker:
      - image: my-custom-image:latest
    resource_class: medium
    cpu: 4
    memory: 8GB

jobs:
  build:
    macos:
      xcode: 12.4.0
    executor: custom-executor
    steps:
      - checkout
      - run:
          name: Custom Step
          command: ./custom-script.sh

```
