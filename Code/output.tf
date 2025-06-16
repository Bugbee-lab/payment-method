output "payments_table_name" {
  value = aws_dynamodb_table.payments_table.name
}

output "invoices_table_name" {
  value = aws_dynamodb_table.invoices_table.name
}
