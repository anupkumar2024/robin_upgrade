#! /bin/bash

mkdir /etc/yum.repos.d-backup
mv /etc/yum.repos.d/* /etc/yum.repos.d-backup/.

cat << EOF >> /etc/yum.repos.d/local.repo
[local]
name= CentOS7 Repo
baseurl=http://[fd74:ca9b:3a09:868c:10:9:61:117]/CentOS79/
enabled=1
gpgcheck=0
EOF

 
rpm -ivh slirp4netns-0.4.3-4.el7_8.x86_64.rpm           # ( package is on 46 VM )
sudo yum downgrade  -y device-mapper device-mapper-libs --enablerepo=local
sudo yum downgrade -y cyrus-sasl-lib --enablerepo=local