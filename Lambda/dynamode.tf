resource "aws_dynamodb_table" "payments_table" {
  name           = "var.PaymentsTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "paymentId"

  attribute {
    name = "paymentId"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Name        = "var.PaymentsTable"
  }
}

resource "aws_dynamodb_table" "invoices_table" {
  name           = "InvoicesTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "invoiceId"

  attribute {
    name = "invoiceId"
    type = "S"
  }

  tags = {
    Environment = var.environment
    Name        = "InvoicesTable"
  }
}
