variable "random" {
  description = "random"
  type = string
}
variable "locations" {
  description = "locations to deploy the 3 vnets"
  type = string
}

variable "subnets-name-vnet1" {
  description = "subnet's list of the vnet 1"
  type = list
}

variable "subnets-cidr-vnet1" {
  description = "subnet's cidr block of the vnet1"
  type = list
}

