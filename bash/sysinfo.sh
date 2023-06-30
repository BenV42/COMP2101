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

#Need Root privilege, check for it
if [ "$(id -u)" != "0" ]; then
	echo "You need to be root for this script to work,"
       	echo "consider using sudo"
	exit 1
	fi
#Variables
source reportfunctions.sh

#Report without Command Arguements
while [ $? -eq 0 ]; do
        computerreport
        cpureport
        osreport
        ramreport
        videoreport
        diskreport
        networkreport
        exit 0
done

#Loop for checking command arguments
while [ $# -gt 0 ]; do
	case "$1" in
	-h | --help )
		echo "Usage: $(basename $0) [-h|--help] displays this message and other possible command arguments"
		echo "Commands: -v for verbosely which shows all commands and errors to the user"
		echo "		-s or --system to run the report with only the computerreport, osreport, cpureport, ramreport, and videoreport"
		echo "		-d or --disk only runs the disk report"
		echo "		-n or --network only runs the network report"
		exit
		;;
	-s | --system )
		computerreport
                cpureport
                osreport
                ramreport
                videoreport
                exit 0
                ;;
	-v | --verbosely )
		set -x
		computerreport
		cpureport
		osreport
		ramreport
		videoreport
		diskreport
		networkreport
		exit 0
		;;
	-d | --disk )
		diskreport
		exit 0
		;;
	-n | --network )
		networkreport
		exit 0
		;;
	* )
		echo "Unrecognized argument '$1'"
		exit 1
		;;
	esac
	shift
done
#Error message saving with the function error message
if [ $? -ne 0 ]; then
	errormessage
	exit 1
	fi
