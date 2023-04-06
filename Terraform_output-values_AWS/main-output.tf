provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "C:/Users/pasha/.aws/credentials"
}


resource "aws_instance" "ec2_local_sample" {
  ami           = "ami-08df646e18b182346"
  instance_type = "t2.micro"
 
  tags = {
    Name = "staging- Terraform EC2"       
  }
} 

output "sample_output" {                  #local output
  value = "sample demo output value"
}

