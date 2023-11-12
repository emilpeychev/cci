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

* Isolation: Jobs run independently, preventing interference with other jobs.

* Independence: Jobs can run concurrently, enhancing overall pipeline speed.

* Definition: Each job includes steps, commands, and configurations needed to fulfill its tasks.

* Dependencies: Jobs may have dependencies on others, running only when specific conditions or preceding jobs are met.

* Artifacts: Jobs can produce artifacts, files or data used in subsequent pipeline stages.

* Execution Environment: Jobs can run in different environments like Docker containers or virtual machines.

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

## Runtime Environments

```txt
Runtime Environments:

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

### Filters

CircleCI allows you to apply filters to control when jobs run, based on conditions such as branch names, tags, or event types.

```sh
workflows:
  version: 2
  say-hello-workflow:
    jobs:
      - say-hello:
          filters:
            branches:
              only:
                - main
            tags:
              ignore: /.*/

```

In this example, the say-hello job will run only on the main branch and ignore any tag events.

### Contexts

Contexts in CircleCI are used to manage and securely store environment variables required for jobs. These variables might include sensitive information like API keys, credentials, or configuration settings. Using contexts helps in centralizing and organizing this sensitive information, making it easier to maintain and update.

```sh
version: 2.1

jobs:
  deploy:
    docker:
      - image: cimg/base:stable
    steps:
      - checkout
      - run:
          name: Deploy
          command: make deploy
  say-hello:
    docker:
      - image: cimg/base:stable
    steps:
      - checkout
      - run:
          name: "Say hello"
          command: "echo Hello, World!"
          environment:
            API_KEY: ${{ secrets.API_KEY }}
            DATABASE_URL: ${{ secrets.DATABASE_URL }}

```

In this example, sensitive information such as API_KEY and DATABASE_URL is stored securely in a context. These values can then be referenced in the job configuration using ${{ secrets.CONTEXT_NAME.VARIABLE_NAME }}.

### Summary

* Fetching CodeThe `checkout` step connects to the `Git Repository`, fetching the latest code.
Checkout is always first. followed by `run commands`.
* Working Directory: Code is placed in a designated `working directory within the CircleCI environment`.
* Subsequent Steps: After "checkout," define `steps` for `building`, `testing`, and `deploying code`.
* Workflow Orchestration: The `workflow` section specifies the sequence in which jobs are executed.
* Filters: Allow you to `control when jobs run` based on `conditions like branch names or tags`.
* Contexts: Securely manage and `reference environment variables` using contexts, particularly useful for storing sensitive information.
