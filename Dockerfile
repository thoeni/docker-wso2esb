#
# WSO2 ESB 4.8.1 on CentOS Linux with Oracle JDK 1.7.0_80
#

FROM	thoeni/centos-oracle-java:1.7.0_80

MAINTAINER Antonio Troina, thoeni@gmail.com

ENV WSO2_SOFT_VER=4.8.1

# copy zip from local folder to container
RUN     wget -P /opt --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/enterprise-service-bus/${WSO2_SOFT_VER}/wso2esb-${WSO2_SOFT_VER}.zip && \
	yum update -y && \
	yum install -y unzip && \
	mv /opt/wso2esb-${WSO2_SOFT_VER}.zip /opt/wso2esb.zip
        unzip /opt/wso2esb.zip -d /opt && \
        rm /opt/wso2esb.zip

EXPOSE 9443
EXPOSE 9763
EXPOSE 8243
EXPOSE 8280

CMD ["/opt/wso2esb/bin/wso2server.sh"]	
