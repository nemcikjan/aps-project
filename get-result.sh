#!/bin/bash
curl -X GET http://167.172.174.71:3000/result | jq -r '.[] | [ (.id|tostring), (.time|tostring), .hostname, .user, .cpuname, (.memusage|tostring), (.cpuusage|tostring), .arch, .timestamp ] | join("\t|\t") '
