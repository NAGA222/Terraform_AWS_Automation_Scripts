provider "aws" {
   region = "ap-south-1"
   shared_credentials_file = "C:/Users/pasha/.aws/credentials"
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-068257025f72f470d"  
    instance_type = "t2.micro" 
    key_name= "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "file" {
    source      = "C:/Users/pasha/Desktop/Devops.txt"
    destination = "/home/ubuntu/test-file.txt"
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("C:/Users/pasha/Desktop/Terraform/aws_key")
      timeout     = "4m"
   }
}

resource "aws_security_group" "main" {
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
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9XZ9juQIn+CTu2pz1R76cwZRvfH6j7t0xqD+09UArJHfwPKKWC6J0iTbPDN0FQwyP4lI4bppZd3o4BCo/45M8EIFMmVMUG5jBEok5s/iozotKribxpTVpF5BFUg9SyLRpZ69cQeio2q6PGCXKctbD28PHVFZUyZKsMDy/QOSq8TdddBq0gJCMejmK/qT1MBwu15zbZUyQcMRlwdS6VK7dUpNHp8fRY2rZJBMiAGguGg2UYQPeMS0f9mJCrzBwP2k5v0FHdFw+fWuxBazDK2cEHJuMohFH+jBSdACb9GlJ5vTtBry6lnGQVxMXD8Q98TCP36mcdfBg5Q0k+lGZWE2L pasha@DESKTOP-RNNU455"
}