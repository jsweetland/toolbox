#!/bin/bash

base_url=https://registry.hub.docker.com/v1/repositories
user=
login_option=

function show_help() {
  echo "Show the tags available in the remote repo for the specified image."
  echo "Usage: ${0} [-r REPO] [-u USER] -i IMAGE"
  echo "  -r REPO"
  echo "    The repository to check for tags."
  echo "  -i IMAGE"
  echo "    The image to check tags for."
  echo "  -u USER"
  echo "    Log into the specified repo using USER as the username. You will be prompted"
  echo "    to enter the password associated with the user if this option is specified."
  echo "  -h"
  echo "    Display this help information."
  exit 0
}

while getopts r:i:u:h opts; do
  case ${opts} in
    r)  repo=${OPTARG}
        base_url=https://${repo}/v2
        ;;
    i)  image=${OPTARG}
        ;;
    u)  user=${OPTARG}
        ;;
    h)  show_help
    esac
done

# check to see whether as password is required
if [ "${user}" != "" ]; then
  echo -n "Enter the password for ${user}: "
  read -s pass
  echo
  login_option="-u ${user}:${pass}"
fi

# get tags for the specified image
curl --silent ${login_option} ${base_url}/${image}/tags/list | jq
