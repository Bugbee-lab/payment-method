# Rule for PaymentRequested → payment_request_lambda
resource "aws_cloudwatch_event_rule" "payment_requested_rule" {
  name = "payment-requested-rule"

  event_pattern = jsonencode({
    source = ["payment-app.payment"],
    "detail-type" = ["PaymentRequested"]
  })
}

resource "aws_cloudwatch_event_target" "payment_requested_target" {
  rule      = aws_cloudwatch_event_rule.payment_requested_rule.name
  target_id = "paymentRequestLambda"
  arn       = aws_lambda_function.payment_request_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge_payment_requested" {
  statement_id  = "AllowExecutionFromEventBridgePaymentRequested"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.payment_request_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.payment_requested_rule.arn
}

# Rule for PaymentSucceeded / PaymentFailed → payment_result_lambda
resource "aws_cloudwatch_event_rule" "payment_result_rule" {
  name = "payment-result-rule"

  event_pattern = jsonencode({
    source = ["payment-app.payment"],
    "detail-type" = ["PaymentSucceeded", "PaymentFailed"]
  })
}

resource "aws_cloudwatch_event_target" "payment_result_target" {
  rule      = aws_cloudwatch_event_rule.payment_result_rule.name
  target_id = "paymentResultLambda"
  arn       = aws_lambda_function.payment_result_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge_payment_result" {
  statement_id  = "AllowExecutionFromEventBridgePaymentResult"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.payment_result_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.payment_result_rule.arn
}

# Rule for InvoiceCreated → invoice_lambda
resource "aws_cloudwatch_event_rule" "invoice_created_rule" {
  name = "invoice-created-rule"

  event_pattern = jsonencode({
    source = ["payment-app.invoice"],
    "detail-type" = ["InvoiceCreated"]
  })
}

resource "aws_cloudwatch_event_target" "invoice_created_target" {
  rule      = aws_cloudwatch_event_rule.invoice_created_rule.name
  target_id = "invoiceLambda"
  arn       = aws_lambda_function.invoice_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge_invoice" {
  statement_id  = "AllowExecutionFromEventBridgeInvoice"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.invoice_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.invoice_created_rule.arn
}
