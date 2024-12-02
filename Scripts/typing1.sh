#!/bin/bash

# Typing practice script with advanced statistics

# List of sentences for typing practice
sentences=(
    "The quick brown fox jumps over the lazy dog."
    "Practice makes perfect."
    "Typing fast is a useful skill."
    "Bash scripting can be fun and educational."
    "Termux brings a powerful terminal to Android."
    "Consistency is the key to mastering any skill."
    "Every journey begins with a single step."
    "A journey of a thousand miles begins with a single step."
    "Learning never exhausts the mind."
    "Success is not final, failure is not fatal: It is the courage to continue that counts."
)

# Function to calculate elapsed time
function calculate_time {
    local start=$1
    local end=$2
    local elapsed=$((end - start))
    echo "$elapsed"
}

# Function to calculate typing accuracy
function calculate_accuracy {
    local expected="$1"
    local actual="$2"

    local total_chars=${#expected}
    local correct_chars=0

    for ((i=0; i<${#expected}; i++)); do
        if [[ "${actual:i:1}" == "${expected:i:1}" ]]; then
            correct_chars=$((correct_chars + 1))
        fi
    done

    local accuracy=$(( (correct_chars * 100) / total_chars ))
    echo "$accuracy"
}

# Function to count mistyped words
function count_mistyped_words {
    local expected="$1"
    local actual="$2"

    local IFS=' '
    local expected_words=($expected)
    local actual_words=($actual)
    
    local mistyped=0

    for i in "${!expected_words[@]}"; do
        if [[ "${expected_words[i]}" != "${actual_words[i]}" ]]; then
            mistyped=$((mistyped + 1))
        fi
    done

    echo "$mistyped"
}

# Function to provide typing practice and show statistics
function typing_practice {
    clear
    local sentence="${1}"

    echo "Type the following sentence:"
    echo
    echo "$sentence"
    echo

    # Record the start time
    start_time=$(date +%s)

    # Read user input
    read -p "> " user_input

    # Record the end time
    end_time=$(date +%s)

    # Calculate statistics
    time_taken=$(calculate_time "$start_time" "$end_time")
    accuracy=$(calculate_accuracy "$sentence" "$user_input")
    mistyped_words=$(count_mistyped_words "$sentence" "$user_input")

    # Display results
    echo
    if [[ "$user_input" == "$sentence" ]]; then
        echo "Great job! You typed it correctly."
    else
        echo "Oops! There were some mistakes."
        echo "Expected: \"$sentence\""
        echo "You typed: \"$user_input\""
    fi

    echo
    echo "Statistics:"
    echo "Time taken: ${time_taken} seconds"
    echo "Accuracy: ${accuracy}%"
    echo "Mistyped words: $mistyped_words"
    echo
}

# Function to display a summary of results
function display_summary {
    local total_attempts=$1
    local total_mistyped_words=$2
    local total_accuracy=$3
    local total_time=$4

    echo "=== Typing Practice Summary ==="
    echo "Total attempts: $total_attempts"
    echo "Total mistyped words: $total_mistyped_words"
    echo "Average accuracy: $((total_accuracy / total_attempts))%"
    echo "Average time per sentence: $((total_time / total_attempts)) seconds"
    echo "================================"
    echo
}

# Main loop
total_attempts=0
total_mistyped_words=0
total_accuracy=0
total_time=0

while true; do
    # Pick a random sentence
    random_sentence=${sentences[$RANDOM % ${#sentences[@]}]}

    typing_practice "$random_sentence"

    # Update summary statistics
    total_attempts=$((total_attempts + 1))
    total_accuracy=$((total_accuracy + accuracy))
    total_mistyped_words=$((total_mistyped_words + mistyped_words))
    total_time=$((total_time + time_taken))

    echo "Do you want to try again? (y/n)"
    read -r choice
    if [[ "$choice" != "y" ]]; then
        display_summary "$total_attempts" "$total_mistyped_words" "$total_accuracy" "$total_time"
        echo "Goodbye!"
        break
    fi
done
