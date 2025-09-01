
provider "aws" {
  region = "us-east-1"
}

# 1. Create S3 bucket
resource "aws_s3_bucket" "frontend" {
  bucket = "my-frontend-bucket-12345"
}

# 2. Enable static website hosting
resource "aws_s3_bucket_website_configuration" "frontend" {
  bucket = aws_s3_bucket.frontend.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# 3. Allow public read (⚠️ for testing only, prod should use CloudFront + OAC)
resource "aws_s3_bucket_policy" "public_read" {
  bucket = aws_s3_bucket.frontend.id

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

# 4. Upload dist/ folder files
resource "aws_s3_object" "frontend_files" {
  for_each = fileset("${path.module}/dist", "**/*") # or ./build if React CRA

  bucket       = aws_s3_bucket.frontend.id
  key          = each.value
  source       = "${path.module}/dist/${each.value}"
  etag         = filemd5("${path.module}/dist/${each.value}")
  content_type = lookup(
    {
      html = "text/html",
      css  = "text/css",
      js   = "application/javascript",
      png  = "image/png",
      jpg  = "image/jpeg",
      svg  = "image/svg+xml"
    },
    split(".", each.value)[length(split(".", each.value)) - 1],
    "application/octet-stream"
  )
}
