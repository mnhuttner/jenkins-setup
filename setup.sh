set -x

yum -y install java-1.8.0-openjdk.x86_64 || exit 2
java --version

cp /etc/profile /etc/profile.prev
echo 'export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk' | tee -a /etc/profile
echo 'export JRE_HOME=/usr/lib/jvm/jre' | tee -a /etc/profile
source /etc/profile
echo $JAVA_HOME
echo $JRE_HOME

cd ~
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
yum -y install jenkins

# Start the Jenkins service and set it to run at boot time:
systemctl start jenkins.service
systemctl enable jenkins.service

# to allow access to Jenkins, you need to enable inbound traffic on port 8080:
firewall-cmd --zone=public --permanent --add-port=8080/tcp
firewall-cmd --reload

cat /var/lib/jenkins/secrets/initialAdminPassword

echo firefox http://localhost:8080
