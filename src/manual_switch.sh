#!/bin/bash
#description: switch network to an avaliable one
#author: haicheng.bi

# reload net
sudo nmcli con reload ens33

function echo_with_date {
    current_date=`date +"%Y-%m-%d %T"`
    echo "[$current_date] $1"
}

function restart_net {
    echo_with_date "restarting net..."
    nmcli n off
    sleep 1s
    nmcli n on
}

netstatus=$(nmcli general status | awk 'NR > 1 { print $2 }')
ifcfg_path="/etc/sysconfig/network-scripts/ifcfg-有线连接_1"
ip=$(sed -n 's/IPADDR=\(.*\)/\1/p' $ifcfg_path)
gateway=$(sed -n 's/GATEWAY=\(.*\)/\1/p' $ifcfg_path)


if [ "$ip" == "192.168.124.63" ] && [ "$gateway"  == "192.168.124.1" ]
then
    target_ip="192.168.31.63"
    target_gate="192.168.31.1"
else
    target_ip="192.168.124.63"
    target_gate="192.168.124.1"
fi

echo_with_date "$ip NETWORK STATUS $netstatus  !"
if [ "$netstatus" == "无" ] || [ "$netstatus" == "受限" ]
then
    echo_with_date "switching to $target_ip"
    sudo sed -i "s/$ip/$target_ip/g" $ifcfg_path
    sudo sed -i "s/$gateway/$target_gate/g" $ifcfg_path

    # systemctl restart network
    sudo ifdown ens33
    sleep 2s
    sudo ifup ens33

    result=$(ifconfig ens33 | grep "$target_ip")
    echo_with_date "$result"
else
    pingret=$(ping -c 1 114.114.114.114 | sed -n 's/.* Destination Host \(.*\)/\1/p')
    echo_with_date "ping ret $ip $pingret"
    if [ "$ip" == "192.168.31.63" ] && [ "$pingret" == "Unreachable" ]
    then
        restart_net
    fi
fi


