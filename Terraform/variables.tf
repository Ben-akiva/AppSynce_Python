variable "region" {
  type    = string
  default = "eu-north-1"  # Default AWS region
}

variable "schema" {
  type    = string
  default = <<EOF
    type Query {
      exampleField(id: ID!): String
    }

    type Mutation {
      exampleMutation(id: ID!): String
    }
  EOF
}

variable "table_name" {
  type    = string
  default = "TestTable2"  # Default DynamoDB table name
}

variable "hash_key" {
  type    = string
  default = "username"  # Default hash key attribute
}

variable "range_key" {
  type    = string
  default = "email"  # Default range key attribute
}

variable "datasource_region" {
  type    = string
  default = "us-west-2"  # Default region for the DataSource
}

variable "query_request_template" {
  type    = string
  default = <<EOF
    {
      "version": "2018-05-29",
      "operation": "GetItem",
      "key": {
        "id": $util.toJson($ctx.args.id)
      }
    }
  EOF
}

variable "query_response_template" {
  type    = string
  default = <<EOF
    #if($ctx.result)
      $ctx.result.exampleField
    #else
      $util.error("Item not found")
    #end
  EOF
}

variable "mutation_request_template" {
  type    = string
  default = <<EOF
    {
      "version": "2018-05-29",
      "operation": "PutItem",
      "key": {
        "id": $util.toJson($ctx.args.id)
      },
      "attributeValues": {
        "exampleField": $util.toJson($ctx.args.exampleField)
      }
    }
  EOF
}

variable "mutation_response_template" {
  type    = string
  default = "\n    $ctx.result\n  "  # Default response mapping template for mutations
}

