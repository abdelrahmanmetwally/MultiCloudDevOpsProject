cd terraform-modules-project/main-files
terraform init
terraform plan 
terraform apply --auto-approve

cd ../../../ansible-roles
ansible-playbook playbook.yml
