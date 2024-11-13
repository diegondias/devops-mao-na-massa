#/bin/bash

#https://www.jenkins.io/doc/book/installing/linux/#red-hat-centos - instalação jenkins
yum install -y epel-release wget git unzip
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
#sudo yum -y upgrade
# Add required dependencies for the jenkins package
sudo yum -y install fontconfig java-17-openjdk
sudo yum -y install jenkins
sudo systemctl daemon-reload
sudo systemctl enable jenkins --now

sudo firewall-cmd --permanent --add-port=8080/tcp
sudo firewall-cmd --reload 

#https://docs.docker.com/engine/install/rhel/ - instalação docker e docker compose
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine \
                  podman \
                  runc
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker --now

sudo timedatectl set-timezone America/Sao_Paulo 
sudo timedatectl set-local-rtc 1
sudo usermod -aG docker jenkins

#instalar sonar scanner
wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-4.6.2.2472-linux.zip
unzip sonar-scanner-cli-4.6.2.2472-linux.zip -d /opt/
mv /opt/sonar-scanner-4.6.2.2472-linux /opt/sonar-scanner
chown -R jenkins:jenkins /opt/sonar-scanner
echo 'export PATH=$PATH:/opt/sonar-scanner/bin' | sudo tee -a /etc/profile
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install nodejs -y