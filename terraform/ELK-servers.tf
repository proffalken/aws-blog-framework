/* App servers */
resource "aws_instance" "kibana" {
  count = 2
  ami = "${lookup(var.centos_amis, var.region)}"
  instance_type = "t2.medium"
  subnet_id = "${aws_subnet.private-aws-blog.id}"
  vpc_security_group_ids = ["${aws_security_group.kibana.id}"]
  key_name = "${aws_key_pair.aws-blog-deployer.key_name}"
  source_dest_check = false
  tags = { 
    Name = "kibana-app-${count.index}-aws-blog"
    ansible_group_kibana_servers = "1"
    ansible_group_consul_clients = "1"
  }
}

/* Elasticsearch Servers */
resource "aws_instance" "elasticsearch" {
  count = 3
  ami = "${lookup(var.centos_amis, var.region)}"
  instance_type = "m3.large"
  subnet_id = "${aws_subnet.private-aws-blog.id}"
  vpc_security_group_ids = ["${aws_security_group.elasticsearch.id}"]
  key_name = "${aws_key_pair.aws-blog-deployer.key_name}"
  source_dest_check = false
  ebs_block_device {
     device_name = "/dev/sdl"
     volume_size = "5"
     volume_type = "standard"
     delete_on_termination = true
     encrypted = true
  }
  tags = { 
    Name = "elasticsearch-app-${count.index}-aws-blog"
    ansible_group_elasticsearch_servers = "1"
    ansible_group_consul_clients = "1"
  }
}

/* Logstash Servers */
resource "aws_instance" "logstash" {
  count = 2
  ami = "${lookup(var.centos_amis, var.region)}"
  instance_type = "t2.medium"
  subnet_id = "${aws_subnet.private-aws-blog.id}"
  vpc_security_group_ids = ["${aws_security_group.logstash.id}", "${aws_security_group.elasticsearch.id}"]
  key_name = "${aws_key_pair.aws-blog-deployer.key_name}"
  source_dest_check = false
  tags = { 
    Name = "logstash-app-${count.index}-aws-blog"
    ansible_group_logstash_servers = "1"
    ansible_group_consul_clients = "1"
  }
}

