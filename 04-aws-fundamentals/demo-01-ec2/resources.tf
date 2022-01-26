data "http" "my_ip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_key_pair" "ssh" {
  key_name = "myfirstec2instance"
}

resource "aws_security_group" "allow_ssh" {
  name        = "launch-wizard-1"
  description = "launch-wizard-1 created ${timestamp()}"

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }

}

resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = data.aws_key_pair.ssh.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
}