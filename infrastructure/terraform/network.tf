resource "aws_vpc" "miki" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true

  tags {
    Name = "miki"
  }
}

resource "aws_internet_gateway" "miki" {
  vpc_id = "${aws_vpc.miki.id}"

  tags {
    Name = "miki-internet-gateway"
  }
}

resource "aws_route_table" "miki" {
  vpc_id = "${aws_vpc.miki.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.miki.id}"
  }

  tags {
    Name = "miki-route-table"
  }
}

resource "aws_subnet" "miki" {
  vpc_id            = "${aws_vpc.miki.id}"
  cidr_block        = "10.0.0.0/24"
  depends_on        = ["aws_internet_gateway.miki"]

  tags {
    Name = "miki-subnet"
  }
}

resource "aws_route_table_association" "infra" {
  subnet_id      = "${aws_subnet.miki.id}"
  route_table_id = "${aws_route_table.miki.id}"
}

resource "aws_security_group" "miki-public" {
  vpc_id      = "${aws_vpc.miki.id}"
  description = "Allow public internet access"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "miki-public"
  }
}
