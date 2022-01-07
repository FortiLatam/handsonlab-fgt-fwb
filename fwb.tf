// FWBVM instance


data "aws_ami_ids" "fwbvmbyolami" {
  owners = ["679593333241"]

  filter {
    name   = "name"
    values = ["FortiWeb-AWS-*_BYOL_Release-*"]
  }
}

data "aws_ami" "fwbvmpaygami" {
  most_recent = true
#  name_regex = ".*OnDemand.*"

  filter {
    name   = "name"
    values = ["FortiWeb-AWS-6.3.17_OnDemand_Release-a5a2d0d8-7904-494c-b6f0-af222cd09d29"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["679593333241"] # Fortinet
}



resource "aws_network_interface" "fwbeth0" {
  description       = "fwbvm-port1"
  subnet_id         = aws_subnet.privatesubnetaz1.id
  source_dest_check = false
  
}


resource "aws_network_interface_sg_attachment" "fwbpublicattachment" {
  depends_on           = [aws_network_interface.fwbeth0]
  security_group_id    = aws_security_group.public_allow.id
  network_interface_id = aws_network_interface.fwbeth0.id
}

resource "aws_instance" "fwbvm" {
  
  #ami               = var.license_type == "byol" ? "ami-08fd45e2227281f92" : data.aws_ami.fwbvmpaygami.id
  #ami               = "ami-08fd45e2227281f92"
  ami               = var.license_type == "byol" ? var.fwb2vmbyolami[var.region] : var.fwb2vmami[var.region]
  instance_type     = var.fwbsize
  availability_zone = var.az1
  key_name          = var.keyname
  user_data         = data.template_file.FortiWeb.rendered
  private_ip        = var.ip_fwb

  root_block_device {
    volume_type = "standard"
    volume_size = "2"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.fwbeth0.id
    device_index         = 0
  }

  tags = {
    Name = "FortiWebVM"
  }
}


data "template_file" "FortiWeb" {
  template = "${file("${var.bootstrap-fwbvm}")}"
  vars = {
    type         = "${var.license_type}"
    license_file = "${var.license}"
    adminsport   = "${var.adminsport}"
    webserverinternal_ip = "${aws_instance.web-internal.private_ip}"
    fortiwebinternal_ip = "${var.ip_fwb}"
  }
}

