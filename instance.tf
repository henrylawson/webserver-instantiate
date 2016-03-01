resource "aws_instance" "webserver" {
  ami                  = ""
  availability_zone    = "${var.aws_availability_zone}"
  instance_type        = "t2.nano"
  subnet_id            = "${aws_subnet.default.id}"
  security_groups      = ["${aws_security_group.webserver.id}"]
  key_name             = "${aws_key_pair.auth.id}"

  root_block_device {
    volume_type = "standard"
    volume_size = "8"
  }

  tags {
    Name = "webserver"
  }
}

resource "aws_key_pair" "auth" {
  key_name    = "${var.ssh_key_name}_webserver"
  public_key  = "${file(var.ssh_public_key_path)}"
}
