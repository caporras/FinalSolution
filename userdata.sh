#!/bin/bash
# Instala docker y arranca el contenedor desde ECR
ECR_URI="${docker_image_uri}"
IMAGE_TAG="latest"

# install docker on Amazon Linux 2
amazon-linux-extras install -y docker
service docker start
usermod -a -G docker ec2-user

# Install jq and awscli v2 for login
yum install -y jq

# Install AWS CLI v2 (if not present)
if ! command -v aws &> /dev/null
then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
  unzip /tmp/awscliv2.zip -d /tmp
  /tmp/aws/install
fi

# Login to ECR (instance role must have permission)
aws ecr get-login-password --region ${aws_region} | docker login --username AWS --password-stdin $(echo $ECR_URI | cut -d'/' -f1)


# Pull and run (restart policy)
docker pull ${ECR_URI}:${IMAGE_TAG} || true
docker run -d --name techtest-app -p 80:80 --restart unless-stopped ${ECR_URI}:${IMAGE_TAG}
