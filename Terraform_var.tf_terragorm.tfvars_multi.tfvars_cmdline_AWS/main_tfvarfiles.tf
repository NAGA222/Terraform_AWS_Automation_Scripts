provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "C:/Users/pasha/.aws/credentials"
}

resource "aws_instance" "ec2_sample" {
  ami           = "ami-08df646e18b182346"
  instance_type = var.instance_type      #accessing string variable from variable.tf file anf .tfvars files
  tags = {
    Name = var.environment_name
  }
} 

#run cmd terraform plan -var-file="stage.tfvars" for staging environment
#run cmd terraform plan -var-file="production.tfvars" for production environment
#run cmd custom input -- terraform plan -var="instance_type=t2.micro"