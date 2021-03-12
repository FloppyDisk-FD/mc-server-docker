FROM openjdk:8-alpine

RUN apk add --no-cache \
     git \
     curl wget \
     tzdata \
     bash

ENV TIMEZONE=Asia/Shanghai
ENV SERVER_URL=https://papermc.io/api/v2/projects/paper/versions/1.16.5/builds/529/downloads/paper-1.16.5-529.jar

RUN echo $TIMEZONE > /etc/timezone && \
     cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
WORKDIR /mc-server
RUN wget --no-check-certificate -O server.jar $SERVER_URL

ENV EULA=true
RUN echo eula=$EULA >  eula.txt
EXPOSE 25565

ADD start-server /mc-server
RUN chmod +x start-server

ENV MEMORY_MAX=512M
ENV MEMORY_MIN=512M

ENTRYPOINT  ["./start-server"]