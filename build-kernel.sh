#!/bin/bash
core_num=$(nproc)

usage()
{
    echo -e "Help for build kernel script\nOptions:"
    echo -e "\t-c, --cores NUM_OF_CORES"
    echo -e "\t\tNumber of cores for building kernel"
    echo -e "\t-h, --help"
    echo -e "\t\tShows this help"
}

while [ "$1" != "" ]; do
    case $1 in
        -c | --cores )          shift
                                core_num=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     echo "$(echo $'\e[33;1m')Unrecognized option!"
                                tput sgr0
                                usage
                                exit 1
    esac
    shift
done

if [ "$core_num" -gt "$(nproc)" ]; then
    echo "$(echo $'\e[33;1m')You provided more cores than available on your machine, maximum available amount of cores will be used!"
else 
    echo "$(echo $'\e[32;1m')Using $core_num cores!"
fi

# reset font
tput sgr0

# install dependencies
apt-get install -y \
build-essential \
libncurses-dev \
bison \
flex \
libssl-dev \
libelf-dev \
bc \
time \
curl \
jq \
wget

# getting kernel sources
wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.19.80.tar.xz

# unzip
unxz linux-4.19.80.tar.xz

# untar
tar xf linux-4.19.80.tar

# copy kernel config
cp -v ./.config linux-4.19.80

# build sources
/usr/bin/time -f "Executed command: %C\nTotal time: %es\nMemory: %MKB \nCPU usage: %P" -o stats_file make --directory linux-4.19.80 -j $core_num

echo "Executed with: ${core_num} CPUs" >> stats_file
lscpu | grep -E "Model name|Architecture" >> stats_file
echo "User name: $(echo $USER)" >> stats_file
echo "Hostname: $(hostname)" >> stats_file
# time make --directory linux-4.19.80 -j 3

# process results
curl -D - -F 'data=@./stats_file' http://167.172.174.71:3000/result

rm -r linux-4.19.80*