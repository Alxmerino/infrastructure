output "app_vpc_id" {
  value = aws_vpc.main.id
}

output "app_pub_subnet_id" {
  value = aws_subnet.pub_subnet.*.id
}

output "app_pub_subnet_ids" {
  value = [for s in aws_subnet.pub_subnet: s.id]
}

output "app_prv_subnet_id" {
  value = aws_subnet.prv_subnet.*.id
}

output "app_cidr_blocks" {
  value = aws_vpc.main.cidr_block
}
