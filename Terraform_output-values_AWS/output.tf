output "my_console_output" {             #global output
  value = aws_instance.ec2_local_sample.public_ip     #assigning console output
  #sensitive = true    securing sentive information
}