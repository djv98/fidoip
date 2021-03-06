#!/bin/sh
#/* Copyright (C) 2007-2012 Maxim Sokolsky, 2:5020/828.777.
#   This file is part of fidoip. It is free software and it is covered
#   by the GNU general public license. See the file LICENSE for details. */

#! This script will setup fidoip binaries without compiliation for you computer
CWD=`pwd`
OSNAME=`uname`
USERNAME=`whoami`
UNAME=`uname -m`

T1="root"
T2="Linux"

if [ "$T1" = "$USERNAME" ]; then
echo  ''
else
echo 'Please run this script as root' ; exit
fi

if [ "$T2" = "$OSNAME" ]; then
echo  ''
else
echo 'This script is intended to run only on Linux' ; exit
fi

##  make sure libarchve archiver available
bsdloc=`which wget`

if [ -x "$bsdloc" ]
then
    echo "wget utility found: $bsdloc"
else
    echo "WARNING: wget not found."
    echo "So it will not be possible to download fidoip binary on this machine."
    echo " Please install wget package from you repository"
    echo " as described in fidoip.rus.* files."
    exit
fi
echo ""
echo "-----------------------------------"

echo
echo "Are you sure to install fidoip from binary file?"
echo "[y/n]"
read reply
echo ""  
if [ "$reply" = "y" ];
        then 

rm -f fidoip-1.0.5.5-x86_64-1.tgz
rm -f fidoip-1.0.5.5-i486-1.tgz

if [ "$UNAME" = "x86_64" ]; then
echo  'Extracting binary for x86_64 platform'
#cp $CWD/lnx-packages/64bit/deb/fidoip_1.0.5-4_amd64.deb /tmp
wget -c http://falcony.googlecode.com/svn/tags/fidoip-1.0.5.5-x86_64-1.tgz
#ar x fidoip_1.0.5-4_amd64.deb
#tar -xzpf /tmp/data.tar.gz -C /
set -e
tar -xzpf fidoip-1.0.5.5-x86_64-1.tgz -C /
rm -rf /install
else
echo  "Extracting binary for "$UNAME" platform"
#cp $CWD/lnx-packages/32bit/deb/fidoip_1.0.5-4_i386.deb /tmp
#ar x fidoip_1.0.5-4_i386.deb
#tar -xzpf /tmp/data.tar.gz -C /
wget -c http://falcony.googlecode.com/svn/tags/fidoip-1.0.5.5-i486-1.tgz
set -e
tar -xzpf fidoip-1.0.5.5-i486-1.tgz -C /
rm -rf /install
fi



echo "fidoip binaries installed to /usr/local"
echo "Then run ./setup_config.bash for point install"
echo "or run ./setup_node.bash for node install."

elif [ "$reply" = "n" ];
        then 
echo "fidoip binaries not installed"

fi

