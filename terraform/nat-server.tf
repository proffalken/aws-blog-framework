/* NAT/VPN server */
resource "aws_instance" "nat" {
  ami = "ami-d51b3ba6"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.public-aws-blog.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}", "${aws_security_group.nat.id}"]
  key_name = "${aws_key_pair.aws-blog-deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "nat-aws-blog"
    ansible_group_nat_instance = 1
    ansible_group_consul_clients = 1
  }
  connection {
    user = "ec2-user"
    key_file = "${var.deploy_key}"
  }
}
