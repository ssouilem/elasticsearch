resource "aws_iam_role" "dops-elasticsearch-role" {
   name               = "${upper(lookup(var.Domaine, terraform.workspace))}${lookup(var.Env, terraform.workspace)}RoleForElasticsearchInstances"
   description        = "Role for ${upper(lookup(var.Domaine, terraform.workspace))} Elasticsearch instances in ${lookup(var.Env, terraform.workspace)} environment"
   assume_role_policy = "${data.aws_iam_policy_document.instance-assume-role-policy.json}"
}

resource "aws_iam_policy" "dops-elasticsearch-policy" {
   name        = "${upper(lookup(var.Domaine, terraform.workspace))}${lookup(var.Env, terraform.workspace)}PolicyForElasticsearchInstances"
   description = "Policy for ${upper(lookup(var.Domaine, terraform.workspace))} Elasticsearch instances in ${lookup(var.Env, terraform.workspace)} environment"
   policy      = "${data.aws_iam_policy_document.dops-elasticsearch-policy.json}"
}

resource "aws_iam_role_policy_attachment" "dops-elasticsearch-policy-attachment" {
   role       = "${aws_iam_role.dops-elasticsearch-role.name}"
   policy_arn = "${aws_iam_policy.dops-elasticsearch-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "dops-instance-policy-attachment" {
   role       = "${aws_iam_role.dops-elasticsearch-role.name}"
   policy_arn = "${data.aws_iam_policy.dops-instance-policy.arn}"
}

resource "aws_iam_instance_profile" "dops-elasticsearch-profile" {
   name = "DOPS${lookup(var.Env, terraform.workspace)}ElasticsearchProfile"
   role = "${aws_iam_role.dops-elasticsearch-role.name}"
}

