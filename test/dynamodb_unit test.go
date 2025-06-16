package test

import (
  "testing"
  "strings"

  "github.com/stretchr/testify/assert"
  "github.com/gruntwork-io/terratest/modules/aws"
  "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestPaymentResultLambda(t *testing.T) {
  t.Parallel()

  terraformOptions := &terraform.Options{
    TerraformDir: "../", // Adjust if needed
  }

  defer terraform.Destroy(t, terraformOptions)
  terraform.InitAndApply(t, terraformOptions)

  region := terraform.Output(t, terraformOptions, "region")
  lambdaName := terraform.Output(t, terraformOptions, "payment_result_lambda_name")
  dlqArn := terraform.Output(t, terraformOptions, "payment_result_dlq_arn")
  tableName := terraform.Output(t, terraformOptions, "payments_table_name")

  lambda := aws.GetLambdaFunction(t, region, lambdaName)

  // ✅ Check Lambda handler is correctly set
  assert.True(t, strings.Contains(*lambda.Handler, "handler.lambda_handler"))

  // ✅ Check environment variables include payments table
  assert.Equal(t, tableName, *lambda.Environment.Variables["PAYMENTS_TABLE"])

  // ✅ DLQ ARN check (attached to Lambda)
  assert.NotNil(t, lambda.DeadLetterConfig)
  assert.Equal(t, dlqArn, *lambda.DeadLetterConfig.TargetArn)
}
