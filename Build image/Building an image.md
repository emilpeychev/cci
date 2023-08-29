# Build Image

```py
version: 2.1

jobs:
  build:
    docker:
      - image: cimg/python:3.11.4
    working_directory: ~/app
    steps:
      - setup_remote_docker:
          version: 20.10.14
          docker_layer_caching: true
      - checkout
      - run:
          name: Show current branch
          command: echo $CIRCLE_BRANCH
      - run:
          name: Build the Image 
          command: docker build -t flask-app .
workflows:
  version: 2
  build:
    jobs:
      - build
```

## What's what

```sh
jobs:
  build:
    docker:
      - image: cimg/python:3.11.4
    working_directory: ~/app
```

1. This is the image of choice from [circleci images](https://circleci.com/developer/images)/ [more](https://circleci.com/developer/images/image/cimg/python). Nb! if you change to docker images you need to make sure that all dependencies are present in that image. Otherwise you will get an Error exit code 127 due to missing environmental parameters.
2. Woking directory is a place where the code is build in the container.

```sh
    steps:
      - setup_remote_docker:
          version: 20.10.14
          docker_layer_caching: true
      - checkout
      - run:
          name: Show current branch
          command: echo $CIRCLE_BRANCH
      - run:
          name: Build the Image 
          command: docker build -t flask-app .
```

3.Setup remote docker. This sets up a remote docker container in circleci environment.

- Without this option or having set up CircleCI to run jobs [locally](https://circleci.com/docs/how-to-use-the-circleci-local-cli/#run-a-job-in-a-container-on-your-machine) you will get an Error!
- The version is optional and it can be removed.

4.Docker Layer Caching

- It caches the layers for your images and builds much faster.

5.Build the Image

- Just pass a command as in docker.
