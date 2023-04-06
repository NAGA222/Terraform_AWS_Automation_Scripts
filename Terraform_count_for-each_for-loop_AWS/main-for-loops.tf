provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "C:/Users/pasha/.aws/credentials"
}


resource "aws_instance" "ec2_local_sample" {
  ami           = "ami-08df646e18b182346"
  instance_type = "t2.micro"
  count = 2
  tags = {
    Name = "staging- Terraform EC2"       
  }
} 
/* count loop 
resource "aws_iam_user" "example" {
  count = length(var.user_names)
  name  = var.user_names[count.index]   
}

variable "user_names" {
  description = "IAM usernames"
  type        = list(string) 
  default = [ "user1","user2","user3" ]
}*/

#for each loop
/*resource "aws_iam_user" "for_each_loop" {
  for_each = var.user_names
  name=each.value
}

variable "user_names" {
  description = "IAM usernames"
  type        = set(string)               #only set and map we need to use
  default = [ "user1","user2","user3" ]
}*/

#for loop
output "iam_users" {
  value = [for name in var.user_names:name]
}
variable "user_names" {
  description = "IAM usernames"
  type        = set(string)               #only set and map we need to use
  default = [ "user1","user2","user3" ]
}