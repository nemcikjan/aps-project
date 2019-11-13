#!/bin/bash
core_num=$(nproc)

if [ "$1" != "" ]; then
    core_num=$1
fi

/usr/bin/time -f "Executed command: %C\nTotal time: %es\nMemory: %MKB \nCPU usage: %P" -o stats_file make --directory linux-4.19.80 -j $core_num

# echo "Executed with ${core_num} CPUs" >> stats_file
lscpu | grep -E "Model name|Architecture" >> stats_file
echo "Username: $(echo $USER)" >> stats_file
echo "Hostname: $(hostname)" >> stats_file

# /bin/bash
# process results
curl -D - -F 'data=@./stats_file' http://167.172.174.71:3000/result