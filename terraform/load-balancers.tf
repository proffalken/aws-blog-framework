/* Load balancer */
resource "aws_elb" "web" {
  name = "aws-blog-web-elb"
  subnets = ["${aws_subnet.public-aws-blog.id}"]
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.elb_access.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 30
    target = "HTTP:80/"
    interval = 60
  }
  access_logs {
    bucket = "aws-blog-elb-logs"
    interval = 60
  }

  instances = ["${aws_instance.web.*.id}"]
}

/* Set sticky sessions for Web Sessions */
resource "aws_lb_cookie_stickiness_policy" "web" {
      name = "web-policy"
      load_balancer = "${aws_elb.web.id}"
      lb_port = 80
      cookie_expiration_period = 600
}

/* Load balancer */
resource "aws_elb" "kibana" {
  name = "aws-blog-kibana-elb"
  subnets = ["${aws_subnet.public-aws-blog.id}"]
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.elb_access.id}"]
  listener {
    instance_port = 5601
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 30
    target = "TCP:5601"
    interval = 60
  }
  access_logs {
    bucket = "aws-blog-elb-logs"
    interval = 60
  }

  instances = ["${aws_instance.kibana.*.id}"]
}

/* Set sticky sessions for Kibana */
resource "aws_lb_cookie_stickiness_policy" "kibana" {
      name = "kibana-policy"
      load_balancer = "${aws_elb.kibana.id}"
      lb_port = 80
      cookie_expiration_period = 600
}

/* Load balancer */
resource "aws_elb" "consul" {
  name = "aws-blog-consul-elb"
  subnets = ["${aws_subnet.public-aws-blog.id}"]
  security_groups = ["${aws_security_group.default.id}", "${aws_security_group.elb_access.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  instances = ["${aws_instance.consul.*.id}"]
}

