provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "C:/Users/pasha/.aws/credentials"
}

variable location {
  description = "Location of server"
  type        = string
  default     = "Mumbai"
}

variable server_name {
  description = "Name of server"
  type        = string
  default     = "Staging-app-server"
}

#defining locals
locals {
    staging_env ="staging"
    server_details = "${var.location}-${var.server_name}"  #combining variales with locals
}

resource "aws_vpc" "staging-vpc" {
cidr_block = "10.5.0.0/16"

tags = {
  Name = "${local.staging_env}-vpc-tag"    #accessing locals
}
}

resource "aws_subnet" "staging-subnet" {
    vpc_id = aws_vpc.staging-vpc.id
    cidr_block = "10.5.0.0/16"
    
    tags = {
        Name = "${local.staging_env}-subnet-tag" #accessing locals
    }
}
  

resource "aws_instance" "ec2_local_sample" {
  ami           = "ami-08df646e18b182346"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.staging-subnet.id

  tags = {
    Name = "${local.staging_env} - Terraform EC2"    #accessing locals
    Server = "${local.server_details}"               #accessing locals with variables combination. 
  }
} 
