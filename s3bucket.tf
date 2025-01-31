
// This block defines an AWS S3 bucket resource named "demo_bucket".
// The 'bucket' attribute is set to the value of the variable 'bucket_name'.
resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name
}

// This block defines a public access block configuration for the S3 bucket.
// It allows public access by setting all attributes to false.
resource "aws_s3_bucket_public_access_block" "demo_bucket_pab" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = false // Do not block public ACLs
  block_public_policy     = false // Do not block public bucket policies
  ignore_public_acls      = false // Do not ignore public ACLs
  restrict_public_buckets = false // Do not restrict public bucket access
}

// This block creates an IAM policy document for the S3 bucket.
// It allows public read access to all objects in the bucket.
data "aws_iam_policy_document" "demo_bucket_policy_doc" {
  statement {
    sid    = "PublicReadGetObject"
    effect = "Allow"
    principals {
      type        = "*"   // Applies to all principals
      identifiers = ["*"] // Applies to all identifiers
    }
    actions   = ["s3:GetObject"]                       // Allow the GetObject action
    resources = ["${aws_s3_bucket.demo_bucket.arn}/*"] // Applies to all objects in the bucket
  }
}

// This block applies the IAM policy document to the S3 bucket.
// It uses the policy document defined above to set the bucket policy.
resource "aws_s3_bucket_policy" "demo_bucket_policy" {
  bucket = aws_s3_bucket.demo_bucket.id
  policy = data.aws_iam_policy_document.demo_bucket_policy_doc.json
}

// This block uploads an HTML file to the S3 bucket.
// The file is named "index.html" and is stored in the specified path.
resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.demo_bucket.id
  key          = "index.html"                                           // The key (name) of the object in the bucket
  source       = "${path.module}/my-static-website/index.html"          // Path to the source file
  content_type = "text/html"                                            // MIME type of the file
  etag         = filemd5("${path.module}/my-static-website/index.html") // ETag for the file
}

// This block uploads a CSS file to the S3 bucket.
// The file is named "style.css" and is stored in the specified path.
resource "aws_s3_object" "style_css" {
  bucket       = aws_s3_bucket.demo_bucket.id
  key          = "style.css"                                           // The key (name) of the object in the bucket
  source       = "${path.module}/my-static-website/style.css"          // Path to the source file
  content_type = "text/css"                                            // MIME type of the file
  etag         = filemd5("${path.module}/my-static-website/style.css") // ETag for the file
}

// This block uploads a JavaScript file to the S3 bucket.
// The file is named "script.js" and is stored in the specified path.
resource "aws_s3_object" "script_js" {
  bucket       = aws_s3_bucket.demo_bucket.id
  key          = "script.js"                                           // The key (name) of the object in the bucket
  source       = "${path.module}/my-static-website/script.js"          // Path to the source file
  content_type = "application/javascript"                              // MIME type of the file
  etag         = filemd5("${path.module}/my-static-website/script.js") // ETag for the file
}
