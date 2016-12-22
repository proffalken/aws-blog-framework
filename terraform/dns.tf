resource "aws_route53_zone" "flask-blog" {
   name = "flask-blog.co.uk"
}

resource "aws_route53_record" "mail" {
   zone_id = "${aws_route53_zone.flask-blog.zone_id}"
   name = "mail.flask-blog.co.uk"
   type = "A"
   ttl = "300"
   records = ["52.1.247.144"]
}
resource "aws_route53_record" "mx" {
   zone_id = "${aws_route53_zone.flask-blog.zone_id}"
   name = "flask-blog.co.uk"
   type = "MX"
   ttl = "300"
   records = ["10 mail.flask-blog.co.uk"]
}
resource "aws_route53_record" "nat" {
   zone_id = "${aws_route53_zone.flask-blog.zone_id}"
   name = "nat.flask-blog.co.uk"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.nat.public_ip}"]
}
resource "aws_route53_record" "www01" {
   zone_id = "${aws_route53_zone.flask-blog.zone_id}"
   name = "www01.flask-blog.co.uk"
   type = "A"
   ttl = "300"
   records = ["${aws_instance.web.private_ip}"]
}
resource "aws_route53_record" "www" {
   zone_id = "${aws_route53_zone.flask-blog.zone_id}"
   name = "www.flask-blog.co.uk"
   type = "CNAME"
   ttl = "300"
   records = ["${aws_elb.web.dns_name}"]
}
