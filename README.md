docker-wso2esb
===================

Docker image to install and run WSO2 Enterprise Service Bus. It uses the [thoeni/centos-oracle-java](https://hub.docker.com/r/thoeni/centos-oracle-java/) as its base image.

The dockerfile will:

* Use `wget` to pull the ESB latest version (tags are available for 4.8.1 and 4.9.0) ZIP from a the official WSO2 website, and copies into container `/opt` folder.
* Install `unzip`.
* Unzip the ESB ZIP archive.
* Remove the ESB ZIP archive.
* Expose the container port `9443`.
* Set the ESB `wso2server.sh` start-up script as the container start-up command.

### Usage
* To pull: `docker pull thoeni/wso2esb`
* To build: `docker build --rm -t your_image_name github.com/thoeni/docker-wso2esb`
* To run: `docker run --rm --name your_container_name -p 9443:9443 -p 8280:8280 your_image_name`
* To access ESB web admin console, navigate to `https://[DOCKER_HOST]:9443`
