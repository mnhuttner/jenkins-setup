set -x

apt-get -y install openjdk-7-jre || exit 2
java -version

cp /etc/profile /etc/profile.prev
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.7.0-openjdk-amd64' | tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | tee -a /etc/profile

source /etc/profile
echo $JAVA_HOME
echo $JRE_HOME

cd ~
apt-get -y install jenkins || exit 2

# Start the Jenkins service and set it to run at boot time:
systemctl start jenkins.service
systemctl enable jenkins.service

# to allow access to Jenkins, you need to enable inbound traffic on port 8080:
firewall-cmd --zone=public --permanent --add-port=8080/tcp
firewall-cmd --reload

cat /var/lib/jenkins/secrets/initialAdminPassword

echo firefox http://localhost:8080
