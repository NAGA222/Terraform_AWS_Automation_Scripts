#defining AWS Provider
provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "C:/Users/pasha/.aws/credentials"
}

#defining Ec2 resource
resource "aws_instance" "ec2_sample" {
  ami           = "ami-08df646e18b182346"
  instance_type = var.instance_type      #accessing string variable
  count = var.instance_count             #accessing number variable
  associate_public_ip_address = var.enable_public_ip       #accessing bool varible
  tags = var.project_environment         #accessing map variable
} 

resource "aws_iam_user" "example" {       #accessing list variable
  count = length(var.user_names)
  name  = var.user_names[count.index]
}


#defining string variable
variable "instance_type" {
    description = "ec2 instance type"
    type = string
    default = "t2.micro"
}

#defining number variable
variable "instance_count" {
    description = "instance count"
    type = number
    default = 1
}

#defining bool variable
variable "enable_public_ip" {
    description = "associated public ip"
    type = bool
    default = true
    
}

#defining Map variable 
variable "project_environment" {
  description = "project name and environment"
  type        = map(string)
  default     = {
    project     = "project-alpha",
    environment = "dev"
    Name = "EC2_Terraform_variable demo"
  }
}

#definiing list variable
variable "user_names" {
  description = "IAM usernames"
  type        = list(string)
  default     = ["user1", "user2", "user3s"]
}