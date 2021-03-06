#
# WSO2 ESB 4.9.0 on CentOS Linux with Oracle JDK 1.8.0_60
#

FROM	thoeni/centos-oracle-java:1.8.0_60

MAINTAINER Antonio Troina, thoeni@gmail.com

ENV WSO2_SOFT_VER=4.9.0

# copy zip from local folder to container
RUN     wget -P /opt --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/enterprise-service-bus/${WSO2_SOFT_VER}/wso2esb-${WSO2_SOFT_VER}.zip && \
	yum update -y && \
	yum install -y unzip && \
        unzip /opt/wso2esb-${WSO2_SOFT_VER}.zip -d /opt && \
	mv /opt/wso2esb-${WSO2_SOFT_VER} /opt/wso2esb && \
        rm /opt/wso2esb-${WSO2_SOFT_VER}.zip

EXPOSE 9443
EXPOSE 9763
EXPOSE 8243
EXPOSE 8280

CMD ["/opt/wso2esb/bin/wso2server.sh"]	
