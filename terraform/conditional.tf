module "certificate" {
  source = "../../certificate/2.0.0"

  count = local.create_certificate ? 1 : 0

  certificate_domain_name = local.dns_domain_name
}

# Certificate module has certificate_arn output
# How to use this value in the conditional below?

module "lb_public" {
  source           = "./lb"

  https_certificate = local.create_certificate ? var.dns_certificate_arn : // certificate certificate_arn output

}