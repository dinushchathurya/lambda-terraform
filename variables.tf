variable "region" {
  type = string
}

variable "lambda_function_name" {
  type = string
}

variable "lambda_function_handler" {
  type = string
}

variable "lambda_function_runtime" {
  type = string
}

variable "lambda_function_timeout" {
  type    = number
  default = 10
}

variable "lambda_function_memory_size" {
  type    = number
  default = 128
}

variable "lambda_function_environment_variables" {
  type    = map(string)
  default = {}
}
