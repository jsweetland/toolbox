#!/bin/bash

# remove leftover containers
echo "looking for containers ..."
container_count=$(docker ps -a -q | wc -l | awk '{print $1}')
if [ ${container_count} -gt 0 ]; then
  echo "removing ${container_count} containers ..."
  docker rm -f $(docker ps -a -q)
else
  echo "no containers found"
fi

# remove leftover volumes
echo "looking for volumes ..."
volume_count=$(docker volume ls -q | wc -l | awk '{print $1}')
if [ ${volume_count} -gt 0 ]; then
  echo "removing ${volume_count} volumes ..."
  docker volume rm $(docker volume ls -q)
else
  echo "no volumes found"
fi
