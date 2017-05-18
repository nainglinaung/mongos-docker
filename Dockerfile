FROM ubuntu:latest

# Installation:
# Import MongoDB public GPG key AND create a MongoDB list file
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
RUN apt-get update
RUN apt-get install -y --no-install-recommends software-properties-common
RUN echo "deb http://repo.mongodb.org/apt/ubuntu $(cat /etc/lsb-release | grep DISTRIB_CODENAME | cut -d= -f2)/mongodb-org/3.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list


# Update apt-get sources AND install MongoDB
RUN apt-get update && apt-get install -y mongodb-org




# Create the MongoDB data directory
RUN mkdir -p /data/db
COPY run.sh /run.sh
COPY config.conf /config.conf


EXPOSE 26010

CMD ["./run.sh"]
