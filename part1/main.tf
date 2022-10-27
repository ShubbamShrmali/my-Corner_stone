terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

provider "aws" {
    profile = var.ec2_profile
    region = var.aws_region
    
}



resource "aws_instance" "tomcat" {
    ami = var.ec2_ami
    count = var.ec2_count
    key_name   = var.key_name
    instance_type = var.instance_type
    security_groups = ["${var.ec2_sg}"]
    subnet_id = element(var.ec2_subnet_id, count.index) #element(list, index)
    tags = {
        Name = "${var.ec2_tags[0]}"
    } 
    user_data = file("tomcat.sh")

}

resource "aws_instance" "docker" {
    ami = var.ec2_ami
    count = var.ec2_count
    key_name   = var.key_name
    instance_type = var.instance_type
    security_groups = ["${var.ec2_sg}"]
    subnet_id = element(var.ec2_subnet_id, count.index) #element(list, index)
    tags = {
        Name = "${var.ec2_tags[1]}"
    } 
    user_data = file("docker.sh")

}

resource "aws_instance" "jenkins" {
    ami = var.ec2_ami
    count = var.ec2_count
    key_name   = var.key_name
    instance_type = var.instance_type
    security_groups = ["${var.ec2_sg}"]
    subnet_id = element(var.ec2_subnet_id, count.index) #element(list, index)
    tags = {
        Name = "${var.ec2_tags[2]}"
    } 
    user_data = file("jenkinsServer.sh")

}