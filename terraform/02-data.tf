data "aws_availability_zones" "available" {}

data "aws_vpc" "dops" {
  tags {
     Name = "${lookup(var.Domaine, terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}"
  }
}

data "aws_security_group" "admin" {
  vpc_id = "${data.aws_vpc.dops.id}"
  tags {
    Name = "${lookup(var.Domaine, terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}-ssh"
  }
}

data "aws_security_group" "http" {
  vpc_id = "${data.aws_vpc.dops.id}"
  tags {
    Name = "${lookup(var.Domaine, terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}-web"
  }
}

data "aws_route53_zone" "dops" {
  name = "${lookup(var.Domaine, terraform.workspace)}.open.global."
}

data "aws_route53_zone" "internal" {
  name = "${lookup(var.DnsZoneName, terraform.workspace)}."
  private_zone = true
  vpc_id = "${data.aws_vpc.dops.id}"
  tags {
    "Environment" = "${lookup(var.Env, terraform.workspace)}"
  }
}

data "aws_iam_instance_profile" "default-ssm-ec2profile" {
  name = "default-ssm-ec2profile"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${data.aws_vpc.dops.id}"
  tags {
    Tier = "private"
  }
}

data "aws_iam_policy" "dops-instance-policy" {
  arn = "${lookup(var.DopsInstancePolicyArn, terraform.workspace)}"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "dops-elasticsearch-policy" {
   statement {
      effect = "Allow"
      actions = [
         "ec2:Describe*"
      ]
      resources = ["*"]
   }
}

