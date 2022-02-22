#!/bin/sh
#/* Copyright (C) 2007-2012 Maxim Sokolsky, 2:5020/828.777.
#   This file is part of fidoip. It is free software and it is covered
#   by the GNU general public license. See the file LICENSE for details. */

# Usage:  fido_linux_koi.sh login
CWD=`pwd`
OSNAME=`uname`
USERNAME=`whoami`
date=`date +%Y%m%d%m%s`
shortdate=`echo ${date} | sed s/^...//`
shortname=fidoip_configs_${shortdate}.tar

T1="root"
T2="Linux"

if [ ! -z "$2" ]; then
echo "Use 1 argument only. Usage: fido_linux_koi.sh login" ; exit
fi

if [ ! -z "$1" ]
then
VAR_01=$1
else
  echo " To setup fidoip you need type you login name as argument. Usage: fido_linux_koi.sh login" ; exit
fi

echo ""
if [ -e /home/$VAR_01  ]; then
echo  "Found /home/"$VAR_01" home directory of user "$VAR_01""
else
echo "Home directory of user "$VAR_01" doesn't exist. If your login is "$VAR_01" then your home directory should be in /home/"$VAR_01"." ; exit
fi

if [ "$T1" = "$USERNAME" ]; then
echo  ''
else
echo 'Please run this script as root' ; exit
fi

if [ "$T2" = "$OSNAME" ]; then
echo  ''
else
echo 'Please run this script on a Linux' ; exit
fi

f1()

