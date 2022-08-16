#!/bin/bash

# define the tasks that need to be done with the extracted content
process_tar() {
    cd $WORK_DIR"/bin"

    # do something with the extracted content
    eval "./hello_${os}_${arc} $@"
}

# line number where payload starts
PAYLOAD_LINE=$(awk '/^__PAYLOAD_BEGINS__/ { print NR + 1; exit 0; }' $0)

# Determine the os and arch.
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
 	os="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	os="darwin"
else
	echo "unsupported OS: " + `uname -a`
	exit 1
fi

if [[ `uname -m` == "arm64" ]]; then 
	arc="arm64"
elif [[ `uname -m` == "x86_64" ]]; then
	arc="amd64"
else
	echo "unsupported arch: " + `uname -m`
	exit 1
fi

# make our directory if it doesn't exist.
mkdir -p /tmp/helloshell

# directory where a tarball is to be extracted
WORK_DIR=/tmp/helloshell

# extract the embedded tar file
tail -n +${PAYLOAD_LINE} $0 | tar -zpx -C $WORK_DIR >/dev/null 2>&1

# perform actions with the extracted content
process_tar $@

exit 0
__PAYLOAD_BEGINS__
