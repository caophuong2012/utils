#!/bin/bash
echo "This script is tutored to install Ruby on docker"
[ ! -z "$1" ] && docker_name=$1 || docker_name="ruby" 
[ ! -z "$2" ] && docker_port=$2 || docker_port="3000"

#docker create --name $docker_name -ti debian:latest
docker run --name $docker_name -d -p $docker_port:80 -it debian:latest && echo "Created a docker debian-based"
docker start $docker_name && echo "Started container"
sleep 5

# Install packages
docker exec -ti $docker_name apt-get update -y && echo "apt-get update done"
docker exec -ti $docker_name apt-get install ruby -y && echo "Installed ruby"
docker exec -ti $docker_name ruby -v && echo "Checked ruby version"
docker exec -ti $docker_name apt-get install build-essential patch -y 
docker exec -ti $docker_name apt-get install ruby-dev zlib1g-dev liblzma-dev -y
docker exec -ti $docker_name gem install rails && echo "Install rails"

# Run a Rails project
rail_name="my-blog"
docker exec -ti $docker_name apt-get install libsqlite3-dev -y
docker exec -ti $docker_name rails new $rail_name && echo "Created new project"
docker exec -ti $docker_name apt-get install nodejs -y && echo "Installed Nodejs"
docker exec -ti $docker_name rails s -b 0.0.0.0 && echo "Allowed all inbound connections"
