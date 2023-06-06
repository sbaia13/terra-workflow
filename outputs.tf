output "PublicIP-aapgw" {
  value = azurerm_public_ip.souf-publicIP-appgw.ip_address
}
output "secret_identifier" {
  value = azurerm_key_vault_certificate.ssl-certificate.secret_id
}