[dev]
${web_app} ansible_user=ubuntu ansible_ssh_private_key_file=keys/deployer.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'