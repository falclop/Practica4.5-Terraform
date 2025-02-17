# Mostramos la IP pública de la instancia
output "elastic_ip" {
  value = aws_eip.ip_elastica.public_ip
}

output "public_ip_nfs" {
  value = aws_instance.instancia_nfs.public_ip
}

output "public_ip_frontend" {
  value = aws_instance.instancia_frontend.public_ip
}

output "public_ip_frontend2" {
  value = aws_instance.instancia_frontend2.public_ip
}