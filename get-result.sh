#!/bin/bash
format="json"
filter=$(echo $USER)
t="last"

usage()
{
    echo -e "Help for get results script. This script be default returns user specific test results in json format. If both -a|--all and -u|--user are used, specific USER will be ignored\nOptions:"
    echo -e "\t-f, --format FORMAT"
    echo -e "\t\tSupported formats: json, table (default is json)"
    echo -e "\t-a, --all"
    echo -e "\t\tGets all results and has priority before -t|--timestamp and -u|--user"
    echo -e "\t-u, --user USER"
    echo -e "\t\tGets results for specific user. If -a|--all is entered, -u|--user will be ignored"
    echo -e "\t-t, --timestamp [last|all]"
    echo -e "\t\tGets either last or all results for given user or in general (default last). If -a or --all is entered, -t|--timestamp will be automatically last"
    echo -e "\t-h, --help"
    echo -e "\t\tShows this help"
}

us() 
{
if [ "$filter" != "all" ]; then
    filter=$1
fi
}
while [ "$1" != "" ]; do
    case $1 in
        -f | --format )         shift
                                format=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        -a | --all )            filter="all"
                                ;;
        -u | --user )           shift
                                us $1
                                ;;
        -t | --timestamp )      shift
                                t=$1
                                ;;                  
        * )                     echo "$(echo $'\e[33;1m')Unrecognized option!"
                                tput sgr0
                                usage
                                exit 1
    esac
    shift
done

if [ "$format" != "json" ] && [ "$format" != "table" ]; then
    echo "$(echo $'\e[33;1m')Unsupported format! Format json will be used."
    format=json
    tput sgr0
fi

if [ "$filter" == "all" ]; then
    t="all"
fi

curl="curl -sX GET http://167.172.174.71:3000/result/$(echo $filter)/$(echo $t)"
echo "Getting results..."
if [ "$format" == "json" ]; then
    $curl | jq .
else
    echo -e "ID\t|\tExecution time\t|\tHost\t|\tUser\t|\tCPU model\t|\tMemory usage in KB\t|\tCPU usage in %\t|\tVM Architecture\t|\tTimestamp\t" 
    $curl | jq -r '.[] | [ (.id|tostring), (.time|tostring), .hostname, .username, .cpuname, (.memusage|tostring), (.cpuusage|tostring), .arch, .timestamp ] | join("\t|\t") '
fi
