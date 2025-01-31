// This block defines an AWS CloudFront Origin Access Control (OAC) resource named "oac".
// The OAC is used to control access to the origin, which in this case is an S3 bucket.
// - 'name' specifies the name of the OAC.
// - 'description' provides a brief description of the OAC's purpose.
// - 'origin_access_control_origin_type' indicates the type of origin, set to "s3" for an S3 bucket.
// - 'signing_behavior' is set to "always", meaning requests to the origin are always signed.
// - 'signing_protocol' specifies the signing protocol, set to "sigv4".

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "my-oac"
  description                       = "Origin Access Control for S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

// This block defines an AWS CloudFront Distribution resource named "cloudfront_dist".
// The distribution is used to deliver content with low latency and high transfer speeds.
// - 'enabled' is set to true, enabling the distribution.
// - 'default_root_object' specifies the default object to serve, set to "index.html".

resource "aws_cloudfront_distribution" "cloudfront_dist" {
  enabled             = true
  default_root_object = "index.html" // Serve index.html by default

  // The 'origin' block specifies the origin server for the distribution.
  // - 'domain_name' is set to the regional domain name of the S3 bucket.
  // - 'origin_id' is a unique identifier for the origin, constructed using the S3 bucket name.
  // - 'origin_access_control_id' links the origin to the previously defined OAC.

  origin {
    domain_name              = aws_s3_bucket.demo_bucket.bucket_regional_domain_name
    origin_id                = "S3-${aws_s3_bucket.demo_bucket.bucket}"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  // The 'default_cache_behavior' block defines how CloudFront caches content.
  // - 'target_origin_id' links the cache behavior to the specified origin.
  // - 'viewer_protocol_policy' is set to "redirect-to-https", ensuring HTTP requests are redirected to HTTPS.
  // - 'allowed_methods' lists the HTTP methods allowed, which are "GET" and "HEAD".
  // - 'cached_methods' lists the methods that are cached, also "GET" and "HEAD".
  // - 'forwarded_values' configures how query strings and cookies are handled, with query strings disabled and no cookies forwarded.

  default_cache_behavior {
    target_origin_id       = "S3-${aws_s3_bucket.demo_bucket.bucket}"
    viewer_protocol_policy = "redirect-to-https" // Redirect HTTP to HTTPS

    allowed_methods = [
      "GET",
      "HEAD"
    ]
    cached_methods = [
      "GET",
      "HEAD"
    ]

    // Configure how CloudFront handles query strings, cookies, etc.
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  // The 'restrictions' block defines any geographic restrictions on content delivery.
  // - 'geo_restriction' is set to "none", meaning there are no geographic restrictions.

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  // 'comment' provides a description of the distribution's purpose.

  comment = "CloudFront distribution for static website"

  // The 'viewer_certificate' block specifies the SSL/TLS certificate for the distribution.
  // - 'cloudfront_default_certificate' is set to true, using the default CloudFront certificate.

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
