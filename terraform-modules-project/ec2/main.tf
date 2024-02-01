# Create an EC2 instance  in public subnet 2 
resource "aws_instance" "ec2"  {
  #count = length(var.pub-subnets)
  ami = "ami-06aa3f7caf3a30282"
  instance_type = var.instance_type      
  vpc_security_group_ids = var.vpc_security_group_ids
 

 
  subnet_id  = var.subnet_id
  associate_public_ip_address = var.ec2-public-ip-or-no
  key_name = "terraform"
  
  

  tags = {
    Name = var.tagofec2
  }

  

    provisioner "local-exec" {
    command = <<-EOT
      echo "Public IP: ${self.public_ip}" >all-ips.txt
    EOT
  }

}







