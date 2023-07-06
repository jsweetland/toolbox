# terminal colors
redcolor='\033[0;31m'
greencolor='\033[0;32m'
yellowcolor='\033[0;33m'
nocolor='\033[0;m'

# special characters
stepmain=" ▶"
tabgap="    "
stepsub="${tabgap}▷"
checkmark=✔
xmark=✗

# function to verify a binary is available
function verify_bin_path() {
  print_substep_and_wait "verifying ${1} is available"
  bin_path=$(which ${1})
  if [ "${bin_path}" = "" ]; then
    substep_wait_failed
    print_error_and_exit "${1} not found, please install ${1} and try again"
  else
    substep_wait_passed
  fi
}

# function to print a main step
function print_step() {
  echo -e "${greencolor}${stepmain} ${1} ... ${nocolor}"
}

function print_substep_and_wait() {
  echo -ne "${greencolor}${stepsub} ${1} ... ${nocolor}"
}

function substep_wait_passed() {
  echo -e "${greencolor}${checkmark}${nocolor}"
}

function substep_wait_failed() {
  echo -e "${redcolor}${xmark}${nocolor}"
}

function print_substep() {
  print_substep_and_wait $1
  echo ""
}

function print_error() {
  echo -e "${redcolor}ERROR: ${1}${nocolor}" > /dev/stderr
}

function print_error_and_exit() {
  if [ "${2}" = "" ]; then
    exitcode=1
  else
    exitcode=${2}
  fi

  print_error ${1}
  exit ${exitcode}
}

function print_notice() {
  echo -e "${yellowcolor}${1}${nocolor}"
}

function print_subnotice() {
  print_notice "${tabgap}${1}"
}

function print_subsubnotice() {
  print_subnotice "${tabgap}${1}"
}
