#!/bin/bash

core_num=$(nproc)
memory=$(cat /proc/meminfo | head -1 | grep -P '\d+(?= kB)')

check_docker()
{
    docker -v
    if [$(echo $?) != "0"]; then
        echo -e "$(echo $'\e[31;1m')Docker is not installed on your machine!\nIn order beeing able to run this script, please refer to this website https://docs.docker.com/v17.09/engine/installation/ for installation information."
    fi
    tput sgr0
    exit 1
}

usage()
{
    echo -e "Help for build kernel script\nOptions:"
    echo -e "\t-c, --cores NUM_OF_CORES"
    echo -e "\t\tNumber of cores for building kernel"
    echo -e "\t-m, --memory MEM_SIZE"
    echo -e "\t\tMemory size used for building kernel"
    echo -e "\t-h, --help"
    echo -e "\t\tShows this help"
}

check_docker

while [ "$1" != "" ]; do
    case $1 in
        -c | --cores )          shift
                                core_num=$1
                                ;;
        -m | --memory )         shift
                                memory=$1
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

if [ "$memory" -gt "$(cat /proc/meminfo | head -1 | grep -P '\d+(?= kB)')" ]; then
    echo "$(echo $'\e[33;1m')You provided more memory than available on your machine, maximum available amount of memory will be used!"
else 
    echo "$(echo $'\e[32;1m')Using $memory size!"
fi

container_pid=$(docker run --cpus=$nproc -m ${memory}m -it aps:latest $nproc)

docker cp $container_pid:/stats_file stats_file_docker

docker container stop $container_pid

docker container rm $container_pid

# process results