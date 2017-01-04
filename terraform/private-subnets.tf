/* Private subnet */
resource "aws_subnet" "private-aws-blog" {
  vpc_id            = "${aws_vpc.aws-blog.id}"
  cidr_block        = "${var.private_subnet_cidr}"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = false
  depends_on = ["aws_instance.nat"] 
  tags {
    Name = "private-aws-blog"
  }
}

/* Routing table for private subnet */
resource "aws_route_table" "private-rt-aws-blog" {
  vpc_id = "${aws_vpc.aws-blog.id}"
  route {
    cidr_block = "0.0.0.0/0"
    instance_id = "${aws_instance.nat.id}"
  }
  tags {
    Name = "private-to-public"
  }
}

/* Associate the routing table to public subnet */
resource "aws_route_table_association" "aws-blog-rta-private" {
  subnet_id = "${aws_subnet.private-aws-blog.id}"
  route_table_id = "${aws_route_table.private-rt-aws-blog.id}"
}

resource "aws_subnet" "aws-blog-mysql-az1" {
  vpc_id            = "${aws_vpc.aws-blog.id}"
  cidr_block        = "${var.mysql-az1_subnet_cidr}"
  availability_zone = "eu-west-1a"
  map_public_ip_on_launch = false
  tags {
    Name = "aws-blog-mysql-az1"
  }
}
resource "aws_subnet" "aws-blog-mysql-az2" {
  vpc_id            = "${aws_vpc.aws-blog.id}"
  cidr_block        = "${var.mysql-az2_subnet_cidr}"
  availability_zone = "eu-west-1b"
  map_public_ip_on_launch = false
  tags {
    Name = "aws-blog-mysql-az2"
  }
}
