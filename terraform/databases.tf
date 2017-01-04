/* Database configuration */
resource "aws_db_subnet_group" "aws-blog_db_subnet_group" {
    name = "aws-blog-mysql-subnetgrp"
    description = "RDS subnet group"
    subnet_ids = ["${aws_subnet.aws-blog-mysql-az1.id}", "${aws_subnet.aws-blog-mysql-az2.id}"]
}

resource "aws_db_instance" "aws-blog-mysql" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.medium"
  name                 = "awsblog"
  username             = "awsblog"
  password             = "bloggymcblogface"
  db_subnet_group_name = "${aws_db_subnet_group.aws-blog_db_subnet_group.name}"
  parameter_group_name = "default.mysql5.7"
}
