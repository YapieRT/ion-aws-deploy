resource "aws_instance" "Ion-Instance" {
  availability_zone      = var.zone
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance
  subnet_id              = aws_subnet.Ion_Public_Subnet.id
  key_name               = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.Ion_SG.id]

  provisioner "file" {
    source      = var.db_connection_src
    destination = var.db_connection_dst
        connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.prv_key_path)
      host        = aws_instance.Ion-Instance.public_ip
    }
  }

    provisioner "file" {
    source      = var.docker_compose_src
    destination = var.docker_compose_dst
        connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.prv_key_path)
      host        = aws_instance.Ion-Instance.public_ip
    }
  }


  user_data = templatefile("startup_scripts/startup.sh.tpl", {
    PORT       = var.wport
    INITIAL_IP = var.sip
  })
  tags = {
    project = var.project
  }

  depends_on =[aws_key_pair.ssh_key , aws_security_group.Ion_SG ]
}
