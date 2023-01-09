#!/bin/bash

docker ps -a | grep -v CONTAINER | awk '{print $1}' | xargs docker stop | xargs docker rm
docker volume ls -qf dangling=true | xargs docker volume rm | docker system prune -af
