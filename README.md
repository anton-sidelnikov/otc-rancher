# otc-rancher - Rancher server in Open Telekom Cloud infrastructure

This project shows hot to create simple infrastructure for rancher in OpenTelekomCloud environment

This repository contains:
 - playbook and terraform scripts for creating/destroying Rancher infrastructure
 - playbook for Rancher installation
 - playbook for destoying infrastructure

### Requirements
Existing scripts were checked to be working with:
 - Terraform 0.12
 - Ansible 2.8 (Python 3.7)

### Build

**! Before run install required ansible roles from requirements.txt**

Review and change parameters under ``inventory/prod/group_vars``
- cat inventory/mycluster/group_vars/all/all.yml

Also need to change cluster parameters``/infrastructure/rancher/terraform.tfvars``

- Infrastructure build can be triggered using `ansible-playbook -i inventory/prod/ playbooks/create_rancher_infrastructure.yml`.

- Then install Rancher server with Ansible Playbook `ansible-playbook -i inventory/prod/ playbooks/rancher_server.yml`.

**!NB** Terraform is using OBS for storing remote state
Following variables have to be set: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`

Also terraform using next variables for build:
```
export AWS_ACCESS_KEY_ID=my_key
export AWS_SECRET_ACCESS_KEY=my_secret
export OS_TENANT_NAME=my_tenant
export OS_DOMAIN_NAME=my_domain
export OS_USERNAME=my_username
export OS_PASSWORD=my_password
```
### Rancher server role

This role installs Rancher 2 (latest version, see rancher.com) with letsencrypt certificates on a custom server using Docker.

### Role Variables
docker_version: "18.09" => The docker version you want to install
rancher_container_name: "rancher_v2" => The name you want for the rancher docker container
rancher_domain_name: "your_domain_name" => The domain name of Rancher and which you use for letsencrypt
rancher_url: "https://{{ rancher_domain_name }}" => The url of the rancher server
certs_path: "/etc/letsencrypt/live/{{ rancher_domain_name }}" => path to letsencrypt certificates
rancher_ssl_port: 443 => Use a different if you do not desire to use SSL
