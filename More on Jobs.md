# More on Jobs

## Job Configuration

* Name: The job is named "Build and Test."
* Requires: The job requires the successful completion of the "setup" job.
* Context: The job uses the context named "my-secrets."
* Type: The job runs within a Docker container.
* Filters: The job only runs when changes are pushed to the "main" branch.
* Matrix: The job is run with different combinations of operating systems and Node.js versions defined in the matrix.
* Executor: The job uses a custom executor named "custom-executor."
* Steps: The steps within the job include checking out the code, installing dependencies, and running tests.


```py
version: 2.1
jobs:
  build:
    name: Build and Test
    requires:
      - setup
    context: my-secrets
    type: docker
    filters:
      branches:
        only:
          - main
    matrix:
      os:
        - ubuntu
        - macos
      node_version:
        - 12
        - 14
    executor:
      name: custom-executor
    steps:
      - checkout
      - run:
          name: Install Dependencies
          command: npm install
      - run:
          name: Run Tests
          command: npm test

```

## Workflow Configuration

```sh
workflows:
  version: 2
  build_and_test:
    jobs:
      - setup
      - build:
          context: my-secrets

```

### Explanation

Explanation:

```sh
    Workflows: Defines a workflow named "build_and_test."
    Jobs: Specifies the sequence of jobs to be executed within the workflow.
        Setup: An example of a job that might be defined elsewhere in the configuration.
        Build: The "Build and Test" job, utilizing the context "my-secrets."
```

### Context

```sh
Context: A context is a named collection of environment variables and secrets that you define within your CircleCI organization. 
It allows you to centralize and manage sensitive information in one place.

Core Context: When you specify a context for a job in your pipeline configuration, you are indicating that the job will have access to the environment variables and secrets stored within that context. This allows you to keep your pipeline configuration clean and avoid exposing sensitive information directly.
```

### Filters

```sh
Filters: Filters allow you to define conditions or criteria that determine under what circumstances the job will execute. 

Core Context: The filters parameter specifies conditions that must be met for the job to be executed. Conditions are defined using various filters such as branches, tags, and paths. These filters define the events or changes that should trigger the job.

```

### Matrix

```sh
Matrix: The matrix parameter allows you to run a job with different combinations of specified parameter values. 
In this case, the job is run with different operating systems (ubuntu, macos) and Node.js versions (12, 14).

Core Context: The matrix is useful for testing your application across multiple environments, helping ensure compatibility.

```
