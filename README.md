docker-wso2esb
===================

Docker image to create a container running WSO2 Enterprise Service Bus configured to interact with WSO2 Message Broker.
It uses the [thoeni/centos-oracle-java](https://hub.docker.com/r/thoeni/centos-oracle-java/) as its base image.

The dockerfile will:

* Use the latest vanilla WSO2 ESB Docker image (thoeni/wso2esb:latest)
* Apply all the configuration to communicate with WSO2 Message Broker
* Set the ESB `wso2server.sh` start-up script as the container start-up command.

### Usage
* Clone the current repository, and `git checkout message-broker` to select the proper branch
* Before building: configure within the Dockerfile the appropriate MB_CONTAINER_NAME variable, with the name of the docker container for the WSO2 Message Broker (that should be already running on your Docker host)
* To build, from the project root folder: `docker build --rm -t your_image_name .`
* To run: `docker run --rm --name your_container_name -p 9443:9443 -p 8280:8280 your_image_name`
* To access ESB web admin console, navigate to `https://[DOCKER_HOST]:9443`
