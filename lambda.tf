#Creates an AWS Lambda function named "my-lambda-function" 
#using the source code from the lambda_function directory. 
#It also sets the Node.js runtime, memory size, and timeout for the function. 
#The aws_lambda_permission resource grants permission for API Gateway to invoke the Lambda function.

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "lambda_function"
  output_path = "lambda_function.zip"
}

resource "aws_lambda_function" "my_lambda_function" {
  function_name = "my-lambda-function"
  handler       = "lambda_function.handler"
  runtime       = "nodejs14.x"
  memory_size   = 128
  timeout       = 10

  filename = data.archive_file.lambda_zip.output_path
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.my_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
}
