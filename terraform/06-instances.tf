resource "aws_instance" "instance" {
  ami                    = "${lookup(var.AmiLinux, lookup(var.Region,terraform.workspace))}"
  instance_type          = "${lookup(var.VMSize, terraform.workspace)}"
  count                  = "${var.nodes}"
  subnet_id              = "${element(data.aws_subnet_ids.private.ids,count.index)}"
  iam_instance_profile   = "${aws_iam_instance_profile.dops-elasticsearch-profile.name}"
  vpc_security_group_ids = ["${aws_security_group.servers.id}"]
  key_name               = "${var.key_name}"
  tags {
        Name        = "${lookup(var.Projet,terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}-${count.index}"
        Environment = "${lookup(var.Env, terraform.workspace)}"
        solution    = "DOPS"
        projet      = "${lookup(var.Projet, terraform.workspace)}"
        roles       = "${lookup(var.Roles, terraform.workspace)}"
        alwayson    = "${lookup(var.Alwayson, terraform.workspace)}"
        patch       = "${lookup(var.Patch, terraform.workspace)}"
        monitored   = "${lookup(var.Monitored, terraform.workspace)}"
  }
  volume_tags {
        Name        = "${lookup(var.Projet,terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}-${count.index}"
        Environment = "${lookup(var.Env, terraform.workspace)}"
  }
lifecycle { ignore_changes = ["user_data"] }

  user_data=<<HEREDOC
#!/bin/bash
  apt-get update
  apt-get install -y python

HEREDOC
}
