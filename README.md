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

1. Default pipeline breakdown.
2. Components:

- version: 2.1
- jobs /a pipeline is composed of different jobs.
- name / just a job name.

```txt
Environments (aka Executors):

- docker/ machine/ mac/
- CircleCI offers several execution environments to run your jobs:
- docker (Linux), machine (LinuxVM, Windows, GPU, Arm), or macos.
```

- steps

```txt
Steps setting in a job is a list of single key/value pairs.
The value may be either a configuration map or a string.

- run (means run a command)
- run/ allows us to directly specify which command to execute as a string value.
- it also supports run 'shell' for specific shells.
Example: 
```

```py
jobs:
  build:
    working_directory: ~/canary-python
    environment:
      FOO: bar
    steps:
      - run:
          name: Running tests
          command: make test
```

```py
jobs:
  build:
    steps:
      - checkout
```

```txt
Explained:
Fetching Code/ The "checkout" step connects Git repository and fetches the latest version of your codebase.
- Checkout is always first. followed by 'run commands'.

Working Directory: The fetched code is placed into a designated working directory within the CircleCI environment/executor. This directory becomes the base directory for all subsequent steps in your pipeline. Any steps you define under "run" or other step types will operate within this working directory.

Subsequent Steps: After the "checkout" step, you can define other steps that use the checked-out code. For example, you might have steps for Building, Testing, and Deploying your code. 
```

```py
Pipeline
├── Step 1: Checkout (Fetch code)
├── Step 2: Run - Install Dependencies
├── Step 3: Run - Run Tests
├── Step 4: Run - Build
├── Step 5: Run - Deploy
└── Step 6: Run - Notify

```
