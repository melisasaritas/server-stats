#!/bin/bash

echo "==================== Server Performance Stats ===================="

# 1. Total CPU usage
echo "CPU Usage:"
mpstat | grep -A 5 "%idle" | tail -n 1 | awk '{print "CPU Usage: " 100-$12"%"}'
echo

# 2. Total memory usage (Free vs Used including percentage)
echo "Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB (%.2f%%), Free: %sMB (%.2f%%)\n", $3, $3*100/$2, $4, $4*100/$2}'
echo

# 3. Total disk usage (Free vs Used including percentage)
echo "Disk Usage:"
df -h --total | grep 'total' | awk '{printf "Used: %s, Free: %s, Percentage Used: %s\n", $3, $4, $5}'
echo

# 4. Top 5 processes by CPU usage
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,ppid,cmd,%cpu --sort=-%cpu | head -6
echo

# 5. Top 5 processes by memory usage
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,ppid,cmd,%mem --sort=-%mem | head -6
echo

# Optional: Additional stats
echo "==================== Additional Stats ===================="

# 6. OS Version
echo "Operating System Version:"
cat /etc/os-release | grep -w 'PRETTY_NAME' | cut -d= -f2 | tr -d '"'
echo

# 7. Uptime
echo "Uptime:"
uptime -p
echo

# 8. Load average
echo "Load Average:"
uptime | awk -F'load average:' '{ print $2 }'
echo

# 9. Logged in users
echo "Logged in Users:"
who | wc -l
echo

echo "=================================================================="
