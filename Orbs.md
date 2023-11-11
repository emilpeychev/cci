# Orbs

Working with Orbs is using automatic presets.

```sh
version: 2.1
orbs:
  trivy-orb: fifteen5/trivy-orb@1.0.0

jobs:

  build_and_push:
    docker:
      - image: cimg/python:3.11.5
    working_directory: ~/app
    steps:
      - checkout

      - setup_remote_docker:
          docker_layer_caching: false

      - run:
          name: Build the Image 
          command: | 
            docker build -t cci .
            docker tag cci 11111111111111111.dkr.ecr.eu-west-3.amazonaws.com/cci:${CIRCLE_SHA1}
          working_directory: ~/app

      - run:
          name: Check AWS CLI Installation
          command: |
             sudo apt -y -qq update
             sudo apt install -y awscli
             sudo apt install -y python3-pip
             sudo pip3 install --upgrade awscli
      - run:
          name: Configure AWS Environment
          command: |
            echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> $BASH_ENV
            echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> $BASH_ENV
            source $BASH_ENV  

      - run:
          name: Push to ECR
          command: |
            eval $(aws ecr get-login --no-include-email --region eu-west-3)
            docker push 324221743401.dkr.ecr.eu-west-3.amazonaws.com/cci:${CIRCLE_SHA1}

      - trivy-orb/scan:
          args: '--no-progress --exit-code 1 image 11111111111111111.dkr.ecr.eu-west-3.amazonaws.com/cci:${CIRCLE_SHA1}'

workflows:
  build:
    jobs:
      - build_and_push
```

## Orb name matching

Make sure these match:

```sh
orbs:
  trivy-orb: fifteen5/trivy-orb@1.0.0

        - trivy-orb/scan:
          args: '--no-progress --exit-code 1 image 11111111111111111.dkr.ecr.eu-west-3.amazonaws.com/cci:${CIRCLE_SHA1}'
```

This is a vulnerability scanner.