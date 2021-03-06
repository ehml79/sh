#!/bin/bash


mkdir /data/service/src/

wget -O /data/service/src/apache-maven-3.6.1-bin.tar.gz    http://mirror.bit.edu.cn/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz

tar -xf /data/service/src/apache-maven-3.6.1-bin.tar.gz  -C /data/service/
mv /data/service/apache-maven-3.6.1 /data/service/maven

profiled="/etc/profile.d/maven.sh"

export MAVEN_HOME=/data/service/maven
export PATH=${PATH}:${MAVEN_HOME}/bin

echo "MAVEN_HOME=/data/service/maven"  >> ${profiled}
echo "export PATH=\${PATH}:\${MAVEN_HOME}/bin" >> ${profiled}
