terraform {
  backend "s3" {
    bucket = "devopsoftheday"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}