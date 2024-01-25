#!/bin/bash

echo "System Information:"
echo "-------------------"

echo "Hostname: $(hostname)"
echo "Kernel Version: $(uname -r)"

if [ -e /etc/os-release ]; then
  echo "Operating System: $(awk -F= '/^ID=/{print $2}' /etc/os-release)"
else
  echo "Operating System information not available."
fi

echo "CPU Architecture: $(uname -m)"
echo "CPU Model: $(lscpu | awk '/Model name/ {for (i=3; i<=NF; i++) print $i}')"
echo "Available Memory: $(free -h | awk '/^Mem/ {print $2}')"
echo "Disk Space: $(df -h / | awk 'NR==2 {print $2}')"

echo "-------------------"
