#!/bin/bash

#Author: Toroyteach
#Description: Use this script to find a way to add
## spinner like progress or any kind of progress to 
## to have something like a feedback to the user

# Start time
start_time=$(date +%s)

echo "Initialize Error Log:" >"$ERROR_LOG"
echo "Initialize Duplicate Logs:" >"$DUPLICATE_LOG"
echo "Initialize Other Error Logs:" >"$OTHER_ERROR_LOG"

echo -e "\nStarted at: $(date -r $start_time '+%Y-%m-%d %H:%M:%S')\n"

spin() {
    local spinner="/|\\-/|\\-"
    local start_time=$(date +%s)
    while :; do
        for i in $(seq 0 7); do
            local current_time=$(date +%s)
            local elapsed_time=$((current_time - start_time))
            local hours=$((elapsed_time / 3600))
            local minutes=$(((elapsed_time % 3600) / 60))
            local seconds=$((elapsed_time % 60))

            printf "\r%s %02d:%02d:%02d" "${spinner:$i:1}" $hours $minutes $seconds
            sleep 1
        done
    done
}

tput civis
# Start the Spinner:
spin &
# Make a note of its Process ID (PID):
SPIN_PID=$!
# Kill the spinner on any signal, including our own exit.
trap "kill -9 $SPIN_PID" $(seq 0 15)

## make a web call or anything that will take time to finish
sleep 10


##Return the cursor and others
tput cnorm

end_time=$(date +%s)
elapsed_time=$((end_time - start_time))
echo -e "\n\nFinished at: $(date -r $end_time '+%Y-%m-%d %H:%M:%S')"
echo -e "\nElapsed time: $(printf "%02d:%02d:%02d\n" $((elapsed_time / 3600)) $(((elapsed_time % 3600) / 60)) $((elapsed_time % 60)))"
