variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}
variable "payments_table_name" {
  description = "Name for the payments DynamoDB table"
  type        = string
  default     = "payments"
}

variable "invoices_table_name" {
  description = "Name for the invoices DynamoDB table"
  type        = string
  default     = "invoices"
}
