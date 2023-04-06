variable "ami_id" {
    default = "ami-068257025f72f470d"
    type = string
    description = "AMI id of ubuntu"
}

variable "instance_type" {
    default = "t2.micro"
    type = string
    description = "instance computing type"
}