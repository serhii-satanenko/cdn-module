
resource "aws_s3_bucket" "this" {
  count = var.create_s3_private_buckets != "" && var.module_enabled == true ? length(var.create_s3_private_buckets) : 0
  bucket = var.create_s3_private_buckets[count.index]

  tags = {
    Name = var.create_s3_private_buckets[count.index]
  }
}

resource "aws_s3_bucket_acl" "this" {
  count = var.create_s3_private_buckets != "" && var.module_enabled == true ? length(var.create_s3_private_buckets) : 0
  bucket = aws_s3_bucket.this[count.index].id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create_s3_private_buckets != "" && var.module_enabled == true ? length(var.create_s3_private_buckets) : 0
  bucket = aws_s3_bucket.this[count.index].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_iam_policy_document" "this" {
  count = var.create_s3_private_buckets != "" && var.module_enabled == true ? length(var.create_s3_private_buckets) : 0
  # for_each = aws_s3_bucket.this

  version = "2008-10-17"
  statement {
    sid = "1"
    effect = "Allow"
    actions = var.action_policy_list
    resources = ["${aws_s3_bucket.this[count.index].arn}/*"]
    principals {
      type = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.s3_origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = var.create_s3_private_buckets != "" && var.module_enabled == true ? length(var.create_s3_private_buckets) : 0

  bucket = aws_s3_bucket.this[count.index].id
  policy = data.aws_iam_policy_document.this[count.index].json
}