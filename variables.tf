variable "name" {}

variable "rg" {}

variable "host_count" {}

variable "subnet_id" {}

variable "public_ip" {}

variable "network_rules" {
  type = map(object({
    protocol                    = string
    direction                   = optional(string, "Inbound")
    access                      = optional(string, "Allow")
    source_port_range           = optional(string, "*")
    destination_port_range      = optional(string, "*")
    source_address_prefix       = optional(string, "*")
    destination_address_prefix  = optional(string, "*")
  }))
  default = {}
}
variable "high_availability" {
  default = false
}