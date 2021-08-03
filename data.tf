
data aws_vpc "selected" {
  filter {
    name   = "tag:Name"
    values = ["${local.solution_name_prefix}-${var.network_instance}-vpc"]
  }
}

data aws_subnet_ids "private" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Scheme"
    values = ["private"]
  }
}

data aws_subnet "private" {
  for_each = data.aws_subnet_ids.private.ids
  id = each.value
}
