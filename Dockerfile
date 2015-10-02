#
# WSO2 ESB on Ubuntu Linux with Oracle JDK
#

FROM 	ubuntu:latest

MAINTAINER Antonio Troina, thoeni@gmail.com

#	Depending on project needs, the following three variables can be changed accordingly:

#	Version of the ESB you want to install on this image, and run within the container
ENV 	WSO2_SOFT_VER=4.8.1

#	Oracle Java you want the container to run with (typically ESB 4.8.1 goes with Java7, and ESB 4.9.0 can run with Java8)
ENV 	JAVA_VERSION=7

#	Whether you want the image to be built using as ESB source repository the official WSO2 Website, or a public AWS S3 Bucket
ENV 	DL_WSO2_WEBSITE=false

ENV 	JAVA_HOME=/usr/lib/jvm/java-${JAVA_VERSION}-oracle

	# Install Java
RUN 	apt-get install software-properties-common -y && \
	add-apt-repository ppa:webupd8team/java --yes && \
	apt-get update && \
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections && \
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections && \
  	apt-get install oracle-java${JAVA_VERSION}-installer --yes --force-yes --assume-yes && \
	apt-get install oracle-java${JAVA_VERSION}-set-default && \
	grep JAVA_HOME ~/.bashrc || echo "export JAVA_HOME='/usr/lib/jvm/java-${JAVA_VERSION}-oracle'" >> ~/.bashrc && \
	export JAVA_HOME='/usr/lib/jvm/java-${JAVA_VERSION}-oracle'

	# Install latest version of ESB through official WSO2 Website
RUN 	apt-get update -y && \
	apt-get install -y wget && \
	if ${DL_WSO2_WEBSITE} == true; then wget -P /opt --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/enterprise-service-bus/${WSO2_SOFT_VER}/wso2esb-${WSO2_SOFT_VER}.zip; else wget -P /opt https://s3-us-west-2.amazonaws.com/wso2-stratos/wso2esb-${WSO2_SOFT_VER}.zip; fi && \
	apt-get install -y unzip && \
        unzip /opt/wso2esb-${WSO2_SOFT_VER}.zip -d /opt && \
	mv /opt/wso2esb-${WSO2_SOFT_VER} /opt/wso2esb && \
        rm /opt/wso2esb-${WSO2_SOFT_VER}.zip

#	Expose basic ports from ESB
EXPOSE 	9443 9763 8243 8280

CMD ["/opt/wso2esb/bin/wso2server.sh"]	
