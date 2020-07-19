# alb-demo
demo on alb with two ec2

## Requirements

* terraform > v0.12.1
* ansible > 2.0

## To Launch infra

Export AWS keys

```bash
  $ export AWS_ACCESS_KEY_ID="anaccesskey"
  $ export AWS_SECRET_ACCESS_KEY="asecretkey"

  $ terraform init
  $ terraform plan -var-file=prod.tfvars
  $ terraform apply -var-file=prod.tfvars

```
## Ansible command
```bash
ansible-playbook -i playbook/ec2.py --limit 'tag_env_demo:&tag_service_apache' -u centos --key-file=/tmp/demo.pem playbook/apache.yml -e 'apache_state=started'
```

## Author
- Yunoth
