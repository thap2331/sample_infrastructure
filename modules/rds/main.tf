
#Get user as pass from aws secrets manager
# locals {
#     db_creds = jsonencode(
#         data.aws_secretsmanager_secret_version.creds.secret_string
#     )
# }

resource "aws_db_instance" "postgres" {
  allocated_storage         = 10
  db_name                   = "cms_pg_db"
  engine                    = "postgres"
  engine_version            = "14.2"
  instance_class            = "db.t3.micro"
  username                  = "foo" #local.db_creds.user
  password                  = "foobarbaz" #local.db_creds.password
  parameter_group_name      = "default.postgres14"
  skip_final_snapshot       = true
  vpc_security_group_ids    = var.vpc_security_group_ids 

  tags = {
    name = "cms_db"
  }
}