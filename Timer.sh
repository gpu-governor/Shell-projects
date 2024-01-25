#!/bin/bash

prompt() {
    echo "==========TIMER=========="
    echo "Set timer in :"
    echo "1. hours"
    echo "2. minutes"
    echo "3. seconds"
    read -r option

    if [ "$option" -eq 1 ]; then
        echo "Enter your time in hours"
        read -r T
        T_S=$((60 * 60 * T)) # converting time to seconds
    elif [ "$option" -eq 2 ]; then
        echo "Enter your time in minutes"
        read -r T
        T_S=$((60 * T)) # Converting time to seconds
    elif [ "$option" -eq 3 ]; then
        echo "Enter your time in seconds"
        read -r T
        T_S="$T"
    else 
        echo "Invalid option"
        return 1
    fi
    
    for ((i=T_S; i>=0; i--)); do
        echo "Timer: $i seconds left"
        sleep 1
    done

    echo "Timer done!"
}

prompt
