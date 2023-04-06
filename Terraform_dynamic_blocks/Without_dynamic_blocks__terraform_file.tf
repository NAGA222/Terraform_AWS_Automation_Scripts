provider "aws" {
   region = "ap-south-1"
   shared_credentials_file = "C:/Users/pasha/.aws/credentials"
   
}

resource "aws_instance" "ec2_example1" {

    ami = "ami-068257025f72f470d"  
    instance_type = "t2.micro" 
    vpc_security_group_ids = [aws_security_group.main1.id]
}

resource "aws_security_group" "main1" {
   name   = "resource_without_dynamic_block"
   #vpc_id = data.aws_vpc.main.id

    egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]

   ingress {
      description = "ingress_rule_1"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }
   
   ingress {
      description = "ingress_rule_2"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
      Name = "AWS security group non-dynamic block"
   }
}

