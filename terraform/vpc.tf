resource "aws_vpc" "aws-blog" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true
  tags {
    Name = "lunchtimetrains"
  }
}
/* Create an S3 Bucket for ELB Logs so we can process them in ELK */
resource "aws_s3_bucket" "aws-blog-elb-logs" {
    bucket = "aws-blog-elb-logs"
    force_destroy = true
    policy = <<POLICY
{
  "Id": "Policy1448596133132",
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1448596131182",
      "Action": [
        "s3:PutObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::aws-blog-elb-logs/*",
      "Principal": {
        "AWS": [
          "156460612806"
        ]
      }
    }
  ]
}
POLICY

    tags {
        Name = "Pockit ELB Logs"
    }
}

/* Setup and Configure CloudTrail for audit purposes */
resource "aws_cloudtrail" "aws-blog-cloudtrail" {
    name = "aws-blog-cloudtrail"
    s3_bucket_name = "${aws_s3_bucket.aws-blog-cloudtrail-logs.id}"
}

resource "aws_s3_bucket" "aws-blog-cloudtrail-logs" {
    bucket = "aws-blog-cloudtrail-logs"
    force_destroy = true
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::aws-blog-cloudtrail-logs"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::aws-blog-cloudtrail-logs/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}
