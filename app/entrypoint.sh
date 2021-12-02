#!/bin/sh
set -e

trap "echo Exiting...; exit 0" EXIT TERM

if [ "$1" = 'java' ]; then

  BASE_DIR="/app"

  if ! [ -d "$BASE_DIR" ]; then
    mkdir "$BASE_DIR"
  fi

  cd "$BASE_DIR"

  if ! test -f $BASE_DIR/server.properties; then
    echo "Preparing Server Files..."
  fi

  echo "eula=true" > $BASE_DIR/eula.txt


  if test -f /opt/server.jar; then
    ln -sf /opt/server.jar $BASE_DIR/server.jar
  else
    echo server.jar not found
    exit 1
  fi

  echo "Starting Server Version $MINECRAFT_SERVER_VERSION..."
  exec "$@"
fi

exec "$@"