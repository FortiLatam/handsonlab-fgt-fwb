

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

data "template_file" "setupwebinternalinstance" {
  template = "${file("${var.bootstrap-webinternal}")}"
  }

  data "template_file" "setupweblegacyinstance" {
  #template = "${file("${var.weblegacy.conf}")}"
  template = "${file("${var.bootstrap-weblegacy}")}"
  }

##data "template_file" "web_legacy_2" {
##  template = file("./weblegacy")
##}

####### Create Web internal instance ########
//This instance will be placed behind the FortiGate
resource "aws_instance" "web-internal" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = var.keyname
  subnet_id     = aws_subnet.privatesubnetaz1.id
  vpc_security_group_ids = [aws_security_group.public_allow.id]
  

  tags = {
    Name = "Web-Internal"
   }

  user_data = data.template_file.setupwebinternalinstance.rendered
  #user_data = data.template_file.web_legacy_2.rendered 

}
####### Create Web Legacy instance ########
//This instance will access internet by IGW
resource "aws_instance" "web-legacy" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = var.keyname
  subnet_id     = aws_subnet.legacysubpub.id
  vpc_security_group_ids = [aws_security_group.public_allow_legacy.id]
  associate_public_ip_address = true

  tags = {
    Name = "Web-Legacy"
 
  }

    user_data = data.template_file.setupweblegacyinstance.rendered
  
}