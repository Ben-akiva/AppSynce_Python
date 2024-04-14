provider "aws" {
  region = var.region  # Set the AWS region using the region variable
}

# IAM Role for AWS AppSync service
resource "aws_iam_role" "appsync_role" {
  name               = "appsync-service-role"
  assume_role_policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "appsync.amazonaws.com"
      },
      Action    = "sts:AssumeRole"
    }]
  })
}

# AWS AppSync GraphQL API
resource "aws_appsync_graphql_api" "example" {
  name               = "My AppSync API2"
  authentication_type = "API_KEY"

  schema = var.schema  # Set the GraphQL schema using the schema variable
}

# DynamoDB table for data storage
resource "aws_dynamodb_table" "example" {
  name         = var.table_name  # Set the table name using the table_name variable
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = var.hash_key     # Set the hash key attribute using the hash_key variable
  range_key    = var.range_key    # Set the range key attribute using the range_key variable

  attribute {
    name = "username"
    type = "S"
  }

  attribute {
    name = "email"
    type = "S"
  }
}

# AppSync DataSource to connect to DynamoDB table
resource "aws_appsync_datasource" "example" {
  name             = "exampleDataSource"
  api_id           = aws_appsync_graphql_api.example.id
  type             = "AMAZON_DYNAMODB"
  service_role_arn = aws_iam_role.appsync_role.arn

  dynamodb_config {
    table_name = aws_dynamodb_table.example.name
    region     = var.datasource_region  # Set the region for the DataSource using the datasource_region variable
  }
}

# Resolver for GraphQL Query type
resource "aws_appsync_resolver" "query_resolver" {
  api_id      = aws_appsync_graphql_api.example.id
  type        = "Query"
  field       = "exampleField"
  data_source = aws_appsync_datasource.example.name

  request_template = var.query_request_template  # Set the request mapping template using the query_request_template variable
  response_template = var.query_response_template  # Set the response mapping template using the query_response_template variable
}

# Resolver for GraphQL Mutation type
resource "aws_appsync_resolver" "mutation_resolver" {
  api_id      = aws_appsync_graphql_api.example.id
  type        = "Mutation"
  field       = "exampleMutation"
  data_source = aws_appsync_datasource.example.name

  request_template = var.mutation_request_template  # Set the request mapping template using the mutation_request_template variable
  response_template = var.mutation_response_template  # Set the response mapping template using the mutation_response_template variable
}
