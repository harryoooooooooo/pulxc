#!/usr/bin/env bash

set -e
source /etc/pulxc/pulxc.conf
for cgroup in "$CGROUP"/*
do
    echo "$cgroup"
    if [[ "$cgroup" == "$CGROUP/systemd" ]] || [[ "$cgroup" == "$CGROUP/unified" ]]
    then
        continue
    fi
    echo $$ > "$cgroup"/pulxc/tasks
done
echo "cgroup info:"
cat /proc/self/cgroup
/usr/bin/lxc-start -P "$BASE_PATH/lxc" -n "$1"
