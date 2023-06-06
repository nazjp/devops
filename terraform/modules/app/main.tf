variable "project" {
  type = string
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}

locals {
  name_prefix = "${var.project}-${var.environment}"
}

resource "aws_s3_bucket" "app" {
  bucket = "${local.name_prefix}-app-${data.aws_caller_identity.current.account_id}"

  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_s3_bucket_versioning" "app" {
  bucket = aws_s3_bucket.app.id

  versioning_configuration {
    status = var.environment == "prod" ? "Enabled" : "Suspended"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app" {
  bucket = aws_s3_bucket.app.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "app" {
  bucket = aws_s3_bucket.app.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_caller_identity" "current" {}

output "bucket_name" {
  value = aws_s3_bucket.app.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.app.arn
}
