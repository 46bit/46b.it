resource "aws_s3_bucket" "miki" {
  bucket        = "miki-state"
  acl           = "private"
  force_destroy = "true"

  versioning {
    enabled = true
  }
}
