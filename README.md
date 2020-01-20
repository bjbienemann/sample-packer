# Sample Packer and Terraform

### Requirements

* Packer 1.5.1+
* Vagrant 2.2.6+
* Virtualbox 5.2.20

Build vagrant image
```
./packer build -only=virtualbox-iso template.json
```

Run instance virtualbox
```
vagrant box add ubuntu-18.04.3 ./output/ubuntu-18.04.3.box
```
```
vagrant init ubuntu-18.04.3
```
```
vagrant up
```

AWS
```
./packer build -only=amazon-ebs -var-file=variables.json template.json
```

### References

<https://blog.ippon.tech/from-development-to-production-with-vagrant-and-packer/>
<https://github.com/aseigneurin/vms>

<https://www.serverlab.ca/tutorials/dev-ops/automation/how-to-use-packer-to-create-ubuntu-18-04-vagrant-boxes/>
<https://github.com/serainville/packer_templates>

<https://github.com/BigDataBoutique/elasticsearch-cloud-deploy>

<https://github.com/hashicorp/vagrant>
<https://github.com/hashicorp/packer>
<https://github.com/hashicorp/terraform>
