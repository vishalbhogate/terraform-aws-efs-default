
resource "aws_security_group" "efs_sg" {
  count = var.enabled ? 1 : 0

  name        = "${local.name}-efs"
  description = "SG for EFS"
  vpc_id      = data.aws_vpc.selected.id

  tags = merge(
    var.tags,
    {
      "Name" = join("-",[local.name,"lb"])
    },
  )
}


resource "aws_security_group_rule" "default" {
  for_each = local.rules

  security_group_id = aws_security_group.efs_sg.id
  type              = each.value.type
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  protocol          = each.value.protocol
  description       = lookup(each.value, "description", "Managed by Terraform")
  cidr_blocks      = try(length(lookup(each.value, "cidr_blocks", [])), 0) > 0 ? each.value["cidr_blocks"] : null
  ipv6_cidr_blocks = try(length(lookup(each.value, "ipv6_cidr_blocks", [])), 0) > 0 ? each.value["ipv6_cidr_blocks"] : null
  prefix_list_ids  = try(length(lookup(each.value, "prefix_list_ids", [])), 0) > 0 ? each.value["prefix_list_ids"] : null

  source_security_group_id = lookup(each.value, "source_security_group_id", null)
}