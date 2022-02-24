#!/bin/bash

cd /etc/pve/nodes/pve/lxc
for conf in `ls`;do
    id=$(echo $conf|awk -F '.' '{print $1}')
    name=$(cat $conf|grep hostname|awk '{print $2}')
    mac=$(cat $conf|grep 'net0:'|awk -F '[=,]' '{print $8}')

    echo "config host"
    echo -e "\toption name '${name}'"
    echo -e "\toption dns '1'"
    echo -e "\toption mac '${mac}'"
    echo -e "\toption ip '192.168.50.${id}'"
    echo -e ""
done

cd /etc/pve/qemu-server
for conf in `ls`;do
    id=$(echo $conf|awk -F '.' '{print $1}')
    name=$(cat $conf|grep name|awk '{print $2}')
    mac=$(cat $conf|grep 'net0:'|awk -F '[,=]' '{print $2}')
    
    echo "config host"
    echo -e "\toption name '${name}'"
    echo -e "\toption dns '1'"
    echo -e "\toption mac '${mac}'"
    echo -e "\toption ip '192.168.50.${id}'"
    echo -e ""
done

