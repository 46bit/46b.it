data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-artful-17.10-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "concourse" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  instance_type               = "t2.small"
  key_name                    = "${aws_key_pair.miki.key_name}"
  subnet_id                   = "${aws_subnet.miki.id}"
  vpc_security_group_ids      = ["${aws_security_group.miki-public.id}"]
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "standard"
    volume_size           = "40"
    delete_on_termination = "true"
  }

  tags {
    Name = "miki-concourse"
  }
}
