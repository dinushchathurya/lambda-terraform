# Configure the AWS provider
provider "aws" {
  	region = var.region
}

# Create the Lambda function
resource "aws_lambda_function" "example" {
	function_name    = var.lambda_function_name
	handler          = var.lambda_function_handler
	runtime          = var.lambda_function_runtime
	timeout          = var.lambda_function_timeout
	memory_size      = var.lambda_function_memory_size
	environment      = {
		variables = var.lambda_function_environment_variables
	}
	source_code_hash = filebase64("lambda.zip")

	# Attach the execution role to the Lambda function
	role = aws_iam_role.lambda.arn
}

# Create the IAM role for the Lambda function
resource "aws_iam_role" "lambda" {
	name = "lambda_execution_role"
	assume_role_policy = jsonencode({
		Version = "2012-10-17"
		Statement = [{
			Action = "sts:AssumeRole"
			Effect = "Allow"
			Principal = {
				Service = "lambda.amazonaws.com"
			}
		}]
	})
}

# Attach a policy to the IAM role that allows the Lambda function to write CloudWatch Logs
resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_logs" {
	policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
	role       = aws_iam_role.lambda.name
}
