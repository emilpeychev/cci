# Circle CI

```py
# Use the latest 2.1 version of CircleCI pipeline process engine.
# See: https://circleci.com/docs/configuration-reference
version: 2.1

# Define a job to be invoked later in a workflow.
# See: https://circleci.com/docs/configuration-reference/#jobs
jobs:
  say-hello:
    # Specify the execution environment. You can specify an image from Docker Hub or use one of our convenience images from CircleCI's Developer Hub.
    # See: https://circleci.com/docs/configuration-reference/#executor-job
    docker:
      - image: cimg/base:stable
    # Add steps to the job
    # See: https://circleci.com/docs/configuration-reference/#steps
    steps:
      - checkout
      - run:
          name: "Say hello"
          command: "echo Hello, World!"

# Orchestrate jobs using workflows
# See: https://circleci.com/docs/configuration-reference/#workflows
workflows:
  say-hello-workflow:
    jobs:
      - say-hello

```

## What is what/ a pipeline breakdown

### version: 2.1

Minimal version allowed.

### Jobs

A Workflow is comprised of one or more uniquely named jobs.

* Isolation: Each job runs in its own isolated environment, which helps ensure that the job's execution doesn't interfere with other jobs.

* Independence: Jobs can be run independently and in parallel, which speeds up the overall pipeline execution.

* Definition: A job's definition includes the steps, commands, environment settings, and other configuration needed to accomplish its tasks.

* Dependencies: Jobs can have dependencies on other jobs, meaning they can be triggered to run only after certain conditions or previous jobs have been met.

* Artifacts: Jobs can produce artifacts, which are files or data generated during the job's execution. These artifacts can be used in subsequent jobs or stages of the pipeline.

* Execution Environment: Jobs can run in different execution environments, such as Docker containers, virtual machines, or other platforms.

```py
jobs: #name
  say-hello:
    # place where code is pulled by -checkout, within the Docker container.
    working_directory: ~/canary-python
    # Environment
    docker:
      - image: cimg/base:stable
    # Steps of the job 
    steps:
      - run:
          name: Running tests
          command: make test
```

## Environments

```txt
Environments:

- docker/ machine/ mac/
- CircleCI offers several execution environments to run your jobs:
- docker (Linux), machine (LinuxVM, Windows, GPU, Arm), or macos.
```

### Steps

```py
jobs:
  build:
  # name
    steps:
      - checkout
      # Pull the code from repo
    - run: #step
    # run commands   
        name: Running tests
        command: make test
        # you can replace command with 'shell' if the script requires it.
    - run: #step
        name: test
    - run: #step
        name: deploy
```

### Workflows

Jobs are part of a workflow named "say-hello-workflow" which specifies the sequence of jobs to be executed.

### Summary

```txt
Fetching Code/ The "checkout" step connects Git repository and fetches the latest version of your codebase.
- Checkout is always first. followed by 'run commands'.

Working Directory: The fetched code is placed into a designated working directory within the CircleCI environment/executor. This directory becomes the base directory for all subsequent steps in your pipeline. 
Any steps you define under "run" or other step types will operate within this working directory.

Subsequent Steps: After the "checkout" step, you can define other steps that use the checked-out code. For example, you might have steps for Building, Testing, and Deploying your code. 
```
