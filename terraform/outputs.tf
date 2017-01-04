output "nat.ip" {
  value = "${aws_instance.nat.public_ip}"
}
output "ns1" {
  value = "${aws_route53_zone.flask-blog.name_servers.1}"
}
output "ns2" {
  value = "${aws_route53_zone.flask-blog.name_servers.2}"
}
output "ns3" {
  value = "${aws_route53_zone.flask-blog.name_servers.3}"
}

output "kibana_elb" {
  value = "${aws_elb.kibana.dns_name}"
}

output "web_elb" {
  value = "${aws_elb.web.dns_name}"
}

output "consul_elb" {
  value = "${aws_elb.consul.dns_name}"
}

output "vpc_subnet" {
  value = "${var.vpc_cidr}"
}

output "web_database_server" {
  value = "${aws_db_instance.aws-blog-mysql.address}"
}
