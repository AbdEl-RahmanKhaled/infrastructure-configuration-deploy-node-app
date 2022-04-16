output "vpc_id" {
    value = aws_vpc.my-vpc.id
}

output "vpc_cidr_block" {
    value = aws_vpc.my-vpc.cidr_block
}

output "pub_sub-1_id" {
    value = aws_subnet.public-sub-zone-1.id
}

output "pub_sub-2_id" {
    value = aws_subnet.public-sub-zone-2.id
}

output "pri_sub-1_id" {
    value = aws_subnet.private-sub-zone-1.id
}

output "pri_sub-2_id" {
    value = aws_subnet.private-sub-zone-2.id
}