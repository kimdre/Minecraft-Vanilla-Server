# Minecraft-Vanilla-Server

Minecraft Vanilla Server Java Edition on Docker

[![Build Status](https://drone.pyas.de/api/badges/Games/Minecraft-Vanilla-Server/status.svg)](https://drone.pyas.de/Games/Minecraft-Vanilla-Server)

This Repository is mirrored from my [Gitea instance](https://git.pyas.de/Games/Minecraft-Vanilla-Server).

## Image
This image is based on the official Java JDK 18 image running on an Alpine image.

For the Image on Docker Hub see [here](https://hub.docker.com/r/kimdrechsel/minecraft-vanilla-server).

## Run
### Latest version

`docker run -p 25565:25565 kimdrechsel/minecraft-vanilla-server:latest`

### Specific version

`docker run -p 25565:25565 kimdrechsel/minecraft-vanilla-server:1.18`

## Server.jar
The latest `server.jar` gets 
1. stored to `/opt` in the docker image 
2. and symlinked to `/app/server.jar` 

## Volumes
- `/app` contains server-related files
- `/app/world` contains the world data

## Automated image building for new Releases 
New images with the corresponding version as it's tag are created automatically when a new Minecraft server version is released (Checks run every 30 minutes).