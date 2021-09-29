resource "aws_db_instance" "appRds" {
  provider             = aws.region-master
  allocated_storage   = 10
  engine              = "postgresql"
  engine_version      = "5.7"
  instance_class      = "db.t3.micro"
  name                = "djangodb"
  username            = "djangouser"
  password            = "djangoSup3rS3cr3t"
  skip_final_snapshot = true
}