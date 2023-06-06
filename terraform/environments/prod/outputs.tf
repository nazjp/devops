output "app_bucket_name" {
  description = "Name of the application storage bucket"
  value       = module.app.bucket_name
}

output "app_bucket_arn" {
  description = "ARN of the application storage bucket"
  value       = module.app.bucket_arn
}
