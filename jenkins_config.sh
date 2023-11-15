#!/bin/bash

#membres : Jean-Eudes TCHIBOZO | 
apt-get install openjdk-17-jre-headless
JENKINS_VERSION="latest"
JENKINS_PORT=8080

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins=$JENKINS_VERSION

systemctl status jenkins
systemctl enable jenkins
systemctl start jenkins

while ! nc -z localhost $JENKINS_PORT; do
  sleep 1
done

echo "Jenkins est démarré et accessible sur http://localhost:$JENKINS_PORT"

# Afficher la clé initiale pour le déverrouillage de Jenkins
echo "Clé initiale de Jenkins:"
cat /var/lib/jenkins/secrets/initialAdminPassword

 apt-get autoremove -y


echo "Installation et configuration de Jenkins terminées."
