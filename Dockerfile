FROM debian:stretch
LABEL maintainer="tux1337"

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

#Update
RUN apt-get update && apt-get dist-upgrade -y

# Install Dependencies
RUN apt-get install -y --force-yes\
    git\ 
    python3\
    python3-pip\
    bluetooth\ 
    bluez\
    libglib2.0-dev\
 && apt-get clean
 

WORKDIR /opt

RUN git clone https://github.com/zewelor/bt-mqtt-gateway.git

WORKDIR /opt/bt-mqtt-gateway

RUN pip3 install -r requirements.txt
RUN pip3 install python-eq3bt

RUN apt-get remove git -y && apt-get clean


CMD ["/opt/bt-mqtt-gateway/gateway.py","-d"]
