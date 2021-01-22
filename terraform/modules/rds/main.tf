variable "location" {}
variable "security_group_egress" {}

provider "aws" {
  region = var.location
}

resource "aws_security_group" "allow_psql" {
  name        = "allow_psql"
  description = "allow from PSQL"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_psql"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "12.4"
  instance_class         = "db.t2.micro"
  name                   = "terraform"
  username               = "foo"
  password               = "foobarbaz" # remove hard-coded password
  skip_final_snapshot    = true
  publicly_accessible    = true
  vpc_security_group_ids = [
    aws_security_group.allow_psql.id,
    var.security_group_egress,
  ]
}


# export Terraform variable values to an Ansible var_file
resource "local_file" "tf_ansible_vars_file" {
  content = <<-DOC
    # Ansible vars_file containing variable values from Terraform.
    # Generated by Terraform mgmt configuration.

    rds_name: ${aws_db_instance.default.name}
    rds_host: ${aws_db_instance.default.endpoint}
    rds_user: ${aws_db_instance.default.username}
    rds_password: ${aws_db_instance.default.password}
    DOC
  filename = abspath("${path.module}../../../../ansible/roles/web-app/vars/main.yml")
}