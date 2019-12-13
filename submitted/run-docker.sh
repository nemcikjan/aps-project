#!/bin/bash

core_num=$(nproc)
memory=$(cat /proc/meminfo | head -1 | grep -oP '\d+(?= kB)')
results="auto"

# calc()
# { 
#     awk "BEGIN { print "$*" }"; 
# }
# check_docker()
# {
#     docker -v
#     if [$(cat err) != "0"]; then
#         echo -e "$(echo $'\e[31;1m')Docker is not installed on your machine!\nIn order beeing able to run this script, please refer to this website https://docs.docker.com/v17.09/engine/installation/ for installation information."
#     fi
#     rm err
#     tput sgr0
# }

usage()
{
    echo -e "Help for docker build kernel script\nOptions:"
    echo -e "\t-c, --cores NUM_OF_CORES"
    echo -e "\t\tNumber of cores for building kernel"
    echo -e "\t-m, --memory MEM_SIZE"
    echo -e "\t\tMemory size used for building kernel"
    echo -e "\t-r, --results [auto|load]"
    echo -e "\t\tTells, if user wants to get results automatically after kernel build or manually (default auto)"
    echo -e "\t-h, --help"
    echo -e "\t\tShows this help"
}

# check_docker

while [ "$1" != "" ]; do
    case $1 in
        -c | --cores )          shift
                                core_num=$1
                                ;;
        -m | --memory )         shift
                                memory=$1
                                ;;
        -r | --results )        shift
                                results=$1
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

if [ "$memory" -gt "$(cat /proc/meminfo | head -1 | grep -oP '\d+(?= kB)')" ]; then
    echo "$(echo $'\e[33;1m')You provided more memory than available on your machine, maximum available amount of memory will be used!"
else 
    echo "$(echo $'\e[32;1m')Using $memory size!"
fi

if [ "$results" != "auto" ] && [ "$results" != "load" ]; then
    echo "$(echo $'\e[33;1m')You provided unsupperted value for getting results. Value auto will be used!"
    results="auto"
fi

tput sgr0

docker run -it --cpus=$(echo $core_num) -m $(echo $memory)m jany15/aps:latest $core_num

container_pid=$(docker ps -a | head -2 | tail -1 | awk '{print $1}')

# docker cp $container_pid:/stats_file stats_file_docker

echo "Stopping container $container_pid"
docker container stop $container_pid

echo "Removing container $container_pid"
docker container rm $container_pid

# process results

if [ "$results" == "auto" ]; then
    ./get-result.sh -u docker -t last --host $container_pid
else
    echo "If you want to get results of recently executed kernel build in docker container run ./get-result.sh -u docker -t last --host $(echo $container_pid) or run ./get-result.sh for other help"
fi