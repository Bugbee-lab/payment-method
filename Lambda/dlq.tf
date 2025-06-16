resource "aws_sqs_queue" "payment_result_dlq" {
  name = "payment-result-dlq"

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
  })
}
