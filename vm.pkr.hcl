variable "ami_id" {
	type = string
	default = "ami-0da467f007dfebd6b"
}

variable "app_name" {
	type = string
	default = "httpd"
}

locals {
	app_name = "httpd"
}

source "amazon-ebs" "httpd" {
	ami_name = "PKR-DEMO-${local.app_name}"
	instance_type = "t3.micro"
	region = "us-west-2"
	source_ami = "${var.ami_id}"
	ssh_username = "ec2-user"
}

build {
	sources = ["source.amazon-ebs.httpd"]

	provisioner "shell" {
		script = "script/script.sh"
	}
	post-processor "shell-local" {
		inline = ["echo hello_foo"]
	}
}
