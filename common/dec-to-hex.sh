#!/bin/bash

function show_help() {
    echo "Usage: ${0} RVAL GVAL BVAL"
    echo "  RVAL  The red value in the RGB value"
    echo "  GVAL  The green value in the RGB value"
    echo "  BVAL  The blue value in the RGB value"
}

function convert_and_print_val() {
    if [ "${1}" -lt 16 ]; then
        printf '0%x' ${1}
    else
        printf '%x' ${1}
    fi
}

# load the values
rval="${1}"
gval="${2}"
bval="${3}"

# make sure the values are populated
if [ "${rval}" = "" ] || [ "${gval}" = "" ] || [ "${bval}" = "" ]; then
    echo "ERROR: one or more values is missing" > /dev/stderr
    show_help
    exit 1
fi

# convert and display the values
convert_and_print_val ${rval}
convert_and_print_val ${gval}
convert_and_print_val ${bval}

echo
