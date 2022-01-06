//AWS Configuration
variable access_key {}
variable secret_key {}

variable "region" {
  default = "us-east-1"
}

// Availability zones for the region
variable "az1" {
  default = "us-east-1a"
}

// VPC FortiGate 
variable "vpccidr" {
  default = "10.1.0.0/16"
}

variable "publiccidraz1" {
  default = "10.1.0.0/24"
}

variable "privatecidraz1" {
  default = "10.1.1.0/24"
}

//IP Fortiweb
variable "ip_fwb" {
  default = "10.1.1.11" 
}

// VPC Legacy
variable "vpclegcidr" {
  default = "172.16.0.0/16"
}

variable "publiclegcidraz1" {
  default = "172.16.0.0/24"
}


// License Type to create FortiGate-VM
// Provide the license type for FortiGate-VM Instances, either byol or payg.
variable "license_type" {
  default     = "payg"
}

// license file for the active fgt
variable "license" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.lic"
}

// license file for the fortiweb
variable "fwblicense" {
  // Change to your own byol license file, license.lic
  type    = string
  default = "license.lic"
}


// AMIs are for FGTVM-AWS(PAYG) - 7.0.2
variable "fgtvmami" {
  type = map
  default = {
    us-west-2      = "ami-0e569295bb3f6ab11"
    us-west-1      = "ami-095959eb30adfa9a3"
    us-east-1      = "ami-099e9f57e31ec423c"
    
  }
}


// AMIs are for FGTVM AWS(BYOL) - 7.0.2
variable "fgtvmbyolami" {
  type = map
  default = {
    us-west-2      = "ami-05558fc4d58e0311d"
    us-west-1      = "ami-02b8386b83b22a768"
    us-east-1      = "ami-07ebc2e34d5ce72f4"
    us-east-2      = "ami-0d64f9d41d2c347fe"
    ap-east-1      = "ami-0aebd5b952425a493"
    ap-south-1     = "ami-015b6108d837a11bb"
    ap-northeast-3 = "ami-09eabd6630c92b02f"
    ap-northeast-2 = "ami-0575bff848509c6d8"
    ap-southeast-1 = "ami-0c36d980e164c3372"
    ap-southeast-2 = "ami-06217cfb67db81bd7"
    ap-northeast-1 = "ami-046d2f9510157fe5a"
    ca-central-1   = "ami-014a19c8175403554"
    eu-central-1   = "ami-090da6c908c1127f6"
    eu-west-1      = "ami-082aa757173803c84"
    eu-west-2      = "ami-0ab723f14117aa285"
    eu-south-1     = "ami-0472705b9d0a4e155"
    eu-west-3      = "ami-0b4e3a514d31d3a79"
    eu-north-1     = "ami-0a48ff95e49c70174"
    me-south-1     = "ami-03a43777cd244fca4"
    sa-east-1      = "ami-094f94451eda5df8b"
  }
}

variable "fwb2vmami" {
  type = map
  default = {
    us-east-1      = "ami-07b2a5f564da9f88b"
  }
}


// AMIs are for FGTVM AWS(BYOL) - 7.0.2
variable "fwb2vmbyolami" {
  type = map
  default = {
    us-east-1      = "ami-0607a49cdd0573d9c"
   }
}


variable "size" {
  default = "c5.large"
}

variable "fwbsize" {
  default = "c5.large"
}

//  Existing SSH Key on the AWS 
variable "keyname" {
  default = "forti-ssh-key"
}

variable "adminsport" {
  default = "8443"
}

variable "bootstrap-fgtvm" {
  // Change to your own path
  type    = string
  default = "fgtvm.conf"
}

variable "bootstrap-fwbvm" {
  // Change to your own path
  type    = string
  default = "fwbvm.conf"
}

variable "bootstrap-weblegacy" {
  // Change to your own path
  type    = string
  default = "weblegacy.conf"
}

variable "bootstrap-webinternal" {
  // Change to your own path
  type    = string
  default = "webinternal.conf"
}

variable "conf-webinternal" {
  type    = string
  default = "webinternal.conf"
}

variable "conf-weblegacy" {
  type    = string
  default = "weblegacy.conf"
}


