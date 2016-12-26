/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "igw01-aws-blog" {
  vpc_id = "${aws_vpc.aws-blog.id}"
}

/* Public subnet */
resource "aws_subnet" "public-aws-blog" {
  vpc_id            = "${aws_vpc.aws-blog.id}"
  cidr_block        = "${var.public_subnet_cidr}"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = true
  depends_on = ["aws_internet_gateway.igw01-aws-blog"]
  tags {
    Name = "public-aws-blog"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public-rt-aws-blog" {
  vpc_id = "${aws_vpc.aws-blog.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw01-aws-blog.id}"
  }
  tags {
    Name = "route_public_to_igw"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "public-rta-aws-blog" {
  subnet_id = "${aws_subnet.public-aws-blog.id}"
  route_table_id = "${aws_route_table.public-rt-aws-blog.id}"
}
