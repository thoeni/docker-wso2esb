#
# WSO2 ESB 4.9.0 on CentOS Linux with Oracle JDK 1.8.0_60
#

FROM	ubuntu:latest

MAINTAINER Antonio Troina, thoeni@gmail.com

ENV WSO2_SOFT_VER=4.9.0
ENV JAVA_VERSION=8

# Install Java8
RUN	sudo add-apt-repository ppa:webupd8team/java --yes && \
	sudo apt-get update && \
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections && \
  	sudo apt-get install oracle-java${JAVA_VERSION}-installer --yes --force-yes --assume-yes && \
	sudo apt-get install oracle-java${JAVA_VERSION}-set-default && \
	grep JAVA_HOME ~/.bashrc || echo "export JAVA_HOME='/usr/lib/jvm/java-${JAVA_VERSION}-oracle'" >> ~/.bashrc && \
	export JAVA_HOME='/usr/lib/jvm/java-${JAVA_VERSION}-oracle'

ENV	JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-oracle/

# Install latest version of ESB
RUN     wget -P /opt --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/enterprise-service-bus/${WSO2_SOFT_VER}/wso2esb-${WSO2_SOFT_VER}.zip && \
	yum update -y && \
	yum install -y unzip && \
        unzip /opt/wso2esb-${WSO2_SOFT_VER}.zip -d /opt && \
	mv /opt/wso2esb-${WSO2_SOFT_VER} /opt/wso2esb && \
        rm /opt/wso2esb-${WSO2_SOFT_VER}.zip

EXPOSE 9443 9763 8243 8280

CMD ["/opt/wso2esb/bin/wso2server.sh"]	
