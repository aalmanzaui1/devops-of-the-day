
resource "aws_db_subnet_group" "appRds" {
  provider            = aws.region-master
  name       = "apprds"
  subnet_ids = [aws_subnet.subnet-private-3.id,aws_subnet.subnet-private-4.id]

}
resource "aws_db_instance" "appRds" {
  provider            = aws.region-master
  allocated_storage   = 10
  engine              = "postgres"
  engine_version      = "13.1"
  instance_class      = "db.t3.micro"
  name                = "djangodb"
  username            = "djangouser"
  password            = "djangoSup3rS3cr3t"
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.appRds.name
}