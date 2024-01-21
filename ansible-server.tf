# Provisioning of Ansible Master and Node

resource "aws_instance" "ansible-master" {
  ami                    = "ami-05a36e1502605b4aa"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecomm-public-subnet.id
  key_name               = "kiki"
  vpc_security_group_ids = [aws_security_group.ecomm-sg.id]
  private_ip             = "10.0.1.11"

  tags = {
    Name = "Ansible Master"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install git",
      "git clone https://github.com/beaustar2/Ansible-tf-project1.git",
      "cd Ansible-tf-project1",
      "sudo chmod 400 kiki.pem",
      "sudo yum -y install epel-release",
      "sudo yum -y install ansible",
      "ansible -m ping -i host.ini n1",
      "ansible-playbook setup_ecomm.yml -i host.ini",
    ]

    connection {
      type        = "ssh"
      user        = "centos"
      private_key = file("/home/centos/kiki.pem")
      host        = self.public_ip
    }
  }
}

resource "aws_instance" "n1" {
  ami                    = "ami-05a36e1502605b4aa"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.ecomm-public-subnet.id
  key_name               = "kiki"
  vpc_security_group_ids = [aws_security_group.ecomm-sg.id]
  private_ip             = "10.0.1.12"

  tags = {
    Name = "Ansible Node"
  }
}

