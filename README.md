# Ansible to upgrade/install/precheck Robin 
## Make sure ansible,python,pip is installed on the control node
## for passing passowrd to all nodes use paramiko. Paramiko must be installed using pip
## Update host details on inventory/hosts.ini file.
## for single node non-ha-install udate inventory as below:
[master]
vnode-111-78

[primary-master]
vnode-111-78

[secondary-master]

[worker]


## If below error comes :
vnode-111-3 | FAILED | rc=-1 >>
to use the 'ssh' connection type with passwords, you must install the sshpass program or paramiko

run with -c paramiko when sshpass is not installed

# Examples
## To configure centos before cnp install
1. Add proper /etc/hosts file and resolve.conf file in dir centos_prerequisites
2. Run playbook centos-setup.yaml
   cd centos_prerequisites
   ansible-playbook -i ../inventory/hosts.ini centos-setup.yaml  --ask-pass -u root --ssh-extra-args='-o StrictHostKeyChecking=no' -c paramiko

   
## To download robin binaries
1. Update config.yaml file in main dir
2. Run ansible cmd:
   for --ask-become-pass give su to root password
   ansible-playbook playbook.yml  --ask-pass --ask-become-pass --tags download-robin-bin --extra-vars "@config.yaml" -c paramiko
3. If passwordless authentication is enabled
   ansible-playbook playbook.yml --tags download --extra-vars "@config.yaml"     
  
## To install robin of any version
1. Update config.yaml file in main dir
2. Run ansible cmd:
   ansible-playbook playbook.yml  --ask-pass --ask-become-pass --tags non-ha-install --extra-vars "@config.yaml" -c paramiko
   ansible-playbook playbook.yml  --ask-pass --ask-become-pass --tags ha-install --extra-vars "@config.yaml" -c paramiko

## To do prechecks before upgrade
  ansible-playbook playbook.yml  --ask-pass --ask-become-pass --tags precheck --extra-vars "@config.yaml" -c paramiko

## Capture cluster state before upgrade
  ansible-playbook playbook.yml  --ask-pass --ask-become-pass --tags cluster-status --extra-vars "@config.yaml" -c paramiko

## Preupgrade tasks
1. ansible-playbook playbook.yml  --tags pre-upgrade-tasks-550  --ask-pass --ask-become-pass -e "@config.yaml" -c paramiko

## To upgrade
1. Update config.yaml file with correct robin version
2. Run ansible cmd:
   ansible-playbook playbook.yml  --ask-pass --ask-become-pass --tags upgrade --extra-vars "@config.yaml" -c paramiko

## post upgrade tasks
1. ansible-playbook playbook.yml  --tags postcheck  --ask-pass --ask-become-pass -e "@config.yaml" 
2. ansible-playbook playbook.yml  --tags post-upgrade-tasks-550  --ask-pass --ask-become-pass -e "@config.yaml" -c paramiko

## To uninstall
1. Update config.yaml file with correct robin version to uninstall
2. Run ansible cmd in 2 steps:
   ansible-playbook robin-uninstall-playbook.yaml  --ask-pass --ask-become-pass --tags uninstall-robin-component --extra-vars "@config.yaml" -c paramiko
   ansible-playbook playbook.yml  --ask-pass --ask-become-pass --tags uninstall --extra-vars "@config.yaml" -c paramiko


## To run single task
ansible-playbook playbook.yml --list-tags

1. playbook: playbook.yml

   play #1 (all): Apply roles to hosts	TAGS: []
      TASK TAGS: [always, artifactory-cleanup, cluster-state, cluster-status, copy-kubeconfig-all, download-robin-bin, ha-install, host-script-install, host-uninstall, k8s-script-install-all-worker, k8s-script-install-primary, k8s-uninstall, k8splus-script-install-primary, k8splus-uninstall, non-ha-install, precheck, reboot_check, robin-app-cleanup, robin-cnp-uninstall, robin-script-install-primary, uninstall, upgrade, upgrade-precheck, v5.3, v5.4]

2. ansible-playbook playbook.yml -u root --ask-pass --tags host-script-install  --extra-vars "@config.yaml" -c paramiko



## Skip single tag for e.g you want to skip host-install ,you can run as below
ansible-playbook playbook.yml -u root --ask-pass --skip-tags k8s-script-install-all-worker,k8s-script-install-primary,k8splus-script-install-primary --extra-vars "@config.yaml"

## Adhoc command
ansible all -m ansible.builtin.yum -a "name=bind-utils state=present" -u root  --ask-pass
ansible all -m shell -a "echo 'anupkumar:test123' | chpasswd" -u root --ask-pass


## Run as su user for all tags like  below cmd
ansible-playbook playbook.yml  --ask-pass --ask-become-pass -u anupkumar --tags download-robin-bin  --extra-vars "@config.yaml" -c paramiko

# For macos:
## Install python3  and run below cmds
pip install ansible
pip install paramiko

## Use ansible cmds as belwow from macos:
ansible-playbook playbook.yml -c paramiko --ask-pass --ask-become-pass --tags non-ha-install --extra-vars "@config.yaml" -c paramiko
ansible all -m ansible.builtin.yum -a "name=bind-utils state=present" -u root  --ask-pass -c paramiko
ansible all -m shell -a uptime -u root --ask-pass -c paramiko

