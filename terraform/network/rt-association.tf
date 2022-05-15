resource "aws_route_table_association" "pub-zone-1" {
  subnet_id      = aws_subnet.public-sub-zone-1.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "pub-zone-2" {
  subnet_id      = aws_subnet.public-sub-zone-2.id
  route_table_id = aws_route_table.public-rt.id
}

# private
resource "aws_route_table_association" "priv-zone-1" {
  subnet_id      = aws_subnet.private-sub-zone-1.id
  route_table_id = aws_route_table.private-rt-1.id
}

resource "aws_route_table_association" "priv-zone-2" {
  subnet_id      = aws_subnet.private-sub-zone-2.id
  route_table_id = aws_route_table.private-rt-2.id
}