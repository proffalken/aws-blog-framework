/* Default security group */
resource "aws_security_group" "default" {
  name = "default-aws-blog"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "aws-blog-default-securitygroup"
  }
}

/* Security group for the nat server */
resource "aws_security_group" "nat" {
  name = "nat-aws-blog"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet. Also allows outbound HTTP[S]"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["10.128.1.0/24"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["10.128.1.0/24"]
  }

  egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags {
    Name = "nat-aws-blog"
  }
}

/* Security group for the web nodes */
resource "aws_security_group" "web" {
  name = "web-aws-blog"
  description = "Web Nodes"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = ["${aws_security_group.elb_access.id}"]
    self = true
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    security_groups = ["${aws_security_group.elb_access.id}"]
    self = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "web-aws-blog" 
  }
}

/* Security group for the Load Balancers */
resource "aws_security_group" "elb_access" {
  name = "elb_access-aws-blog"
  description = "Security group for ELBs that allows web traffic from internet"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "elb_access-aws-blog" 
  }
}
/* Security group for the consul servers */
resource "aws_security_group" "consul_servers" {
  name = "kibana_consul-aws-blog"
  description = "Security group for Consul Servers"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = ["${aws_security_group.elb_access.id}"]
    self = true
  }

  ingress {
    from_port = 8300
    to_port   = 8303
    protocol  = "tcp"
    cidr_blocks = ["10.128.1.0/24"]
    self = true
  }

  ingress {
    from_port = 8400
    to_port   = 8400
    protocol  = "tcp"
    cidr_blocks = ["10.128.1.0/24"]
    self = true
  }

  ingress {
    from_port = 8500
    to_port   = 8500
    protocol  = "tcp"
    cidr_blocks = ["10.128.1.0/24"]
    self = true
  }

  ingress {
    from_port = 8600
    to_port   = 8600
    protocol  = "tcp"
    cidr_blocks = ["10.128.1.0/24"]
    self = true
  }


  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "consul_servers-aws-blog" 
  }
}

/* Security group for the kibana nodes */
resource "aws_security_group" "kibana" {
  name = "kibana-aws-blog"
  description = "Kibana Nodes"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    self = true
  }

  ingress {
    from_port   = "8301"
    to_port     = "8301"
    protocol    = "tcp"
    self        = true
    cidr_blocks = ["10.128.1.0/24"]
  }

  ingress {
    from_port = 5601
    to_port   = 5601
    protocol  = "tcp"
    security_groups = ["${aws_security_group.elb_access.id}"]
    self = true
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    security_groups = ["${aws_security_group.elb_access.id}"]
    self = true
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    security_groups = ["${aws_security_group.elb_access.id}"]
    self = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "kibana-aws-blog" 
  }
}

/* Security group for the logstash nodes */
resource "aws_security_group" "logstash" {
  name = "logstash-aws-blog"
  description = "Logstash Nodes"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "8300"
    to_port     = "8303"
    protocol    = "tcp"
    self        = true
    cidr_blocks = ["10.128.0.0/24"]
  }

  ingress {
    from_port = 1514
    to_port   = 1514
    protocol  = "tcp"
    cidr_blocks = ["10.128.0.0/24"]
    self = true
  }

  ingress {
    from_port = 1514
    to_port   = 1514
    protocol  = "udp"
    cidr_blocks = ["10.128.0.0/24"]
    self = true
  }

  /* Standard SYSLOG TCP */
  ingress {
    from_port = 514
    to_port   = 514
    protocol  = "tcp"
    cidr_blocks = ["10.128.0.0/24"]
    self = true
  }

  /* Standard SYSLOG UDP */
  ingress {
    from_port = 514
    to_port   = 514
    protocol  = "udp"
    cidr_blocks = ["10.128.0.0/16"]
    self = true
  }

  /* Windows Metrics TCP */
  ingress {
    from_port = 3515
    to_port   = 3517
    protocol  = "tcp"
    cidr_blocks = ["10.128.0.0/16"]
  }

  /* Windows Metrics UDP */
  ingress {
    from_port = 3515
    to_port   = 3517
    protocol  = "udp"
    cidr_blocks = ["10.128.0.0/16"]
  }

  /* Graphite Metrics */
  ingress {
    from_port = 2003
    to_port   = 2003
    protocol  = "tcp"
    cidr_blocks = ["10.128.0.0/16"]
  }

  ingress {
    from_port = 2003
    to_port   = 2003
    protocol  = "udp"
    cidr_blocks = ["10.128.0.0/16"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "logstash-aws-blog" 
  }
}

/* Security group for the elasticsearch nodes */
resource "aws_security_group" "elasticsearch" {
  name = "elasticsearch-aws-blog"
  description = "Elasticsearch Nodes"
  vpc_id = "${aws_vpc.aws-blog.id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "8301"
    to_port     = "8301"
    protocol    = "tcp"
    self        = true
    cidr_blocks = ["10.128.1.0/24"]
  }

  ingress {
    from_port = 9200
    to_port   = 9305
    protocol  = "tcp"
    security_groups = ["${aws_security_group.logstash.id}","${aws_security_group.kibana.id}","${aws_security_group.consul_servers.id}"]
    self = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags { 
    Name = "elasticsearch-aws-blog" 
  }
}
