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
