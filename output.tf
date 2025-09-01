output "backend_public_ip" {
  value = aws_instance.backend.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.mydb.address
}
