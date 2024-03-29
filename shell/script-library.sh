# terminal colors
redcolor='\033[0;31m'
greencolor='\033[0;32m'
yellowcolor='\033[0;33m'
nocolor='\033[0;m'

# special characters
leadspace=" "
midspace=" "
tabgap="   "
filled_trimark=▶
empty_trimark=▷
checkmark=✔
xmark=✗
bulletmark=•
stepmain="${leadspace}${filled_trimark}${midspace}"
stepsub="${leadspace}${tabgap}${empty_trimark}${midspace}"
stepsuccess="${leadspace}${checkmark}${midspace}"
stepfailure="${leadspace}${xmark}${midspace}"
steperror="${stepfailure}ERROR: "
stepnotice="${leadspace}${bulletmark}${midspace}"
ellipses=" ... "

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
  printf '%b%s%s%s%b\n' "${greencolor}" "${stepmain}" "${1}" "${ellipses}" "${nocolor}"
}

function print_substep_and_wait() {
  printf '%b%s%s%s%b' "${greencolor}" "${stepsub}" "${1}" "${ellipses}" "${nocolor}"
}

function substep_wait_passed() {
  printf '%b%s%b\n' "${greencolor}" "${checkmark}" "${nocolor}"
}

function substep_wait_failed() {
  printf '%b%s%b\n' "${redcolor}" "${xmark}" "${nocolor}"
}

function print_substep() {
  print_substep_and_wait "$1"
  printf '\n'
}

function print_error() {
  printf '%b%s%s%b\n' "${redcolor}" "${steperror}" "${1}" "${nocolor}" > /dev/stderr
}

function print_error_and_exit() {
  if [ "${2}" = "" ]; then
    exitcode=1
  else
    exitcode=${2}
  fi

  print_error "${1}"
  exit ${exitcode}
}

function print_notice() {
  printf '%b%s%s%b\n' "${yellowcolor}" "${stepnotice}" "${1}" "${nocolor}"
}

function print_subnotice() {
  print_notice "${tabgap}${1}"
}

function print_subsubnotice() {
  print_subnotice "${tabgap}${1}"
}

function print_success() {
  printf '%b%s%s%b\n' "${greencolor}" "${stepsuccess}" "${1}" "${nocolor}"
}

function print_failure() {
  printf '%b%s%s%b\n' "${redcolor}" "${stepfailure}" "${1}" "${nocolor}"
}
