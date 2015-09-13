#
# WSO2 ESB 4.8.1
#
FROM 	cogniteev/oracle-java:java7

MAINTAINER Antonio Troina, thoeni@gmail.com

ENV WSO2_SOFT_VER=4.8.1

# copy zip from local folder to container
RUN	wget -P /opt --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/enterprise-service-bus/${WSO2_SOFT_VER}/wso2esb-${WSO2_SOFT_VER}.zip && \
    	apt-get update && \
	apt-get install -y zip && \
    	apt-get clean && \
    	unzip /opt/wso2esb-${WSO2_SOFT_VER}.zip -d /opt && \
    	rm /opt/wso2esb-${WSO2_SOFT_VER}.zip

ENV 	JAVA_HOME /usr/lib/jvm/java-7-oracle

EXPOSE 9443
EXPOSE 9763
EXPOSE 8243
EXPOSE 8280

CMD ["/opt/wso2esb-4.8.1/bin/wso2server.sh"]
