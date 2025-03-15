resource "aws_instance" "web_server" {
  ami                    = "ami-04b4f1a9cf54c11d0"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name = aws_key_pair.web_key.key_name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y apache2
              sudo systemctl start apache2
              echo "Hello, World" > /var/www/html/index.html
              EOF

  tags = {
    Name = "web-server"
  }
}

resource "aws_key_pair" "web_key" {
  key_name   = "web-server-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCeCI1Gt41FHp/dmzhesrilSACJjuxahFi5MGFkxQTTPauiIQaBJ6Ga7MtqcFoBoURKSKF7pfHFIJwx+TEfcObo+E3fZrmhfGN1v18Jje+lM6Q0KW9NTBwrPDij25HgncH4JjANyT5nJm4jfA1+Q6lRARNlmQ4VZiTOL2lnSZu6MmNrsoukAHI+tINYvFyLgSVaW/WMS1JFAr8Vb1MQ8/7HLDxns9Tehu0hU22ml5GSzaDc3ygTwY9D6F672HpgtsfePfVOyXGLb1KcoN6Oy6NJdQkquzjVrD8MftcR3poNkaJbieHnTBzuu+M1yCHJR8s+FewQgz1bree1twJWIdzNkQHW8cP/U4TSW4ZNqh4f5HqXR5l0BjFumqXkSDVvlrGUJG/fenIEEPyQcn87LG6soGbzpx0PcGlLaOk2xTJyIWrFyjwMkQLq+xmsdqe9f3CjomR/5jRo022mDsuhDwjwBaPNDWhcMA+oiGKsPJU53365rcApy2gL9PyuTFroOqXKaEMx+/nnKVfXJCd8C4O6E5IdNMN4q6MNE+gtYnRyY4cbIKSt5ivG7ZnKez+JIR8l/zoRmUm1cpf69pJt3rMTk9lFMpMtjSeaCC9BwxMJBxyQAzdrAlaeBgNyU3SqQAaC+A+R0WsQJmLEc5YNQrPLQUvRIXDu9UiSn3x+e/TWYQ== mazen.mohamed1393@gmail.com"
}
