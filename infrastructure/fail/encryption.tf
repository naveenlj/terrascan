/**
 * Template to validate encryption test
 */

variable "encryption" {
  description = "Set to false to fail boolen based tests"
  default     = "false"
}

resource "aws_alb_listener" "front_end" {
  port       = "80"
  protocol   = "http"
  ssl_policy = "ELBSecurityPolicy-2015-05"

  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"
}

resource "aws_ami" "example" {
  ebs_block_device {
    encrypted = "${var.encryption}"

    # Comment the line below to fail KMS test
    # kms_key_id = "1234"
  }
}

resource "aws_ami_copy" "example" {
  # Comment the line below to fail KMS test
  # kms_key_id = "1234"
  encrypted = "${var.encryption}"
}

resource "aws_api_gateway_domain_name" "example" {
  # Comment the lines below to fail certificate test  # certificate_name        = "example-api"  # certificate_body        = "${file("${path.module}/example.com/example.crt")}"  # certificate_chain       = "${file("${path.module}/example.com/ca.crt")}"  # certificate_private_key = "${file("${path.module}/example.com/example.key")}"
}

resource "aws_instance" "foo" {
  # This would fail the test
  ebs_block_device {
    encrypted = "${var.encryption}"
  }
}

resource "aws_cloudfront_distribution" "distribution" {
  origin {
    custom_origin_config {
      origin_protocol_policy = "http-only"
    }
  }

  default_cache_behavior {
    viewer_protocol_policy = "allow-all"
  }

  cache_behavior {
    viewer_protocol_policy = "allow-all"
  }
}

resource "aws_cloudtrail" "foo" {
  # Comment the line below to fail KMS test  # kms_key_id = "1234"
}

resource "aws_codebuild_project" "foo" {
  # Comment the line below to fail KMS test  # encryption_key = "1234"
}

resource "aws_codepipeline" "foo" {
  # Comment the line below to fail KMS test  # encryption_key = "1234"
}

resource "aws_db_instance" "default" {
  # Comment the line below to fail KMS test
  # kms_key_id = "1234"
  storage_encrypted = "${var.encryption}"
}

resource "aws_ebs_volume" "foo" {
  # Comment the line below to fail KMS test
  # kms_key_id = "1234"
  encrypted = "${var.encryption}"
}
