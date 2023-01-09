#!/bin/bash

function announce() {
	echo "${1} | ${2}"
}

function announce_step() {
	announce "${1}" "${2} ..."
}

function announce_error() {
	echo "${1} | ERROR - an error occurred while ${2}" > /dev/stderr
}

function announce_error_and_exit() {
	announce_error "${1}" "${2}"

	exit_code="${3}"
	if [ "${exit_code}" == "" ]; then
		exit_code=1
	fi

	exit ${exit_code}
}