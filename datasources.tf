data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["179496348720"]

  filter {
    name   = "name"
    values = ["179496348720/jenkins-node-docker-sample-app"]
  }
}