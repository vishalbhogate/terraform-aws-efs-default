data "aws_route53_zone" "selected" {
  count = var.enabled ? 1 : 0
  name  = var.dns_name
  private_zone = var.hosted_zone_is_internal
}

resource "aws_route53_record" "hostnames_internal" {
  count   = var.hosted_zone_is_internal && var.dns_name != "" ? 1 : 0
  zone_id = data.aws_route53_zone.selected.*.zone_id[0]
  name    = var.dns_name
  type    = var.type
  ttl     = var.ttl
  records = [local.dns_name]
}