#!/usr/bin/env bash


# prologue creates a test directory and goes to it
function prologue() {
    rm -rf /tmp/test
    mkdir -p /tmp/test
    cd /tmp/test
}

# pass the filename as the first argument like this
#   $ save_input_as_file /tmp/test.txt
#
# expected input from test cases:
#   any text you type in a test case
#   with any number of lines
#   ...
#
function save_input_as_file() {
    cat --> "$1"
}

# initfiles_with_size creates files with given size
#
# expected input from test cases:
#   .app_backup.bkp 19000
#   linux.img 100000
#   echo 1600
#
function initfiles_with_size() {
    while read line; do
        attrs=( $line )
        dd if=/dev/zero of="${attrs[0]}" bs=1 count="${attrs[1]}"
    done
}

# initfiles creates empty files with given names
#
# expected input from test cases:
#   .app_backup.bkp
#   linux.img
#   echo
#
function initfiles() {
    while read filename; do
        touch "$filename"
    done
}

# start_infinite_process do what the name is said
function start_infinite_process () {
    while true; do sleep 1; done
}

# send_data_to_channel sends data to created channel
# in the local directory
SECRET_DATA=$RANDOM

function send_data_to_channel() {
    rm -f .channel
    mkfifo .channel
    echo "$SECRET_DATA" > .channel &
}

# test_data_from_channel reads data from pre-created channel
# receives the reference data as the first argument
#   $ test_data_from_channel 100500
function test_data_from_channel() {
    received="$(cat .channel)"
    (test "$1" = "$received" && echo "Ok") || echo "Error"
}

## Example:
echo '
::shell
::code

function solve() {
    # add your solution here

}

function prologue() {
    rm -rf /tmp/test
    mkdir -p /tmp/test
    cd /tmp/test
}

function save_input_as_file() {
    cat --> "$1"
}

prologue
save_input_as_file
solve
'
