provider "aws" {
    region = "ap-south-1"
    shared_credentials_file = "C:/Users/pasha/.aws/credentials"
   
}

resource "aws_instance" "ec2_example" {

    ami = "ami-062df10d14676e201"  
    instance_type = "t2.micro" 
    key_name= "key-for-demo"  #ssh key name
    vpc_security_group_ids = [aws_security_group.main.id]

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"    # machine user
      private_key = file("C:/Users/pasha/Desktop/Terraform Learn/Terraform_EC2_SSH/key-for-demo") # private key location
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
  key_name   = "key-for-demo"  # ssh key name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUVhnNk4ns0UKClvC9VsO0XwGRmkcHb7cBncjFkXAXclaPcBhce/qQ0yljMOca6bIiG3ndSs2sthq0iIfbY7nCkuyjq+KYlys0lrWUb708MN9flRTCdmSLEJ2DqDuwx0vAedy2CsQ7575sqLlcu1p5zPlwH1IvaU/I2FQgeQXGIi2fdRgP0pcE3hXeC9/uud1o5xqaFTRzxJ0aMGIGEya+ez7t1oO4qb9aYOFJfxViFD1ORHKqKX6YdxCF5bCpgXONXxO3m/jyyLlX36Ud8qsmZojZryWXppGWWXaYIon/ogcYsk8Na75cXvgaAWgafwaYzZ0gqHAx1VL/S88teJkn pasha@DESKTOP-RNNU455"
}