#######################################
# Ubuntu AMI
#######################################

data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
    ]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#######################################
# SSH Key
#######################################

resource "tls_private_key" "ssh" {

  algorithm = "RSA"

  rsa_bits = 4096
}

resource "aws_key_pair" "generated" {

  key_name = "terraform-key"

  public_key = tls_private_key.ssh.public_key_openssh
}

resource "local_file" "pem" {

  filename = "terraform-key.pem"

  content = tls_private_key.ssh.private_key_pem

  file_permission = "0400"
}

#######################################
#######################################
# Security Group
#######################################

resource "aws_security_group" "runtime" {

  name = "runtime-security-group"

  #######################################
  # SSH
  #######################################

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # HTTP
  #######################################

  ingress {

    description = "HTTP"

    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # HTTPS
  #######################################

  ingress {

    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # Nginx
  #######################################

  ingress {

    description = "Nginx"

    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # Apache HTTP Server
  #######################################

  ingress {

    description = "Apache HTTP Server"

    from_port = 8081
    to_port   = 8081
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # Tomcat
  #######################################

  ingress {

    description = "Tomcat"

    from_port = 8082
    to_port   = 8082
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # WildFly (JBoss)
  #######################################

  ingress {

    description = "WildFly"

    from_port = 8083
    to_port   = 8083
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # MySQL
  #######################################

  ingress {

    description = "MySQL"

    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # MariaDB
  #######################################

  ingress {

    description = "MariaDB"

    from_port = 3307
    to_port   = 3307
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # PostgreSQL
  #######################################

  ingress {

    description = "PostgreSQL"

    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # MongoDB
  #######################################

  ingress {

    description = "MongoDB"

    from_port = 27017
    to_port   = 27017
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # Redis
  #######################################

  ingress {

    description = "Redis"

    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # Blockchain (Ganache)
  #######################################

  ingress {

    description = "Blockchain"

    from_port = 8545
    to_port   = 8545
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }




  #######################################
  # AI Notebook
  #######################################

  ingress {

    description = "Jupyter"

    from_port = 8888
    to_port   = 8888
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # EMQX MQTT
  #######################################

  ingress {

    description = "EMQX MQTT"

    from_port = 1883
    to_port   = 1883
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # EMQX Dashboard
  #######################################

  ingress {

    description = "EMQX Dashboard"

    from_port = 18083
    to_port   = 18083
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # Portainer
  #######################################

  ingress {

    description = "Portainer"

    from_port = 9000
    to_port   = 9000
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }


  #######################################
  # Remix IDE
  #######################################

  ingress {

    description = "Remix IDE"

    from_port = 8085
    to_port   = 8085
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  #######################################
  # Open WebUI
  #######################################

  ingress {

    description = "Open WebUI"

    from_port = 3000
    to_port   = 3000
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {

    description = "PocketBase"

    from_port = 8091
    to_port   = 8091
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = "WebXR"

    from_port = 8090
    to_port   = 8090
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }



  #######################################
  # Outbound
  #######################################

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "runtime-security-group"
  }
}

#######################################
# EC2 Instance
#######################################
resource "aws_instance" "runtime" {

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  key_name = aws_key_pair.generated.key_name

  vpc_security_group_ids = [
    aws_security_group.runtime.id
  ]

  user_data = templatefile("${path.module}/userdata.sh", {
    webxr_index = file("${path.module}/webxr/index.html")
  })
  user_data_replace_on_change = true


  #######################################
  # Root EBS Volume
  #######################################

  root_block_device {

    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = false
  }

  tags = {
    Name = var.instance_name
  }
}