{

if [ -e /usr/local/etc/binkd.cfg ]; then
echo '-----------------------------------------------------------'
echo 'Found your configuration files, saving to file:'
echo ''
echo $CWD/$shortname
echo ''
echo '-----------------------------------------------------------'
echo ''
tar -cf $CWD/$shortname /usr/local/etc /usr/local/bin/{recv,send} > /dev/null 2>&1

if [ -e /usr/local/sbin/recv ]; then
	rm /usr/local/sbin/recv
fi

if [ -e /usr/local/sbin/send ]; then
	rm /usr/local/sbin/send
fi

if [ -e /usr/local/sbin/ge ]; then
	rm /usr/local/sbin/ge
fi

if [ -e /usr/local/sbin/g ]; then
	rm /usr/local/sbin/g
fi

if [ -e /usr/local/sbin/gl ]; then
	rm /usr/local/sbin/gl
fi

if [ -e /home/fido/inbound ]; then
        rm -r /home/fido/inbound
fi
if [ -e /home/fido/inbound/temp ]; then
        rm -r /home/fido/inbound/temp
fi
if [ -e /home/fido/inbound/local ]; then
        rm -r /home/fido/inbound/local
fi
if [ -e /home/fido/outbound/temp ]; then
        rm -r /home/fido/outbound/temp
fi



sleep 5 
fi

echo '-------------------------------------------------------------------'
echo "Checking whether some necessary packages installed on this mashine:"
echo '-------------------------------------------------------------------'
sleep 3
echo ""

##  make sure unzip extractor available

unziploc=`which unzip`

if [ -x "$unziploc" ]
then
    echo "unzip extractor found: $unziploc"
else
    echo "WARNING: unzip not found."
    echo "So it will not be possible to extract fidoip on this machine."
    echo " You should take steps to get unzip installed,"
    echo " as described in fidoip.rus.* files."
    exit
fi
echo ""
echo "-----------------------------------"

##  make sure zip archiver available
ziploc=`which zip`

if [ -x "$ziploc" ]
then
    echo "zip packer found: $ziploc"
else
    echo "WARNING: zip not found."
    echo "So it will not be possible to pack fido packets on this machine."
    echo " You should take steps to get zip installed,"
    echo " as described in fidoip.rus.* files."
    exit
fi
echo ""
echo "-----------------------------------"

##  make sure bzip2 archiver available
bzip2loc=`which bzip2`

if [ -x "$bzip2loc" ]
then
    echo "bzip2 packer found: $bzip2loc"
else
    echo "WARNING: bzip2 not found."
    echo "So it will not be possible extract fidoip sources on this machine."
    echo " You should take steps to get bzip2 installed,"
    echo " as described in fidoip.rus.* files."
    exit
fi
echo ""
echo "-----------------------------------"

## make sure C compiler/linker available

gccloc=`which gcc`

if [ -x "$gccloc" ]
then
    echo "C compiler found: $gccloc"
else
    echo "WARNING: gcc not found."
    echo "So it will not be possible to compily fidoip on this machine."
    echo " You should take steps to get gcc installed,"
    echo " as described in fidoip.rus.* files."
    exit
fi

echo ""
echo "-----------------------------------"


## make sure C++ compiler/linker available

gploc=`which g++`

if [ -x "$gploc" ]
then
    echo "C++ compiler found: $gploc"
else
    echo "WARNING: C++ support for gcc not found."
    echo "So it will not be possible to compily fidoip on this machine."
    echo " You should take steps to get c++ installed,"
    echo " as described in fidoip.rus.* files."
    exit
fi

echo ""
echo "-----------------------------------"

## make sure ncurses-devel library available

if [ -e /usr/include/ncurses.h ]
then
    echo "Ncurses-devel library found: /usr/include/ncurses.h"
else
    echo "WARNING: ncurses-devel library not found."
    echo "So it may not be possible to compily GoldEd+ on this machine."
    echo " You should take steps to make ncurses-devel library be installed,"
    echo " as described in fidoip.rus.* files."
    echo " You could press Ctrl-C now to stop this script," 
    echo " if not - GoldEd+ could not be compiled."
    sleep 5 
fi

echo ""
echo "-----------------------------------"

## make sure screen available

scrloc=`which screen`

if [ -x "$scrloc" ]
then
    echo "Screen package found: $scrloc"
else
    echo "Information: Screen package not found."
    echo "You may need install it later,"
    echo "as described in fidoip.rus.* files."
    sleep 5
fi

echo ""
echo "-----------------------------------"

wgetloc=`which wget`

if [ -x "$wgetloc" ]
then
    echo "Wget package found: $wgetloc"
else
    echo "Information: Wget package not found."
    echo "You may need install it later,"
    echo "as described in fidoip.rus.* files."
    sleep 5
fi

echo ""
echo "-----------------------------------"

## make sure gettext available

if [ -e /usr/share/gettext ]
then
    echo "Gettext found: /usr/share/gettext"
else
    echo "Information: Gettext package not found."
    echo "You may need install it later,"
    echo "as described in fidoip.rus.* files."
    sleep 5
fi
echo ""
echo "-----------------------------------"


#echo ""

#echo ''
#echo '--------------------------------------------------------------'
#echo '| Starting compiling of fidoip (BinkD, Husky HPT and GoldEd+).|'
#echo '--------------------------------------------------------------'
#echo ''
#sleep 10

#cd binkd
#sh binkd.Build.64
#cd ../

#cd husky
#sh husky.Build.64
#cd ../

cd golded
sh golded.Build+.64
cd ../



echo '-----------------------------------------------------------------------------'
echo "  Creating fidoip's directories for user "$VAR_01" in /home/fido/  "
echo '-----------------------------------------------------------------------------'
echo ''


if [ -e $CWD/binkd/binkd.log ]; then
  mkdir -p /home/fido
  mkdir -p /home/fido/inbound
  mkdir -p /home/fido/inbound/unsecure
  mkdir -p /home/fido/inbound/temp
  mkdir -p /home/fido/inbound/local
  mkdir -p /home/fido/outbound
  mkdir -p /home/fido/outbound/temp
  mkdir -p /home/fido/filebox
  mkdir -p /home/fido/badarea 
  mkdir -p /home/fido/carbonarea
  mkdir -p /home/fido/msgbasedir
  mkdir -p /home/fido/netmailarea
  mkdir -p /home/fido/uudecode
  mkdir -p /home/fido/outfile
  mkdir -p /home/fido/nodelist
  mkdir -p /home/fido/2uplink
  mkdir -p /home/fido/public
  mkdir -p /home/fido/flags
  mkdir -p /home/fido/magic
  mkdir -p /home/fido/announce
  mkdir -p /home/fido/logs
 if [ -e /home/fido/logs/binkd.log ]; then
 echo ' '
 else
 cat $CWD/binkd/binkd.log > /home/fido/logs/binkd.log
 fi
fi


# Add logs for hpt:

if [ -e $CWD/husky/echotoss.log ]; then
  cat $CWD/husky/echotoss.log > /home/fido/logs/echotoss.log
fi

if [ -e $CWD/husky/import.log ]; then
   cat $CWD/husky/import.log > /home/fido/logs/import.log
fi

if [ -e $CWD/husky/htick.log ]; then
   cat $CWD/husky/htick.log > /home/fido/logs/htick.log
fi

if [ -e $CWD/husky/sqpack.log ]; then
   cat $CWD/husky/sqpack.log > /home/fido/logs/sqpack.log
fi

if [ -e /home/fido/logs/hpt.log ]; then
echo ' '
 else
 cat $CWD/husky/hpt.log > /home/fido/logs/hpt.log
fi


# Add log for golded+:

if [ -e /home/fido/logs/golded.log ]; then
  echo ' ' 	
 else 
  if [ -e $CWD/golded/golded.log ]; then
  cat $CWD/golded/golded.log > /home/fido/logs/golded.log
 fi
fi

#Linking libraries

#ln -sf /usr/local/lib/libfidoconfig.so.1.4 /lib/libfidoconfig.so.1.4
#ln -sf /usr/local/lib/libsmapi.so.2.4 /lib/libsmapi.so.2.4
#ln -sf /usr/local/lib/libfidoconfig.so /lib/libfidoconfig.so.1.4


echo '------------------------------------------------------------------'
echo 'Checking installation of additional Husky programms...'
echo '------------------------------------------------------------------'
sleep 2
echo ""


echo ""
if [ -e /usr/local/sbin/hptkill  ]; then
echo  'Found Area killing utility Husky-hptkill.'
else
echo 'Area killing utility Husky-hptkill is not installed!'
fi

sleep 1

echo ""
if [ -e /usr/local/sbin/hptsqfix  ]; then
echo  'Found Fix message base utility husky-hptsqfix.'
else
echo 'Fix message base utility husky-hptsqfix is not installed!'
fi

sleep 1

#echo ""
#if [ -e /usr/local/sbin/hpucode  ]; then
#echo  'Found UUE message base scanning utility husky-hpucode.'
#else
#echo 'UUE message base scanning utility husky-hpucode is not installed!'
#fi

sleep 1

echo ""
if [ -e /usr/local/sbin/htick  ]; then
echo  'Found FTN File ticker utility husky-htick.'
else
echo ' FTN File ticker utility is not installed!'
fi

sleep 1

#echo ""
#if [ -e /usr/local/sbin/nldiff  ]; then
#echo  'Found Nodelist tools husky-nltools.'
#else
#echo 'Nodelist tools husky-nltools is not installed!'
#fi

sleep 1

echo ""
if [ -e /usr/local/sbin/sqpack  ]; then
echo  'Found Message base packer husky-sqpack.'
else
echo 'Message base packer husky-sqpack is not installed!'
fi

sleep 1

#echo ""
#if [ -e /usr/local/sbin/bsopack  ]; then
#echo  'Found outbound netmail packer husky-bsopack.'
#else
#echo 'Outbound netmail packer husky-bsopack is not installed!'
#fi

sleep 1

echo ''
echo '-----------------------------------------------------------------------'
echo '| Checking installation of fidoip(BinkD, Husky HPT and GoldEd+).       |'
echo '-----------------------------------------------------------------------'
echo ''

echo ''

if [ -e /usr/local/sbin/binkd  ]; then
echo  '     BinkD installed succesfully.'
else
echo 'BinkD compilation failed! Read fido.rus.utf file, install necessary packages for compilation and then run this script again.'
fi

if [ -e /usr/local/sbin/hpt  ]; then
echo  '     Husky HPT installed succesfully.'
else
echo 'Husky HPT compilation failed! Read fido.rus.utf file, install necessary packages for compilation and then run this script again.'
fi

if [ -e /usr/local/sbin/gedlnx  ]; then
echo  '     GoldEd+ installed succesfully.'
else
echo 'GoldEd+ compilation failed! Read fido.rus.utf file, install necessary packages for compilation and then run this script again.'
fi

sleep 3
if [ -e /usr/local/sbin/binkd  ]; then
echo ""
if [ -e /usr/local/sbin/hpt  ]; then
echo ""
if [ -e /usr/local/sbin/gedlnx  ]; then
echo '------------------------------------------------------------------------'
echo "   Done! Installation fidoip for user $VAR_01 are finished successfully."
echo '   Edit config files as it decribed in fido.rus.koi file.      '
echo '   Visit http://sourceforge.net/projects/fidoip/ for info and updates.  '
echo '   http://sourceforge.net/apps/mediawiki/fidoip for wiki documentation.  '
echo '------------------------------------------------------------------------'

else
echo 'Installation of fidoip failed!'
echo 'Read documentation fido.rus.koi file,'
echo 'fix the problem and try to run this script again.  '
fi

else
echo 'Installation of fidoip failed!'
echo 'Read documentation fido.rus.koi file,'
echo 'fix the problem and try to run this script again.  '
fi

else
echo 'Installation of fidoip failed!'
echo 'Read documentation fido.rus.koi file,'
echo 'fix the problem and try to run this script again. '
fi


} 
f1 "${VAR_01}"
#End of ido_linux_koi.sh
