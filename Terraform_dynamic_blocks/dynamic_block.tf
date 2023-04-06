/*provider "aws" {
   region = "ap-south-1"
   shared_credentials_file = "C:/Users/pasha/.aws/credentials"
   
}
*/
resource "aws_instance" "ec2_example" {

    ami = "ami-068257025f72f470d"  
    instance_type = "t2.micro" 
    vpc_security_group_ids = [aws_security_group.main.id]
}
locals {
   ingress_rules = [{
      port        = 443
      description = "Ingress rules for port 443"
   },
   {
      port        = 80
      description = "Ingree rules for port 80"
   }]
}

resource "aws_security_group" "main" {
   name   = "resource_with_dynamic_block"
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

   dynamic "ingress" {
      for_each = local.ingress_rules

      content {
         description = ingress.value.description
         from_port   = ingress.value.port
         to_port     = ingress.value.port
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
      }
   }

}