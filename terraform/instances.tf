resource "aws_instance" "web" {
  ami = "${lookup(var.centos_amis, var.region)}"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.public.id}"
  vpc_security_group_ids = ["${aws_security_group.default.id}","${aws_security_group.web.id}"]
  key_name = "${aws_key_pair.aws-blog-deployer.key_name}"
  source_dest_check = false
  tags = {
    Name = "web01"
    ansible_group_web_servers = "1"
  }
  connection {
    user = "ec2-user"
    key_file = "${var.deploy_key}"
  }
}
