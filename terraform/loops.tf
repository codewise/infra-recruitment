resource "aws_elb" "classic_lb" {
  count = var.enabled && var.load_balancer_type == "classic" ? 1 : 0

  name    = local.lbname
  subnets = compact(var.subnet_ids)

  dynamic "listener" {
    for_each = local.enabled_listeners
    content {
      instance_port      = listener.value.target_port
      instance_protocol  = listener.value.target_protocol
      lb_port            = listener.value.source_port
      lb_protocol        = listener.value.source_protocol
      ssl_certificate_id = lower(listener.value.source_protocol) == "https" ? var.https_certificate : ""
    }
  }
}