variable "region" {
  description = "Región de AWS donde se creará la instancia"
  type        = string
  default     = "us-east-1"
}

variable "allowed_ingress_ports_loadbalancer" {
  description = "Puertos de entrada del grupo de seguridad loadbalancer"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "allowed_ingress_ports_nfs" {
  description = "Puertos de entrada del grupo de seguridad nfs"
  type        = list(number)
  default     = [22, 2049]
}

variable "allowed_ingress_ports_backend" {
  description = "Puertos de entrada del grupo de seguridad backend"
  type        = list(number)
  default     = [22, 3306]
}

variable "allowed_ingress_ports_frontend" {
  description = "Puertos de entrada del grupo de seguridad frontend"
  type        = list(number)
  default     = [22, 2049, 443, 80]
}

variable "sg_name_loadbalancer" {
  description = "Nombre del grupo de seguridad"
  type        = string
  default     = "sg_loadbalancer"
}

variable "sg_name_nfs" {
  description = "Nombre del grupo de seguridad"
  type        = string
  default     = "sg_nfs"
}

variable "sg_name_frontend" {
  description = "Nombre del grupo de seguridad"
  type        = string
  default     = "sg_frontend"
}

variable "sg_name_backend" {
  description = "Nombre del grupo de seguridad"
  type        = string
  default     = "sg_backend"
}

variable "sg_description" {
  description = "Descripción del grupo de seguridad"
  type        = string
  default     = "Grupo de seguridad para ejercicio terraform"
}

variable "ami_id" {
  description = "Identificador de la AMI"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0"
}

variable "instance_type" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Nombre de la clave pública"
  type        = string
  default     = "vockey"
}

variable "instance_name_backend" {
  description = "Nombre de la instancia"
  type        = string
  default     = "instancia_backend"
}

variable "instance_name_frontend" {
  description = "Nombre de la instancia"
  type        = string
  default     = "instancia_frontend"

}

variable "instance_name_frontend2" {
  description = "Nombre de la instancia"
  type        = string
  default     = "instancia_frontend2"

}

variable "instance_name_loadbalancer" {
  description = "Nombre de la instancia"
  type        = string
  default     = "instancia_loadbalancer"
}

variable "instance_name_nfs" {
  description = "Nombre de la instancia"
  type        = string
  default     = "instancia_nfs"
}

