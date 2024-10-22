# Ansible to upgrade/install/precheck Robin 
# Make sure ansible is installed on the control node

# Examples
# To download robin binaries
1. Update variables.yaml file in main dir
2. run ansible cmd:
   ansible-playbook playbook.yml  --ask-pass --tags download --extra-vars "@variables.yaml"

# To install robin of any version
1. Update variables.yaml file in main dir
2. run ansible cmd:
   ansible-playbook playbook.yml  --ask-pass --tags non-ha-install --extra-vars "@variables.yaml"
   ansible-playbook playbook.yml  --ask-pass --tags ha-install --extra-vars "@variables.yaml"

# To do prechecks before upgrade
  ansible-playbook playbook.yml  --ask-pass --tags precheck --extra-vars "@variables.yaml" 

# Capture cluster state before upgrade
  ansible-playbook playbook.yml  --ask-pass --tags cluster-status --extra-vars "@variables.yaml" 

# to upgrade
1. update variables.yaml file with correct robin version
2. run ansible cmd
   ansible-playbook playbook.yml  --ask-pass --tags upgrade --extra-vars "@variables.yaml"
   
   
## for macos:
# install python3  and run below cmds
pip install ansible
pip install paramiko

# use ansible cmds as belwow:
  ansible-playbook playbook.yml -c paramiko --ask-pass --tags non-ha-install --extra-vars "@variables.yaml"
