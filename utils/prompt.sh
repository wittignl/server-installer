#!/bin/bash

# Simple utility function to prompt for yes/no questions
prompt_yes_no() {
  local prompt="$1"
  local response

  while true; do
    read -p "$prompt [y/n]: " response
    case $response in
      [Yy]* ) return 0;;  # Return success (true)
      [Nn]* ) return 1;;  # Return failure (false)
      * ) echo "Please answer yes (y) or no (n).";;
    esac
  done
}