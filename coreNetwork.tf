provider "azurerm" {
  version = "=1.34.0"
}
resource "azurerm_resource_group" "core" {
   name         = "core"
   location     = "${var.loc}"
   tags         = "${var.tags}"
}

# Create public IP
resource "azurerm_public_ip" "vpnGatewayPublic" {
  name                = "${var.resource_prefix}TFPublicIP"
  location            = "${var.loc}"
  resource_group_name = "${azurerm_resource_group.core.name}"
  allocation_method   = "Dynamic"
  tags                = "${var.tags}"
}

# Create virtual network
resource "azurerm_virtual_network" "core" {
  name                = "${var.resource_prefix}TFVnet"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["1.1.1.1", "1.0.0.1"]
  location            = "${var.loc}"
  resource_group_name = "${azurerm_resource_group.core.name}"
  tags                = "${var.tags}"
}

# Create subnet
resource "azurerm_subnet" "GatewaySubnet" {
  name                 = "${var.resource_prefix}TFSubnet"
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.0.0/24"
}

resource "azurerm_subnet" "training" {
  name                 = "${var.resource_prefix}training"
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_subnet" "dev" {
  name                 = "${var.resource_prefix}dev"
  resource_group_name  = "${azurerm_resource_group.core.name}"
  virtual_network_name = "${azurerm_virtual_network.core.name}"
  address_prefix       = "10.0.2.0/24"
}

/* resource "azurerm_virtual_network_gateway" "vpnGateway" {
    name                = "vpnGateway"
    location            = "${azurerm_resource_group.core.location}"
    resource_group_name = "${azurerm_resource_group.core.name}"
    tags                = "${azurerm_resource_group.core.tags}"

    type                = "Vpn"
    vpn_type            = "RouteBased"

    sku                 = "Basic"
    enable_bgp          = true

    ip_configuration {
        name                            = "vpnGwConfig"
        public_ip_address_id            = "${azurerm_public_ip.vpnGatewayPublicIp.id}"
        private_ip_address_allocation   = "Dynamic"
        subnet_id                       = "${azurerm_subnet.GatewaySubnet.id}"
    }

}*/