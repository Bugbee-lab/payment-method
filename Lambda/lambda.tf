# Payment Request Lambda
resource "aws_lambda_function" "payment_request_lambda" {
  function_name = "payment-request-lambda"
  filename      = "${path.module}/lambda_functions/payment_request.zip"
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      PAYMENTS_TABLE = aws_dynamodb_table.payments_table.name
    }
  }

  source_code_hash = filebase64sha256("${path.module}/lambda_functions/payment_request.zip")
}

# Payment Result Lambda
resource "aws_lambda_function" "payment_result_lambda" {
  function_name = "payment-result-lambda"
  filename      = "${path.module}/lambda_functions/payment_result.zip"
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      PAYMENTS_TABLE = aws_dynamodb_table.payments_table.name,
      INVOICES_TABLE = aws_dynamodb_table.invoices_table.name
    }
  }
  #DLQ attachment
    dead_letter_config {
      target_arn = aws_sqs_queue.payment_result_dlq.arn
  }

  source_code_hash = filebase64sha256("${path.module}/lambda_functions/payment_result.zip")
}
  

# Invoice Lambda
resource "aws_lambda_function" "invoice_lambda" {
  function_name = "invoice-lambda"
  filename      = "${path.module}/lambda_functions/invoice.zip"
  handler       = "handler.lambda_handler"
  runtime       = "python3.11"
  role          = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      INVOICES_TABLE = aws_dynamodb_table.invoices_table.name
    }
  }

  source_code_hash = filebase64sha256("${path.module}/lambda_functions/invoice.zip")
}

