# Configuramos el proveedor de AWS
provider "aws" {
  region = var.region
}

# Creamos los grupos de seguridad
resource "aws_security_group" "grupo_seguridad_lb" {
  name        = var.sg_name_loadbalancer
  description = var.sg_description
}

resource "aws_security_group" "grupo_seguridad_nfs" {
  name        = var.sg_name_nfs
  description = var.sg_description
}

resource "aws_security_group" "grupo_seguridad_frontend" {
  name        = var.sg_name_frontend
  description = var.sg_description
}

resource "aws_security_group" "grupo_seguridad_backend" {
  name        = var.sg_name_backend
  description = var.sg_description
}

# Creamos las reglas de entrada del grupo de seguridad
resource "aws_security_group_rule" "ingress_load_balancer" {
  security_group_id = aws_security_group.grupo_seguridad_lb.id
  type              = "ingress"
  count             = length(var.allowed_ingress_ports_loadbalancer)
  from_port         = var.allowed_ingress_ports_loadbalancer[count.index]
  to_port           = var.allowed_ingress_ports_loadbalancer[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_nfs" {
  security_group_id = aws_security_group.grupo_seguridad_nfs.id
  type              = "ingress"
  count             = length(var.allowed_ingress_ports_nfs)
  from_port         = var.allowed_ingress_ports_nfs[count.index]
  to_port           = var.allowed_ingress_ports_nfs[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_frontend" {
  security_group_id = aws_security_group.grupo_seguridad_frontend.id
  type              = "ingress"
  count             = length(var.allowed_ingress_ports_frontend)
  from_port         = var.allowed_ingress_ports_frontend[count.index]
  to_port           = var.allowed_ingress_ports_frontend[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress_backend" {
  security_group_id = aws_security_group.grupo_seguridad_backend.id
  type              = "ingress"
  count             = length(var.allowed_ingress_ports_backend)
  from_port         = var.allowed_ingress_ports_backend[count.index]
  to_port           = var.allowed_ingress_ports_backend[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Creamos las reglas de salida del grupo de seguridad
# Para ello usamos un bucle for_each para recorrer los grupos de seguridad
resource "aws_security_group_rule" "egress_all" {
  for_each         = {
    lb = aws_security_group.grupo_seguridad_lb.id,
    nfs = aws_security_group.grupo_seguridad_nfs.id,
    frontend = aws_security_group.grupo_seguridad_frontend.id,
    backend = aws_security_group.grupo_seguridad_backend.id
  }
  security_group_id = each.value
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

# Creamos las instancias EC2
resource "aws_instance" "instancia_loadbalancer" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.grupo_seguridad_lb.name]

  tags = {
    Name = var.instance_name_loadbalancer
  }
}

resource "aws_instance" "instancia_nfs" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.grupo_seguridad_nfs.name]
  tags = {
    Name = var.instance_name_nfs
  }
}

resource "aws_instance" "instancia_frontend" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.grupo_seguridad_frontend.name]
  tags = {
    Name = var.instance_name_frontend
  }
}

resource "aws_instance" "instancia_frontend2" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.grupo_seguridad_frontend.name]
  tags = {
    Name = var.instance_name_frontend2
  }
}

resource "aws_instance" "instancia_backend" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = [aws_security_group.grupo_seguridad_backend.name]
  tags = {
    Name = var.instance_name_backend
  }
}

# Creamos una IP elástica y la asociamos a la instancia
resource "aws_eip" "ip_elastica" {
  instance = aws_instance.instancia_loadbalancer.id
}