# More on Jobs

## Parameters

```txt

    name
    requires
    context
    type
    filters
    matrix

```

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
workflows:
  version: 2
  build_and_test:
    jobs:
      - setup
      - build:
          context: my-secrets

```

```txt
Explained:

    name: The job is named "Build and Test."
    requires: The job requires the successful completion of the "setup" job.
    type: The job runs within a Docker container.
    context: The job uses the context named "my-secrets."
    filters: The job only runs when changes are pushed to the "main" branch.
    matrix: The job is run with different combinations of operating systems and Node.js versions defined in the matrix.
    executor: The job uses a custom executor named "custom-executor."
    steps: The steps within the job include checking out the code, installing dependencies, and running tests.
    workflows: The job is part of a workflow named "build_and_test," which specifies the sequence of jobs to be executed.
```

## Further

```txt
Context: A context is a named collection of environment variables and secrets that you define within your CircleCI organization. 
It allows you to centralize and manage sensitive information in one place.

Usage: When you specify a context for a job in your pipeline configuration, you are indicating that the job will have access to the environment variables and secrets stored within that context. This allows you to keep your pipeline configuration clean and avoid exposing sensitive information directly.
```

```txt
Filters: Filters allow you to define conditions or criteria that determine under what circumstances the job will execute. 

Usage: The filters parameter specifies conditions that must be met for the job to be executed.

Conditions: The conditions are defined using various filters such as branches, tags, and paths. 
These filters define the events or changes that should trigger the job.
```
