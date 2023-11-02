resource "aws_vpc" "dev_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}

resource "aws_subnet" "dev-subnet-01" {
  vpc_id                  = aws_vpc.dev_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "dev-public"
  }
}

resource "aws_internet_gateway" "dev-igw-1" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-igw"
  }
}

resource "aws_route_table" "dev-rt-01" {
  vpc_id = aws_vpc.dev_vpc.id

  tags = {
    Name = "dev-public-rt"
  }
}

resource "aws_route" "dev-rt-default" {
  route_table_id         = aws_route_table.dev-rt-01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.dev-igw-1.id
}

resource "aws_route_table_association" "dev-public-assoc" {
  subnet_id      = aws_subnet.dev-subnet-01.id
  route_table_id = aws_route_table.dev-rt-01.id
}

resource "aws_security_group" "dev-sg-01" {
  name        = "dev-sg-01"
  description = "dev security group"
  vpc_id      = aws_vpc.dev_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # input your IP (private)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "dev_auth" {
  key_name   = "devssh"
  public_key = file("~/.ssh/devssh.pub") # you need to configure your own
}

resource "aws_instance" "dev_node_01" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.server_ami.id
  key_name               = aws_key_pair.dev_auth.id
  vpc_security_group_ids = [aws_security_group.dev-sg-01.id]
  subnet_id              = aws_subnet.dev-subnet-01.id
  user_data              = file("userdata.tpl")

  root_block_device {
    volume_size = 10
  }
  tags = {
    Name = "dev-node"
  }

  provisioner "local-exec" {
    command = templatefile("${var.host_os}-ssh-config.tpl", {
      hostname     = self.public_ip,
      user         = "ubuntu",
      identityfile = "~/.ssh/devssh"
    })

    interpreter = var.host_os == "linux" ? ["bash", "-c"] : ["Powershell", "-Command"]
  }
}