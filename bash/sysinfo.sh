#!/bin/bash
#The purpose of this script is to display some important identity information about a computer so that you can see that information quickly and concisely,
# without having to enter multiple commands or remember multiple command options. It is a typical script in that it is intended to be useful,
# time and labour saving, and easily used by any user of the computer regardless of whether they know or understand any of the commands in your script.
# Your output does not need to be fancy or concise for this first script as we will be improving the output in the next lab.
# Each output item needs to be labelled. The following output information is required:

# 1. The system’s fully-qualified domain name (FQDN), e.g. myvm.home.arpa from a command such as hostname
# 2. The operating system name and version, identifying the Linux distro in use from a command such as hostnamectl
# 3. Any IP addresses the machine has that are not on the 127 network (do not include ones that start with 127) from a command such as hostname
# 4. The amount of space available in only the root filesystem, displayed as a human-friendly number from a command such as df

#need Root privilege, check for it
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for this script to work,"
       	echo "consider using sudo"
	exit 1
	fi
#gathering of data
mydate="$(date +%F)"
computermodel="$(lshw -class system| grep description: | sed 's/ *description: *//')"
cpumodel="$(lscpu | grep 'Model name:'| sed 's/.*Model name: *//')"
source /etc/os-release
#FQDN=$(hostname -f)
#myip=$(hostname -I)
#echo FQDN: $FQDN

#echo Host Information:
#hostnamectl

#echo IP Addresses: $myip
#Command for showing all ip including loopback: ip a s|grep -w inet|awk {print $2}

#echo Root FileSystem Status
#df / -h
#start of report

cat <<EOF
System Report produced be $USER on $mydate

System Description
------------------
Computer Model: $computermodel

CPU Info
-----------------
Model: $cpumodel

Operating System
----------------
OS: $PRETTY_NAME

EOF
