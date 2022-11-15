#!/bin/bash

#Author: Toroyteach
#Description: Use this script to find a way to add
## spinner like progress or any kind of progress to 
## to have something like a feedback to the user

## function to run the spinner animation in a while loop
spin() {
    spinner="/|\\-/|\\-"
    while :; do
        for i in $(seq 0 7); do
            echo -n "${spinner:$i:1}"
            echo -en "\010"
            sleep 1
        done
    done
}

echo "About to make a slow web call..."

# Start the Spinner:
spin &
# Make a note of its Process ID (PID):
SPIN_PID=$!
# Kill the spinner on any signal, including our own exit.
trap "kill -9 $SPIN_PID" $(seq 0 15)

## make a web call or anything that will take time to finish
sleep 10

echo "Finished."

kill -9 $SPIN_PID
