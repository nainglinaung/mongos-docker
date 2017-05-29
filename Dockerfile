FROM ubuntu:latest

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
RUN apt-get update
RUN apt-get install -y --no-install-recommends software-properties-common
RUN echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-3.4.list

RUN apt-get update
# Update apt-get sources AND install MongoDB
RUN apt-get install mongodb-org=3.4.1 mongodb-org-server=3.4.1 mongodb-org-shell=3.4.1 mongodb-org-mongos=3.4.1 mongodb-org-tools=3.4.1

# Create the MongoDB data directory
RUN mkdir -p /data/db
RUN mkdir -p /cert

COPY run.sh /run.sh
COPY bitkey /cert/bitkey
COPY config.conf /config.conf


EXPOSE 26010

CMD ["/run.sh","-d"]
