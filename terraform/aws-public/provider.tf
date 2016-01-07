provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# Define our vpc
resource "aws_vpc" "default" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# SSH keypair for the instances
resource "aws_key_pair" "deployer" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.key_file)}"
}

# Generate an etcd URL for the cluster
resource "template_file" "etcd_discovery_url" {
  filename = "/dev/null"
  provisioner "local-exec" {
    command = "curl https://discovery.etcd.io/new?size=${var.masters + var.slaves} > ${var.etcd_discovery_url_file}"
  }
  # This will regenerate the discovery URL if the cluster size changes
  vars {
    size = "${var.masters + var.slaves}"
  }
}
