#!/bin/sh
set -ex

participants_file=data/participants.yml
if [ ! -e $participants_file ]
then
    echo "participants: []" > $participants_file
fi

server_image=localhost/okdio-server:latest

cwd=$(pwd)
podman run --rm -it \
    -p 4567:4567 \
    -v $cwd/config.rb:/opt/app-root/src/config.rb:Z \
    -v $cwd/data:/opt/app-root/src/data:Z \
    -v $cwd/source:/opt/app-root/src/source:Z \
    -v $cwd/briefings:/opt/app-root/src/briefings:Z \
    $server_image
