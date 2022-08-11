resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

locals {
  comon_tags = {
    company      = var.company
    project      = "${var.company}-${var.project}"
    billing_code = var.billing_code
  }

  storage_container_name = "lemon-web-app-${random_integer.rand.result}"
}
