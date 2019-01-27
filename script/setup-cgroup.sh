#!/usr/bin/env bash

set -e
source /etc/pulxc/pulxc.conf
for cgroup in "$CGROUP"/*
do
    if [[ "$cgroup" == "/sys/fs/cgroup/systemd" ]] || [[ "$cgroup" == "/sys/fs/cgroup/unified" ]]
    then
        continue
    fi
    echo "adding subcontroller in $cgroup"
    mkdir -p "$cgroup/pulxc"
    chown -R $USER:$USER "$cgroup/pulxc"
done

#Change these as your system hardware!
echo "$CGROUP_CPUSET_CPUS" > "$CGROUP"/cpuset/pulxc/cpuset.cpus
echo "$CGROUP_CPUSET_MEMS" > "$CGROUP"/cpuset/pulxc/cpuset.mems
