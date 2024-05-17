resource "aws_instance" "test-server" {
  ami           = "ami-0bb84b8ffd87024d8" 
  instance_type = "t2.micro" 
  key_name = "insurance-14may"
  vpc_security_group_ids= ["sg-0a849c42ae72d5a15"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./insurance-14may.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
    command = "echo ${aws_instance.test-server.public_ip} > inventory"
  }
  provisioner "local-exec" {
    command = "ansible-playbook /var/lib/jenkins/workspace/Prajwal-Banking-Project/scripts/finance-playbook.yml"
  }
  }
