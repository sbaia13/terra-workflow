
###########Azure Application Gateway with WAF

# Create a resource groupe to hold our infrastructure
resource "azurerm_resource_group" "soufiane-lab-terraform" {
  name     = "soufiane-lab-terraform"
  location = "francecentral"
}

resource "azurerm_network_security_group" "nsg1" {      
  name = "nsg1"
  location            = "francecentral"
  resource_group_name = azurerm_resource_group.soufiane-lab-terraform.name
  security_rule {
    name                       = "default-allow-rdp"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "default-allow-http"
    priority                   = 1100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "default-allow-https"
    priority                   = 1400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "default-allow-appgw-StandardV2"
    priority                   = 1200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "GatewayManager"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "default-allow-appgw"
    priority                   = 1300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }
}

# Create a the first virtual network(Hub) with it's subnets
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = "francecentral"
  resource_group_name = azurerm_resource_group.soufiane-lab-terraform.name
  address_space       = ["10.60.0.0/22"]

  tags = {
    environment = "Test-Terraform"

  }
}

resource "azurerm_subnet" "subnets-vnet1" {
    virtual_network_name = azurerm_virtual_network.vnet1.name
    resource_group_name = azurerm_resource_group.soufiane-lab-terraform.name
    count = length(var.subnets-name-vnet1)
    name           = var.subnets-name-vnet1[count.index]
    address_prefixes = [var.subnets-cidr-vnet1[count.index]]
}
resource "azurerm_subnet_network_security_group_association" "asso1" {
  count = length(var.subnets-name-vnet1)
  subnet_id                 = azurerm_subnet.subnets-vnet1[count.index].id
  network_security_group_id = azurerm_network_security_group.nsg1.id
}
