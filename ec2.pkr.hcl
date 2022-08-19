packer {
    ## Qual o provedor que vou utilizar
    ## Posso usar mais de um provedor
    required_plugins {
        aws = {
            version = ">= 1.1.2"
            source  = "github.com/hashicorp/amazon"
        }

        ## Colocaria aqui caso quisesse usar outro provedor
    }
}

## Estou indo na aws e buscando por uma ami ubuntu atualizada
data "amazon-ami" "ec2" {
    region          = "us-west-2"

    filters = {
        virtualization-type = "hvm"
        name                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
        root-device-type    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
}

source "amazon-ebs" "ec2" {
    source_ami      = data.amazon-ami.ec2.id
    ami_name        = "ec2-lab-packer2"
    instance_type   = "t2.medium"
    ssh_username    = "ubuntu"
    region          = "us-west-2"

}

build {
    sources = [
        "source.amazon-ebs.ec2"
    ]

    provisioner "shell" {
        script = "./script.sh"
    }
}