#Using AWS as infrastructure
provider "aws" {
  access_key = "ACCESS_KEY_HERE"
  secret_key = "SECRET_ACCESS_KEY"
  region = "us-east-2"
}

#creating EC2 resource
#Instance types : https://aws.amazon.com/ec2/instance-types/
#ami id  : https://wiki.centos.org/Cloud/AWS#head-78d1e3a4e6ba5c5a3847750d88266916ffe69648
//resource "aws_instance" "EC2" {
//  ami = "ami-0d97ef13c06b05a19"
//  instance_type = "t2.micro"
//}

resource "aws_instance" "EC2" {
  ami = "ami-035734c938e7da7af"
  instance_type = "t2.micro"
}

# Create DynamoDb resource https://console.aws.amazon.com/iam/home?region=us-east-2#/users$new?step=final&accessKey&login&userNames=vivek_singh&passwordReset&passwordType=autogen
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "GameScores"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "UserId"
  range_key      = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "development"
  }
}