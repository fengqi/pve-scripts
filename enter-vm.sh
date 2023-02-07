#!/bin/bash

set -u
name=$1
if [ "$name" -gt 0 ] 2>/dev/null ;then 
    lxc-attach $name
    exit 0
else
    id=$(pvesh get /nodes/pve/lxc|grep running|grep $name|awk '{print $4}'|head -1)
    if [ -n "$id" ]; then
        lxc-attach $id
        exit 0
    fi

    name=$(qm list|grep running|grep $name|awk '{print $2}'|head -1)
    user=root
    if [ -n "$name" ]; then
        if [ "$name" = "work" ];then
            user=ubuntu
        fi
        if [ "$name" = "dsm" ];then
            user=admin
        fi
        ssh -o StrictHostKeyChecking=no $user@$name
        exit 0
    fi
fi

echo 'lxc and vm not exist or stopped'

