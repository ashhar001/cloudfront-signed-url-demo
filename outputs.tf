output "cloudfront_domain_name" {
  description = "CloudFront domain name"
  value       = aws_cloudfront_distribution.cloudfront_dist.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.cloudfront_dist.id
}

output "bucket_name" {

  description = "S3 Bucket Name"
  value       = aws_s3_bucket.demo_bucket.bucket_domain_name

}
