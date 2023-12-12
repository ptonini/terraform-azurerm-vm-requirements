resource "azurerm_availability_set" "this" {
  count               = var.high_availability ? 1 : 0
  name                = "${var.name}-as"
  resource_group_name = var.rg.name
  location            = var.rg.location
  managed             = true
}

module "security_group" {
  source        = "ptonini/network-security-group/azurerm"
  version       = "~> 1.0.2"
  name          = "${var.name}-sg"
  rg            = var.rg
  network_rules = var.network_rules
}

module "network_interface" {
  source            = "ptonini/network-interface/azurerm"
  version           = "~> 1.0.3"
  count             = var.host_count
  name              = "${var.name}${format("%04.0f", count.index + 1)}-net-interface"
  rg                = var.rg
  subnet_id         = var.subnet_id
  public_ip         = var.public_ip
  security_group_id = module.security_group.this.id
}