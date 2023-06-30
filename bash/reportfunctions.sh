#!/bin/bash
source /etc/os-release
export PATH=$PATH:/COMP2101/bash
#System
computermodel="$(lshw -c system| grep description: | sed 's/ *description: *//')"
computermanufacturer="$(lshw -c system| grep -m 1 vendor: | sed 's/ *vendor: *//')"
computerserial="$(lshw -c system | grep serial: | sed 's/ *serial: *//')"

#CPU
cpumodel="$(lscpu | grep 'Model name:'| sed 's/.*Model name: *//')"
cpuvendor="$(lscpu | grep 'Vendor ID:'| sed 's/.*Vendor ID: *//')"
cpuarch="$(lscpu | grep 'Architecture:'| sed 's/.*Architecture: *//')"
cpucore="$(nproc --all)"
cpuspeed="$(lshw -c cpu | grep -m 1 'capacity:' | sed 's/.*capacity: *//')"
cpu_L1="$(lscpu | grep -m 1 L1[*]| sed 's/.*L1[*] *//')"
cpu_L2="$(lscpu | grep 'L2 cache:'| sed 's/.*L2 cache: *//')"
cpu_L3="$(lscpu | grep 'L3 cache:'| sed 's/.*L3 cache: *//')"

#Network
FQDN="$(hostname -f)"
myip="$(hostname -I)"
hostinfo="$(hostnamectl)"
linkstate="$(ip link show | grep 'state'| sed 's/.*state *//' | grep -m 1 'UP')"

#Video Card Report
videocard="$(lshw -C display | sed 's/.*display *//')"

#Ram Report
ramuseage="$(free -th)"
rammanufacturer="$(dmidecode --type memory | grep -m 1 'Manufacturer:' | sed 's/. *Manufacturer: *//')"
ramspeed="$(dmidecode --type memory | grep -m 1 'Current Speed:' | sed 's/. *Current Speed: *//')"

#Disk Report
maindisk="$(df / -h)"
otherdisks="$(df -h)"

#Variables
lscpu | $mycpu
mydate="$(date +%F)"

#Report Split into Functions
#System Function
function computerreport {
cat <<EOF
System Report produced be $USER on $mydate
-------------------
System Description
-------------------
Computer Model: $computermodel
Manufacturer: $computermanufacturer
Serial Number: $computerserial

EOF
}

#CPU function
function cpureport {
cat <<EOF
---------
CPU Info
---------
Model: $cpumodel
Manufacturer: $cpuvendor
Architecture: $cpuarch
Core count: $cpucore
CPU maximum speed: $cpuspeed
Caches: KiB = Kilobytes | MiB = Megabytes
        L1: $cpu_L1
        L2: $cpu_L2
        L3: $cpu_L3

EOF
}

#OS Function
function osreport {
cat <<EOF
-----------------
Operating System
-----------------
OS: $NAME
Version: $VERSION

EOF
}

#Video Card Function
function videoreport {
cat <<EOF
------------------
Video Card Report
------------------
Video Card: $videocard

EOF
}

#RAM Report
function ramreport {
cat <<EOF
----------------
RAM Report
----------------
Ram Manufacturer: $rammanufacturer
Ram Current Speed: $ramspeed
Memory Useage: Mi = Megabytes | Gi = Gigabytes
$ramuseage


EOF
}

#Network Function
function networkreport {
cat <<EOF
-----------------
Network and IP
-----------------
IP Addresses: $myip
FQDN: $FQDN
Link State: $linkstate
$hostinfo

EOF
}

#Disk Report Function
function diskreport {
cat <<EOF
----------------------
Root FileSystem Status
----------------------
Main Disk:
$maindisk
Other Disks:
$otherdisks

EOF
}

#Error Message Function
function errormessage {
cat <<EOF
--------------------------------
Script Has Encountered An Error
--------------------------------
The error is saved 'in' /var/log/systeminfo.log

EOF
2>>/var/log/systeminfo.log
2> >(logger -t $(basename "$0") -i -p user.warning)
}
