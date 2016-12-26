/* NAT/VPN server */
resource "aws_instance" "nat" {
  ami = "ami-5c82fd2f"
  instance_type = "t2.nano"
  subnet_id = "${aws_subnet.public.id}"
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
  provisioner "remote-exec" {
    inline = [
      "sudo iptables -t nat -A POSTROUTING -j MASQUERADE",
      "echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null",
    ]
  }
}
