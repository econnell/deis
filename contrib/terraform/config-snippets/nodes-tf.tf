
resource "aws_instance" "deis_node" {
    count = "${var.cluster_size}"
    ami = "${lookup(var.coreos_images, format("%s-%s", var.region, var.virt_type))}"
    instance_type = "${var.instance_type}"
    vpc_security_group_ids = [ "${aws_security_group.deis_ssh.id}", "${aws_security_group.deis_control.id}", "${aws_security_group.deis_web.id}" ] 
    key_name = "${var.key_name}"
    subnet_id = "${aws_subnet.deis_public.id}"
    associate_public_ip_address = true
    tags {
        Name = "deis-cluster-node"
    }
}

