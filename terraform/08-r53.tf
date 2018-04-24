resource "aws_route53_record" "int" {
  count   = "${var.nodes}"
  zone_id = "${data.aws_route53_zone.internal.zone_id}"
  name    = "${lookup(var.Projet,terraform.workspace)}-${lower(lookup(var.Env, terraform.workspace))}-${count.index}.${lookup(var.DnsZoneName, terraform.workspace)}"
  type    = "A"
  ttl     = "300"
  records = ["${element(aws_instance.instance.*.private_ip,count.index)}"]
}
