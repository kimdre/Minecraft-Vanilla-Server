FROM openjdk:18-jdk-alpine3.13
LABEL maintainer="Kim Oliver Drechsel kim@drechsel.xyz"

ARG MINECRAFT_SERVER_VERSION
ARG DOWNLOAD_URL

LABEL org.opencontainers.image.authors="Kim Oliver Drechsel kim@drechsel.xyz"
LABEL org.opencontainers.image.version="$MINECRAFT_SERVER_VERSION"
LABEL org.opencontainers.image.description="Minecraft Vanilla Server Java Edition based on the official Java JDK 18 image running on Alpine."
LABEL org.opencontainers.image.base.name="hub.docker.com/openjdk:18-jdk-alpine3.13"
LABEL org.opencontainers.image.title="Minecraft Vanilla Server Java Edition"

RUN apk update && \
    apk add --no-cache --update coreutils && \
    apk add --no-cache --update tzdata curl unzip bash

ENV TZ=Europe/Berlin
ENV MINECRAFT_SERVER_VERSION="$MINECRAFT_SERVER_VERSION"

WORKDIR /app

VOLUME /app/world
VOLUME /app

ADD $DOWNLOAD_URL /opt/server.jar
COPY app /app

RUN chmod 755 /app/entrypoint.sh
RUN echo "eula=true" > /app/eula.txt

EXPOSE 25565/tcp

ENTRYPOINT [ "/app/entrypoint.sh" ]
CMD [ "java", "-Xmx4G", "-jar", "server.jar", "nogui" ]