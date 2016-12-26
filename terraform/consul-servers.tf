/* Consul Servers */
resource "aws_instance" "consul" {
  count = 1
  ami = "${lookup(var.centos_amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.private-aws-blog.id}"
  security_groups = ["${aws_security_group.consul_servers.id}"]
  key_name = "${aws_key_pair.aws-blog-deployer.key_name}"
  source_dest_check = false
  tags = { 
    Name = "consul-app-${count.index}-aws-blog"
    ansible_group_consul_servers = "1"
  }
}
