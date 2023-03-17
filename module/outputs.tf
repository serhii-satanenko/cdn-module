output "cf_domain_name" {
  value       = try(aws_cloudfront_distribution.this[0].domain_name, "")
  description = "Domain name corresponding to the distribution"
}