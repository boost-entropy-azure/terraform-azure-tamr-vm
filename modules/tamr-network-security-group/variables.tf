variable "resource_group_name" {
  description = "Name of resource group"
  type        = string
}

variable "location" {
  description = "Location"
  type        = string
}

variable "vm_name" {
  description = "Name of VM on which Tamr is installed"
  type        = string
  default     = "tamr-vm"
}

variable "tamr_port" {
  description = "Port hosting Tamr UI and API access"
  default     = 9100
  type        = number
}

variable "enable_tamr_port" {
  description = "Whether or not to enable Tamr API access"
  default     = true
  type        = bool
}

variable "kibana_port" {
  description = "Port hosting Kibana access"
  default     = 5601
  type        = number
}

variable "grafana_port" {
  description = "Port hosting Grafana access"
  default     = 31101
  type        = number
}

variable "elasticsearch_port" {
  description = "Port hosting Elasticsearch access"
  default     = 9200
  type        = number
}

variable "enable_kibana_port" {
  description = "Whether or not to enable Kibana"
  default     = true
  type        = bool
}

variable "enable_grafana_port" {
  description = "Whether or not to enable Grafana"
  default     = true
  type        = bool
}

variable "enable_tls" {
  description = "Whether or not to enable TLS"
  default     = true
  type        = bool
}

variable "enable_ssh" {
  description = "Whether or not to enable SSH"
  default     = true
  type        = bool
}

variable "enable_elasticsearch_port" {
  description = "Whether or not to enable Elasticsearch"
  default     = true
  type        = bool
}

variable "enable_auth_port" {
  description = "Whether or not to enable Auth"
  default     = true
  type        = bool
}

variable "auth_port" {
  description = "Port hosting Auth access"
  default     = 9020
  type        = number
}

variable "enable_persistence_port" {
  description = "Whether or not to enable Persistence"
  default     = true
  type        = bool
}

variable "persistence_port" {
  description = "Port hosting Persistence access"
  default     = 9080
  type        = number
}

variable "enable_zk_port" {
  description = "Whether or not to enable Zookeeper"
  default     = true
  type        = bool
}

variable "zk_port" {
  description = "Port hosting Zookeeper access"
  default     = 21281
  type        = number
}

variable "application_security_group_ids" {
  description = "List of Application security group IDs"
  default     = []
  type        = list(string)
}

variable "ingress_cidr_blocks" {
  description = "CIDR blocks to attach to security groups for ingress"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Map of tags to attach to VM and Network Interface"
  type        = map(string)
  default     = {}
}
