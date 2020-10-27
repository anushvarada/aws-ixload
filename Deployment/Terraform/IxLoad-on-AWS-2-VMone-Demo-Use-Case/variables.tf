terraform {
  experiments = [variable_validation]
}

variable "Region" {
	type = string
	default = "us-east-1"
}

variable "UserEmailTag" {
	type = string
	default = "aws-ixload@amazon.com"
	description = "Email address tag of user creating the stack"
	validation {
		condition = length(var.UserEmailTag) >= 14
		error_message = "UserEmailTag minimum length must be >= 14."
	}
}

variable "UserLoginTag" {
	type = string
	default = "aws-ixload"
	description = "Login ID tag of user creating the stack"
	validation {
		condition = length(var.UserLoginTag) >= 4
		error_message = "UserLoginTag minimum length must be >= 4."
	}
}

variable "IxClientInstanceType" {
	type = string		
	default = "m4.xlarge"
	description = "Instance type of Ixia Client VM"
	validation {
		condition = can(regex("m4.xlarge", var.IxClientInstanceType)) || can(regex("m4.large", var.IxClientInstanceType)) || can(regex("t2.xlarge", var.IxClientInstanceType))
		error_message = "IxClientInstanceType must be one of (m4.xlarge | m4.large | t2.xlarge) types."
	}
}

variable "IxClientSSHKey" {
	description = "Name of an existing EC2 KeyPair to enable SSH access"
	type = string
	default = "aws-ixload-key-pair"
}

variable "VMoneInstanceType" {
	description = "Instance type of VMONE Appliance VM"
	type = string
	default = "c4.8xlarge"
	validation {
		condition =  can(regex("c4.8xlarge", var.VMoneInstanceType)) || can(regex("c4.4xlarge", var.VMoneInstanceType)) || can(regex("c4.2xlarge", var.VMoneInstanceType))
		error_message = "VMoneInstanceType must be one of (c4.8xlarge | c4.4xlarge | c4.2xlarge) types."
	}
}

variable "InboundIPv4CidrBlock" {
	type = string
	default = "1.1.1.1/32"
	description = "IP Address /32 or IP CIDR range connecting inbound to Ixia Client"
	validation {
		condition = length(var.InboundIPv4CidrBlock) >= 9 && length(var.InboundIPv4CidrBlock) <= 18 && can(regex("(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})/(\\d{1,2})", var.InboundIPv4CidrBlock))
		error_message = "InboundIPv4CidrBlock must be a valid IP CIDR range of the form x.x.x.x/x."
	}
}