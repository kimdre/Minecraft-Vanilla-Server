#!/usr/bin/env bash

# This Script checks for new Minecraft Vanilla Server Version on the Mojang Website
# and (if a new Version got published) creates a new build via Drone CI Command Line Tool

USER_AGENT="user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.182 Safari/537.36"

HTML=$(curl -s -H "$USER_AGENT" https://www.minecraft.net/de-de/download/server | grep -e "server.jar")
LATEST_VERSION=$(echo "$HTML" | grep -oe "minecraft_server.*.jar" | head -n1 | sed -e 's/minecraft_server.//' | sed -e 's/.jar//')
EXISTING_VERSIONS=$(curl -L -s 'https://registry.hub.docker.com/v2/repositories/kimdrechsel/minecraft-vanilla-server/tags?page_size=1024' | jq  '.results[]["name"]' | tr -d \")

if [ -z "$LATEST_VERSION" ]; then
	exit 1
fi

if ! echo "$EXISTING_VERSIONS" | grep -q "$LATEST_VERSION" || [[ "$1" == "-f" ]]; then
	echo "New Server Version found: $LATEST_VERSION"

	DOWNLOAD_URL=$(echo "$HTML" | grep -oe "https://launcher.mojang.com.*server.jar")

  build_number=$(/usr/local/bin/drone build create --param MINECRAFT_SERVER_VERSION="$TAG_VERSION" --param DOWNLOAD_URL="$DOWNLOAD_URL" Games/Minecraft-Vanilla-Server | grep Number  | cut -d' ' -f2)
  echo "Starting build pipeline at
  https://drone.pyas.de/Games/Minecraft-Vanilla-Server/$build_number"

fi
