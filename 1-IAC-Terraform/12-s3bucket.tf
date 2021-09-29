resource "aws_s3_bucket" "appBucket" {
  provider             = aws.region-master
  bucket = "appBucketDevopsofTheDay"
  acl    = "private"

  tags = {
    environment                                = var.env
    deploy                                     = var.deploy-name
    "kubernetes.io/cluster/${var.deploy-name}" = "shared"
  }
}