variable "project" {
  description = "Project name used in resource naming"
  type        = string
}

variable "environment" {
  description = "Deployment environment (dev, stg, prod)"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-northeast-1"
}
