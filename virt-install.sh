cpus=2
memory=2048
disk_size=12

usage()
{
    echo -e "Help for installing Debian 10 KVM Virtual machine via virt installer\nOptions:"
    echo -e "\t--cpus NUM_OF_CPUS"
    echo -e "\t\tNumber of cpus for vitual machine (default 2)"
    echo -e "\t--memory MEMORY_SIZE"
    echo -e "\t\tAmount of memory size in MB (default 2048)"
    echo -e "\t--size DISK_SIZE"
    echo -e "\t\tDisk size in GB (default 12)"
    echo -e "\t-h, --help"
    echo -e "\t\tShows this help"
}

while [ "$1" != "" ]; do
    case $1 in
        --cpus )                shift
                                cpus=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        --memory )              shift
                                memory=$1
                                ;;
        --size )                shift
                                disk_size=$1
                                ;;                       
        * )                     echo "$(echo $'\e[33;1m')Unrecognized option!"
                                tput sgr0
                                usage
                                exit 1
    esac
    shift
done

if [ "$disk_size" -lt "12" ]; then
    echo "$(echo $'\e[33;1m')Disk size cannot be less than 12GB!"
    disk_size=12
    tput sgr0
fi

wget https://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-10.1.0-i386-netinst.iso

virt-install \
      --name aps-vm \
      --ram $memory \
      --vcpus $cpus \
      --disk size=$disk_size \
      --cdrom ./debian-10.1.0-i386-netinst.iso