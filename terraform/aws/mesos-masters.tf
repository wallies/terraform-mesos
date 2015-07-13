/* Base packer build we use for provisioning master instances */
resource "atlas_artifact" "mesos-master" {
  name = "${var.atlas_artifact.master}"
  type = "aws.ami"
}

/* Mesos master instances */
resource "aws_instance" "mesos-master" {
  instance_type     = "${var.instance_type.master}"
  ami               = "${replace(atlas_artifact.mesos-master.id, concat(var.region, ":"), "")}"
  availability_zone = "${lookup(var.zones, concat("zone-", count.index))}"
  count             = "${var.masters}"
  key_name          = "${var.key_name}"
  source_dest_check = false
  security_groups   = ["${aws_security_group.default.id}"]
  depends_on        = ["aws_instance.bastion", "aws_internet_gateway.public"]
  private_ip        = "${lookup(var.master_ips, concat("master-", count.index))}"
  subnet_id         = "${element(aws_subnet.private.*.id, count.index)}"
  tags = {
    Name = "apollo-mesos-master-${count.index}"
    role = "mesos_masters"
  }
}