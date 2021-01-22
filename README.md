# Proof of Concept

The purpose of this repo is to demonstrate a simple Sinatra + Ansible + Terraform proof of concept. This demo will use Terraform to standup an EC2 and RDS instance in AWS in addition to some other minor resources (security groups, etc).

After the AWS resources are stood up our Terraform script dynamically adds the public IP address of the newly created instance to the Ansible inventory/hosts.cfg file.

Using a dynamic DNS service we will then manually create or update a DNS name to point to the new public IP address.

Finally we will use the Ansible playbook to configure the new EC2 instance to act as a simple web server. The Ansible script will also install Ruby, run database migrations, and configure [Caddy](https://caddyserver.com/) to route traffic from our DNS name to a [Thin](https://github.com/macournoyer/thin) server to running Sinatra.


* NOTE - This solution is intended to show off a AWS hosted solution but would obviously be overkill for a developer just looking to setup their local machine. I hope to update this solution with a Dockerfile for a local setup time permitting.



## PREREQUISITE

- install [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- install [Ansible CLI](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)
- install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- `aws configure`


## CLONE REPO

- visit https://github.com/ryangrush/sinatra-deploy for more information
- `git clone git@github.com:ryangrush/sinatra-deploy.git`
- `cd sinatra-deploy`


## TERRAFORM

- `cd terraform/plans/app1`
- `terraform init`
- `terraform plan`
- `terraform apply`


## KEYS

- use `ssh-keygen` or an existing public/private keys
- add the public key output to line 2 of terraform/plans/app1/main.tf
- add the private key file to ansible/keys/deployer.pem


## DNS

- goto https://my.noip.com/#!/dynamic-dns and create new hostname
- change dns to point to the new public IP
- update the dns in ansible/roles/caddy/files/Caddyfile to new dns name you created


## ANSIBLE

- `cd ansible/`
- `ansible-playbook -i inventory/hosts.cfg main.yml`


## BROWSER

- visit the DNS name you used (i.e. http://rgrush.ddns.net/)



# Teardown

## TERRAFORM

- `cd terraform/plans/app1`
- `terraform destroy`