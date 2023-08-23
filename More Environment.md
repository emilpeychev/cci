# More on Environment in the Pipeline

## Docker Containers

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

```txt
The provided environment is containers based on this image. 
```

## Executor

The executor's resource settings define how much CPU and memory are allocated to the job when it's executed.
The executor installs the curl utility as a demonstration, and running a command to check the version of curl.

```sh
version: 2.1
executors:
  custom-executor:
    docker:
      - image: ubuntu:20.04
    resource_class: small
    cpu: 2
    memory: 4GB
jobs:
  build:
    executor: custom-executor
    steps:
      - checkout
      - run:
          name: Install Dependencies
          command: apt-get update && apt-get install -y curl
      - run:
          name: Run Tests
          command: curl --version
```
