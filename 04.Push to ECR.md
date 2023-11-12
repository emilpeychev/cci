# Build, Tag, Push Image to ECR

```sh
version: 2.1
orbs:
  trivy-orb: fifteen5/trivy-orb@1.0.0

jobs:

  build_and_push:
    docker:
      - image: cimg/python:3.12
    working_directory: ~/app
    steps:
      - checkout

      - setup_remote_docker:
          docker_layer_caching: true

      - run:
          name: Build the Image 
          command: | 
            docker build -t cci .
            docker tag cci $ECR_REGISTRY/cci:$(git rev-parse --short HEAD)
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
            echo "export AWS_REGION=$AWS_REGION" >> $BASH_ENV
            source $BASH_ENV  

      - run:
          name: Push to ECR
          command: |
            eval $(aws ecr get-login --no-include-email --region $AWS_REGION)
            docker push $ECR_REGISTRY/cci:$(git rev-parse --short HEAD)

      - trivy-orb/scan:
          args: '--no-progress --exit-code 1 image $ECR_REGISTRY/cci:$(git rev-parse --short HEAD)'

workflows:
  version: 2
  build:
    jobs:
      - build_and_push:
          filters:
            branches:
              only: 
                - main
                - dummy

```

## What's what

Continuing after setup remote docker setup!

### Build the Image

 ```xml
 Explanation:

    Split the build and tag process.
    The image is initially tagged as "cci".
    A new tag is created for the ECR repository, using the version variable $(git rev-parse --short HEAD) to generate a hash from the CircleCI build.

 ```

```sh
      - run:
          name: Build the Image 
          command: | 
            # Split the build and tag process.
            # The image is initially tagged as "cci".
            # A new tag is created for the ECR repository, using the version variable $(git rev-parse --short HEAD) to generate a hash from the CircleCI build.
            docker build -t cci .
            docker tag cci $ECR_REGISTRY/cci:$(git rev-parse --short HEAD)
          working_directory: ~/app

```

### Install AWS_CLI

```sh
      - run:
          name: Check AWS CLI Installation
          command: |
             sudo apt -y -qq update
             sudo apt install -y awscli
             sudo apt install -y python3-pip
             sudo pip3 install --upgrade awscli

```

```xml
Explanation:

Setup AWS CLI and Python in the build environment.
Configure AWS environment variables in CircleCI using the exported values.

```

### Configure AWS Environment

```xml
Explanation:

    Setup AWS CLI and Python in the build environment.
    Configure AWS environment variables in CircleCI using the exported values.

```

```sh
      - run:
          name: Configure AWS Environment
          command: |
            echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" >> $BASH_ENV
            echo "export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" >> $BASH_ENV
            echo "export AWS_REGION=$AWS_REGION" >> $BASH_ENV
            source $BASH_ENV 

```

### Policy for AWS-ECR

```sh
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Sid": "VisualEditor0",
   "Effect": "Allow",
   "Action": [
    "ecr:GetDownloadUrlForLayer",
    "ecr:BatchGetImage",
    "ecr:DescribeImages",
    "ecr:DescribeRepositories",
    "ecr:UploadLayerPart",
    "ecr:ListImages",
    "ecr:InitiateLayerUpload",
    "ecr:BatchCheckLayerAvailability",
    "ecr:PutImage"
   ],
   "Resource": "arn:aws:ecr:eu-west-3:1111111111111:repository/cci"
  },
  {
   "Sid": "VisualEditor1",
   "Effect": "Allow",
   "Action": [
    "ecr:DescribePullThroughCacheRules",
    "ecr:GetAuthorizationToken"
   ],
   "Resource": "*"
  }
 ]
}

```

```txt
Explanation:
This policy must have all the actions and "ecr:GetAuthorizationToken" for authentication with ECR.
setup permissions on ECR side.
Go to Permissions and create policy with:

Actions
ecr:BatchCheckLayerAvailability
ecr:BatchGetImage
ecr:CompleteLayerUpload
ecr:DescribeImages
ecr:GetDownloadUrlForLayer
ecr:PutImage

Also add the IAM user and repo to restrict.

```

### Push to ECR

```xml
Explanation:

Commands:
            eval $(aws ecr get-login --no-include-email --region $AWS_REGION)
Login to ECR.
           docker push $ECR_REGISTRY/cci:$(git rev-parse --short HEAD)
Push the image to the repo.

```

```sh
      - run:
          name: Push to ECR
          command: |
            eval $(aws ecr get-login --no-include-email --region $AWS_REGION)
            docker push $ECR_REGISTRY/cci:$(git rev-parse --short HEAD)

```

### Limit Pipeline only when pushed to master branch

```xml
Explanation:

Limit Pipeline only when pushed to master branch

Explanation:

    The workflow is configured to run only when changes are pushed to the "main" or "dummy" branches.

```

```sh
workflows:
  version: 2
  build:
    jobs:
      - build_and_push:
          filters:
            branches:
              only: 
                - main
                - dummy

```
