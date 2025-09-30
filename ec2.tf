data "aws_ami" "amazon_linux_2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_key_pair" "default" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
}

variable "public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

resource "aws_instance" "app" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = aws_key_pair.default.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
   user_data = templatefile("${path.module}/userdata.sh", {
    docker_image_uri = var.docker_image_uri
    aws_region       = var.aws_region
  })

  tags = {
    Name = "${var.project_name}-ec2"
  }
}
