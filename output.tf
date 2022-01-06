
output "FortiGate_and_FortiWeb_PublicIP" {
  value = aws_eip.FGTPublicIP.public_ip
}

output "FortiGate_Port" {
  value = var.adminsport
}

output "FortiGate_Username" {
  value = "admin"
}

output "FortiGate_Password" {
  value = aws_instance.fgtvm.id
}

output "WebServer_Internal_Public_IP" {
  value = aws_eip.FGTPublicIP.public_ip
}
output "WebServer_Internal_IP" {
  value = aws_instance.web-internal.private_ip
}

//port set on fgtvm.conf file (VIP "Internal_WebServer_SSH")
output "WebServer_Internal_SSH" {
  value = "2222"
}

//default username of AMI used
output "WebServer_Internal_Username" {
  value = "ubuntu"
}

output "WebServer_Legacy_IP" {
  value = aws_instance.web-legacy.private_ip
}

output "WebServer_Legacy_Public_IP" {
  value = aws_instance.web-legacy.public_ip
}

output "WebServer_Legacy_SSH" {
  value = "22"
}

//default username of AMI used
output "WebServer_Legacy_Username" {
  value = "ubuntu"
}


//port set on fgtvm.conf file
output "FortiWeb_Port" {
  value = "9443"
}

output "FortiWeb_Username" {
  value = "admin"
}

output "FortiWeb_Password" {
  value = aws_instance.fwbvm.id
}
/* 


Acesso SSH ao web legacy

Acesso ao FWB ip, porta e senha*/