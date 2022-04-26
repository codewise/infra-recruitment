variable "lb_attach_to_private_alb_listener_rules" {
  type = map
}

variable "cert_options" {
  type = map
}

locals {
  listener_ports = var.lb_attach_to_private_alb_listener_rules.*.port

  validation_options_projects   = [for p in var.cert_options : split(".", p.domain_name)[1]]
}