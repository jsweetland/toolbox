# lists the functions in a shell script
#!/bin/zsh

source $(dirname ${0})/script-library.sh

if [ "${1}" = "" ]; then
  print_error_and_exit "no shell script specified"
elif [ ! -f ${1} ]; then
  print_error_and_exit "could not find the specified shell script"
fi

for func in $(cat ${1} | grep -v "#" | grep "function" | cut -d " " -f 2 | sed 's/()//g'); do
  print_notice "${func}"
done
