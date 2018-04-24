resource "aws_security_group" "clients" {
  name        = "${lookup(var.Projet,terraform.workspace)}-clients-${terraform.workspace}"
  description = "Security group for ${lookup(var.Projet,terraform.workspace)} Clients"
  vpc_id      = "${data.aws_vpc.dops.id}"
  tags {
     Name        = "${lookup(var.Projet,terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}-clients"
     Environment = "${lookup(var.Env, terraform.workspace)}"
  }
}

resource "aws_security_group" "servers" {
  name        = "${lookup(var.Projet,terraform.workspace)}-servers-${terraform.workspace}"
  description = "Security group for ${lookup(var.Projet,terraform.workspace)} Servers"
  vpc_id      = "${data.aws_vpc.dops.id}"
  tags {
     Name        = "${lookup(var.Projet,terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}-servers"
     Environment = "${lookup(var.Env, terraform.workspace)}"
  }

  # Accès SSH
   ingress {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      security_groups=["${data.aws_security_group.admin.id}"]
  }

# Accès à ES
  ingress {
    from_port = 9200
    to_port = 9200
    protocol = "TCP"
    security_groups=["${aws_security_group.clients.id}"]
    self=true
  }
  # Accès à ES
    ingress {
      from_port = 9300
      to_port = 9300
      protocol = "TCP"
      security_groups=["${aws_security_group.clients.id}"]
      self=true
    }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
