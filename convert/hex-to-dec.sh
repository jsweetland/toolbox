#!/bin/bash
# WIP

function show_help() {
    echo "Usage: ${0} HEXVAL"
    echo "  HEXVAL  The hexidecimal RGB value"
}

# load the values
hexval="${1}"

# make sure the values are populated
if [ "${hexval}" = "" ]; then
    echo "ERROR: hex value is missing" > /dev/stderr
    show_help
    exit 1
fi

# parse the separate values
rhex=${hexval:0:2}
ghex=${hexval:2:2}
bhex=${hexval:4:2}

# convert and display the values
echo "$((16#${rhex})) $((16#${ghex})) $((16#${bhex}))"
