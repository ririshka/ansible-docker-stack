provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-ubuntu" {
  ami           = "0866a3c8686eaeeba" 
  instance_type = "t2.micro"
  key_name      = "Aiperikey.pem" 

  user_data = <<-EOF
    #!/bin/bash
    sudo apt update
    sudo apt install -y ansible
    echo "
    - hosts: localhost
      tasks:
        - name: Ensure Git is installed
          apt:
            name: git
            state: present
    " > /home/ubuntu/playbook.yml
    ansible-playbook /home/ubuntu/playbook.yml
  EOF

  tags = {
    Name = "Ubuntu24.04-Instance"
  }

  security_groups = ["default"]
}

output "instance_public_ip" {
  value = aws_instance.ubuntu_instance.public_ip
}