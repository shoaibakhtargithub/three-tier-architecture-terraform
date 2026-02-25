provider "aws" {
  region = "eu-north-1"
}


# 1 Create S3 bucket
#  Create S3 Bucket

resource "aws_s3_bucket" "frontend" {
  bucket = "my-frontend-bucket-shoaib-2026-xyz"
}

# 2 Enable static website hosting

#  Disable Block Public Access
resource "aws_s3_bucket_public_access_block" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

#  Enable Static Website Hosting
resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}


#  Attach Public Read Policy
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.frontend.id

  depends_on = [
    aws_s3_bucket_public_access_block.frontend
  ]

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = "*",
        Action = ["s3:GetObject"],
        Resource = ["${aws_s3_bucket.frontend.arn}/*"]
      }
    ]
  })
}

# dist folder add
#  Upload All Files From dist/ Folder
resource "aws_s3_object" "frontend_files" {
  for_each = fileset("${path.module}/dist", "**/*")

  bucket = aws_s3_bucket.frontend.id
  key    = each.value
  source = "${path.module}/dist/${each.value}"
  etag   = filemd5("${path.module}/dist/${each.value}")

  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      png  = "image/png"
      jpg  = "image/jpeg"
      svg  = "image/svg+xml"
    },
    split(".", each.value)[length(split(".", each.value)) - 1],
    "application/octet-stream"
  )
}
