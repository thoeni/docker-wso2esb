#
# WSO2 ESB 4.9.0 on CentOS Linux with Oracle JDK 1.8.0_60
#

FROM	thoeni/wso2esb:latest

MAINTAINER Antonio Troina, thoeni@gmail.com

ENV 	MB_CONTAINER_NAME=wso2mb

ADD	lib /opt/wso2esb/repository/components/lib/

RUN	sed -i -e "/5672/ s/localhost/${MB_CONTAINER_NAME}/" /opt/wso2esb/repository/conf/jndi.properties && \
	sed -i -e '/5672/ p;s/QueueConnectionFactory/TopicConnectionFactory/' /opt/wso2esb/repository/conf/jndi.properties && \
	sed -i -e '/WSO2 MB/ {' -e 'n; s/<!--/</' -e '}' /opt/wso2esb/repository/conf/axis2/axis2.xml && \
	sed -i -e '/WSO2 MB/ {' -e 'n;n;n;n;n;n;n;n;n;n;n;n;n;n;n;n;n;n;n;n;n;n; s/-->/>/' -e '}' /opt/wso2esb/repository/conf/axis2/axis2.xml && \
	sed -i -e '/use connection pools for sending messages/ {' -e ' s/>/-->/' -e '}' /opt/wso2esb/repository/conf/axis2/axis2.xml && \
	sed -i -e '/use connection pools for sending messages/ {' -e 'n; s/-->/>/' -e '}' /opt/wso2esb/repository/conf/axis2/axis2.xml 

CMD ["/opt/wso2esb/bin/wso2server.sh"]
