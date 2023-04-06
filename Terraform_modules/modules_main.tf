provider "aws" {
    region = var.region_value
    shared_credentials_file = "C:/Users/pasha/.aws/credentials"
}
module "Naga-webserver-1" {
  source = ".//module-1"
}

module "Naga-webserver-2" {
  source = ".//module-2"
}
