#!/bin/bash

# include the script library
source $(dirname ${0})/../shell/script-library.sh

# set variables
nothing_to_commit_msg="nothing to commit, working tree clean"
new_local_changes_exist=0
repo_path="${1}"
original_path="$(pwd)"

# make sure the repo path exists
if [ "${repo_path}" = "" ]; then
  print_error_and_exit "no repo path was specified"
elif [ ! -d "${repo_path}" ]; then
  print_error_and_exit "the specified repo path could not be found"
fi

# navigate to the vault path
cd ${repo_path}

# fetch and pull the latest remote changes
print_step "getting the latest remote changes"
git fetch && git pull
exitcode=$?
if [ ${exitcode} -ne 0 ]; then
  print_error_and_exit "an error occurred getting the latest remote changes"
fi

# check for new local changes
print_step "checking for local changes"
last_line="$(git status | tail -n 1)"
if [ "${last_line}" = "${nothing_to_commit_msg}" ]; then
  print_notice "there are no new local changes, nothing will be synced to the remote"
else
  new_local_changes_exist=1
fi

# commit and push the latest local changes if they exist
if [ ${new_local_changes_exist} -eq 1 ]; then
  print_step "backing up the latest local changes"

  print_substep "adding new local files"
  git add --all
  exitcode=$?
  if [ ${exitcode} -ne 0 ]; then
    print_error_and_exit "an error occurred adding the latest local changes"
  fi

  print_substep "committing changes"
  git commit -m "vault backup: $(date '+%F %T')"
  exitcode=$?
  if [ ${exitcode} -ne 0 ]; then
    print_error_and_exit "an error occurred committing the latest local changes"
  fi

  print_substep "pushing local changes up to the remote"
  git push
  exitcode=$?
  if [ ${exitcode} -ne 0 ]; then
    print_error_and_exit "an error occurred pushing the latest local changes up to the remote"
  fi
fi

# go back to the original path
cd ${original_path}

print_success "finished syncing"
