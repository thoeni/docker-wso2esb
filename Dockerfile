#
# WSO2 ESB 4.9.0 on CentOS Linux with Oracle JDK 1.7.0_80
#

FROM	thoeni/centos-oracle-java:1.7.0_80

MAINTAINER Antonio Troina, thoeni@gmail.com

ENV WSO2_SOFT_VER=4.9.0

# copy zip from local folder to container
RUN     wget -P /opt --user-agent="testuser" --referer="http://connect.wso2.com/wso2/getform/reg/new_product_download" http://product-dist.wso2.com/products/enterprise-service-bus/${WSO2_SOFT_VER}/wso2esb-${WSO2_SOFT_VER}.zip && \
	yum update -y && \
	yum install -y unzip && \
        unzip /opt/wso2esb-${WSO2_SOFT_VER}.zip -d /opt && \
	mv /opt/wso2esb-${WSO2_SOFT_VER} /opt/wso2esb && \
        rm /opt/wso2esb-${WSO2_SOFT_VER}.zip && \
	sed -i.bak '/<StatisticsReporterDisabled>/ s/true/false/' /opt/wso2esb/repository/conf/carbon.xml && \
	sed -i.bak '/<parameter name="cachableDuration">/ s/15000/1000/' /opt/wso2esb/repository/deployment/server/synapse-configs/default/registry.xml && \
	echo -e "<BamConfig>\n\t<ServiceDataPublishing>enable</ServiceDataPublishing>\n\t<WebappDataPublishing>disable</WebappDataPublishing>\n</BamConfig>" > /opt/wso2esb/repository/conf/etc/bam.xml

EXPOSE 9443
EXPOSE 9763
EXPOSE 8243
EXPOSE 8280

CMD ["/opt/wso2esb/bin/wso2server.sh"]	
