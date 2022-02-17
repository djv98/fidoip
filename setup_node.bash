#!/bin/bash
#/* Copyright (C) 2007-2012 Maxim Sokolsky, 2:5020/828.777.
#   This file is part of fidoip. It is free software and it is covered
#   by the GNU general public license. See the file LICENSE for details. */

# Script for creation FIDONet IP node configuration

# Usage:  bash ./setup_node.bash
# Bash only!!! Do not use sh interpretator
CWD=`pwd`
OSNAME=`uname`
USERNAME=`whoami`
MACHINE=`uname -m`
date=`date +%Y%m%d%m%s`
shortdate=`echo ${date} | sed s/^...//`
shortname=fidoip_configs_${shortdate}.tar

T1="root"
T2="Linux"
T3="FreeBSD"
T4="DragonFly"

set -e
set -u

if [ "$OSNAME" = "$T3" ]; then
Z1="BSD"
fi

if [ "$OSNAME" = "$T4" ]; then
Z1="BSD"
Z2="PKGSRC"
fi


# Declaration of allowed symbol for user input scrubbing
declare -r AllowedChars="1234567890/., :-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
declare -r AllowedNumbers="1234567890/.:"
declare -r Alloweddns="1234567890/.:-abcdefghijklmnopqrstuvwxyz"


if [ "$T1" = "$USERNAME" ]; then
echo  ''
else
echo 'Please run this script as root' ; exit
fi


echo "--------------------------------------------------------------------"
echo ""
echo "This script setup fidoip's configuration files for FIDONet node."
echo ""
echo "--------------------------------------------------------------------"
echo ""


echo "Enter your first and last name(sysop of this node) and press [ENTER]."
echo -n "Sample -  Vasiliy Pampasov: "
read fullname

if [ -z "$fullname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck="${fullname//[^$AllowedChars]/}"
if [ "$fullname" = "$ScrubbedCheck" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting \ before space
echo  "$fullname" | sed 's/ /\\ /g' > /tmp/fidoiptmp
fullname1=`cat /tmp/fidoiptmp`

# Inserting _ instead of space

echo  "$fullname" | sed 's/ /\_/g' > /tmp/fidoiptmp
fullname2=`cat /tmp/fidoiptmp`

echo "Enter your station name and press[ENTER]."
echo -n "Sample -  MyStation: "
read stationname

if [ -z "$stationname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck1="${stationname//[^$AllowedChars]/}"
if [ "$stationname" = "$ScrubbedCheck1" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting _ instead space
echo  "$stationname" | sed 's/ /\_/g' > /tmp/fidoiptmp
stationname1=`cat /tmp/fidoiptmp`


echo "Enter your location and press[ENTER]."
echo -n "Sample -  Moscow, Russia: "
read locationname
if [ -z "$locationname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck2="${locationname//[^$AllowedChars]/}"
if [ "$locationname" = "$ScrubbedCheck2" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting _ instead space
echo  "$locationname" | sed 's/ /\_/g' > /tmp/fidoiptmp
locationname1=`cat /tmp/fidoiptmp`

# Inserting space instead -
echo  "$locationname1" | sed 's/_/\ /g' > /tmp/fidoiptmp
locationname2=`cat /tmp/fidoiptmp`

# Changing spaces to -
echo  "$locationname" | sed 's/\ /-/g' > /tmp/fidoiptmp
locationname3=`cat /tmp/fidoiptmp`

# Changing , to -
echo  "$locationname3" | sed 's/\,/-/g' > /tmp/fidoiptmp
locationname4=`cat /tmp/fidoiptmp`


echo "Enter your FTN node address and press [ENTER]."
echo -n "Sample -  2:5020/788: "
read ftnaddress
if [ -z "$ftnaddress" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck3="${ftnaddress//[^$AllowedNumbers]/}"
if [ "$ftnaddress" = "$ScrubbedCheck3" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedNumbers""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi


# Inserting \ before /
echo  "$ftnaddress" | sed 's|/|\\/|g' > /tmp/fidoiptmp
ftnaddress1=`cat /tmp/fidoiptmp`


echo "Enter your station DNS name or IP-address and press [ENTER]."
echo -n "Sample - 192.168.4.7: "
read mydnsaddress
if [ -z "$mydnsaddress" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck622="${mydnsaddress//[^$Alloweddns]/}"
if [ "$mydnsaddress" = "$ScrubbedCheck622" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$Alloweddns""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

echo "Sysop has second account for access from other PC by network"
echo "This account has .1 point number."
echo "Enter your 1-st POINT password and press [ENTER]."
echo "(not bigger then 8 symbols)"
echo -n "Sample -  12345678: " 
read point1password
if [ -z "$point1password" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck31="${point1password//[^$AllowedChars]/}"
if [ "$point1password" = "$ScrubbedCheck31" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi


echo -e "Enter your main UPLINK full name and press press [ENTER]."
echo -n "Sample -  Ivan Papuasov: "
read uplinkname
if [ -z "$uplinkname" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck4="${uplinkname//[^$AllowedChars]/}"
if [ "$uplinkname" = "$ScrubbedCheck4" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting \ before space
echo  "$uplinkname" | sed 's/ /\\ /g' > /tmp/fidoiptmp
uplinkname1=`cat /tmp/fidoiptmp`

# Changing all space to _ 
echo  "$uplinkname" | sed 's/ /\_/g' > /tmp/fidoiptmp
uplinkname2=`cat /tmp/fidoiptmp`

echo -e "Enter your UPLINK FTN address and press [ENTER]."
echo -n "Sample -  2:5020/777: "
read uplinkftnaddress
if [ -z "$uplinkftnaddress" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck5="${uplinkftnaddress//[^$AllowedNumbers]/}"
if [ "$uplinkftnaddress" = "$ScrubbedCheck5" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedNumbers""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi

# Inserting \ before space
echo  "$uplinkftnaddress" | sed 's|/|\\/|g' > /tmp/fidoiptmp
uplinkftnaddress1=`cat /tmp/fidoiptmp`

echo "Enter UPLINK DNS name or IP-address and press [ENTER]."
echo -n "Sample - papuasov.dyndns.org: "
read uplinkdnsaddress
if [ -z "$uplinkdnsaddress" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck6="${uplinkdnsaddress//[^$Alloweddns]/}"
if [ "$uplinkdnsaddress" = "$ScrubbedCheck6" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$Alloweddns""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi


echo "Enter your UPLINK password and press [ENTER]."
echo "(not bigger then 8 symbols)"
echo -n "Sample -  09876543: " 
read uplinkpassword
if [ -z "$uplinkpassword" ]
then
echo 'You input nothing.'
echo 'Please run this script again and input something.'
exit
fi

# Checking user input&scrubbing
ScrubbedCheck7="${uplinkpassword//[^$AllowedChars]/}"
if [ "$uplinkpassword" = "$ScrubbedCheck7" ]; then
echo  ''
else
echo ' '
echo " Error. You entered wrong symbols. Allowed symbols are: "
echo -n ' '
echo -n ""$AllowedChars""
echo -n '               '
echo 'Please run this script again and be more carefull during inputing.'
echo -n '               '
exit
fi



echo ""
echo "--------------------------------------------------------------------"
echo ""

echo -n "Your full name is : "
echo $fullname
echo -n "Your system station name : "
echo $stationname
echo -n "Your FTN node address is: "
echo $ftnaddress
echo -n "Your location is : "
echo $locationname
echo -n "Your 1-st POINT password is : "
echo $point1password
echo -n "Your station DNS name or IP-address is : "
echo $mydnsaddress
echo 
echo -n "UPLINK name is : "
echo $uplinkname
echo -n "UPLINK FTN address is : "
echo $uplinkftnaddress
echo -n "UPLINK DNS name or IP-address is: "
echo $uplinkdnsaddress
echo -n "UPLINK password is: "
echo $uplinkpassword

echo ""
echo "--------------------------------------------------------------------"
echo ""
# asks if you want to change the original files and acts accordingly.

echo "OK? "
echo "[y/n]"
read reply
echo ""  
if [ "$reply" = "y" ];
	then 

rm -f /usr/local/bin/recv
rm -f /usr/local/bin/rs
rm -f /usr/local/bin/send
rm -f /usr/local/etc/fido/routing.lst
rm -f /usr/local/etc/fido/link.lst
rm -f /usr/local/etc/fido/point.lst
rm -f /usr/local/etc/fido/readonly.lst
rm -f /usr/local/etc/fido/uplink.lst
rm -f /usr/local/etc/fido/routing.lst
rm -f  /usr/local/etc/golded+/golded.cfg
mkdir -p /usr/local/etc/fidoip/node
cp -R node/* /usr/local/etc/fidoip/node
cp -p /usr/local/etc/fidoip/node/binkd.cfg.template-node /usr/local/etc/binkd.cfg
mkdir -p /usr/local/etc/fido
cp -p /usr/local/etc/fidoip/node/config.template-node  /usr/local/etc/fido/config
cp -p /usr/local/etc/fidoip/node/uplink.lst.template-node  /usr/local/etc/fido/uplink.lst
cp -p /usr/local/etc/fidoip/node/route-default.lst.template-node  /usr/local/etc/fido/route-default.lst
mkdir -p /usr/local/etc/golded+
cp -p /usr/local/etc/fidoip/node/decode.txt.template-node /usr/local/etc/golded+/golded.cfg
cp -p /usr/local/etc/fidoip/node/rs.template-node /usr/local/bin/rs
cp -p /usr/local/etc/fidoip/node/rs.template-node /usr/local/bin/send
cp -p /usr/local/etc/fidoip/node/recv.template-node /usr/local/bin/recv
cp -p /usr/local/etc/fidoip/node/poll.template-node /usr/local/bin/poll
cp -p /usr/local/etc/fidoip/node/toss /usr/local/bin/toss
cp -p /usr/local/etc/fidoip/node/readonly.lst.template-node /usr/local/etc/fido/readonly.lst
cp -p /usr/local/etc/fidoip/node/macro.cfg.template-node /usr/local/etc/golded+/macro.cfg

touch /usr/local/etc/fido/routing.lst
touch /usr/local/etc/fido/link.lst
touch /usr/local/etc/fido/point.lst
cp /usr/local/etc/fidoip/node/areafix.template-node /home/fido/areafix.hlp
cp /usr/local/etc/fidoip/node/filefix.template-node /home/fido/filefix.hlp
cp -p /usr/local/etc/fidoip/node/rules2.txt /home/fido/rules2.txt
cp -p /usr/local/etc/fidoip/node/rules1.txt /home/fido/rules1.txt
cp -p /usr/local/etc/fidoip/node/rules.txt /home/fido/rules.txt
cp -p /usr/local/etc/fidoip/node/fidohelp.hlp  /home/fido/
cp -p /usr/local/etc/fidoip/node/fidohelp /usr/local/bin/

cp /usr/local/etc/fidoip/node/listpoint /usr/local/bin/
cp /usr/local/etc/fidoip/node/viewpoint /usr/local/bin/
cp /usr/local/etc/fidoip/node/addpoint /usr/local/bin/
cp /usr/local/etc/fidoip/node/removepoint /usr/local/bin/
cp /usr/local/etc/fidoip/node/addlink /usr/local/bin/
cp /usr/local/etc/fidoip/node/removelink /usr/local/bin/
cp /usr/local/etc/fidoip/node/addread /usr/local/bin/
cp /usr/local/etc/fidoip/node/removeread /usr/local/bin/
cp /usr/local/etc/fidoip/node/fpasswd /usr/local/bin/
cp /usr/local/etc/fidoip/node/binkdsrv /usr/local/bin/
cp /usr/local/etc/fidoip/node/changeuplink /usr/local/bin/
cp /usr/local/etc/fidoip/node/listlink /usr/local/bin/
cp /usr/local/etc/fidoip/node/listecho /usr/local/bin/
cp /usr/local/etc/fidoip/node/listread /usr/local/bin/
cp /usr/local/etc/fidoip/node/fido.* /usr/local/bin/
cp /usr/local/etc/fidoip/node/month* /usr/local/bin/
cp /usr/local/etc/fidoip/node/clean_outb /usr/local/bin/
cp /usr/local/etc/fidoip/node/*.pl /usr/local/bin/

#if [ "$OSNAME" = "$T2" ]; then
#cp /usr/local/etc/fidoip/golded.tpl.fghi.disable-template /usr/local/etc/golded+/golded.tpl
#fi


#SHORTNODENAME=`echo $ftnaddress | sed 's|.*:||g' | sed 's|/|-|g'`
SHORTNODENAME=`echo $stationname1 |tr A-Z a-z`
SHORTNODENAMEUP=`echo $stationname1 |tr a-z A-Z`
ZONE=`echo $ftnaddress | sed 's|:.*||g' `

SHORTNAMEUPLINK=`echo $uplinkftnaddress | sed 's|.*:||g' | sed 's|/|-|g'`

sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/binkd.cfg
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/binkd.cfg
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/fido/config
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/fido/uplink.lst
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/fido/route-default.lst
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/golded+/golded.cfg
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/fido/readonly.lst
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /usr/local/etc/golded+/golded.cfg
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /home/fido/areafix.hlp
sed -i "s/MYNODE-ADDRESS/"$ftnaddress1"/g" /home/fido/filefix.hlp

sed -i "s/SYSTEM-NAME/"$stationname1"/g" /usr/local/etc/binkd.cfg
sed -i "s/SYSTEM-NAME/"$stationname1"/g" /usr/local/etc/fido/config
sed -i "s/SYSTEM-NAME/"$stationname1"/g" /home/fido/areafix.hlp
sed -i "s/SYSTEM-NAME/"$stationname1"/g" /home/fido/filefix.hlp

sed -i "s/MYHOST-DOMAIN-NAME/"$mydnsaddress"/g" /usr/local/etc/binkd.cfg

sed -i "s/SHORTNODE-NAME/"$SHORTNODENAME"/g" /usr/local/etc/fido/config

sed -i "s/ZONE-NUMBER/"$ZONE"/g" /usr/local/etc/binkd.cfg

sed -i "s/LOCATION-TOWN/"$locationname4"/g" /usr/local/etc/fido/config
sed -i "s/LOCATION-TOWN/"$locationname4"/g" /usr/local/etc/binkd.cfg

sed -i "s/SYSTEM-OPERATOR-NAME/"$fullname2"/g" /usr/local/etc/binkd.cfg
sed -i "s/SYSTEM-OPERATOR-NAME/$fullname1/g" /usr/local/etc/fido/config
sed -i "s/SYSTEM-OPERATOR-NAME/$fullname1/g" /usr/local/etc/golded+/golded.cfg
sed -i "s/SYSTEM-OPERATOR-NAME/$fullname/g" /home/fido/areafix.hlp
sed -i "s/SYSTEM-OPERATOR-NAME/$fullname/g" /home/fido/filefix.hlp

sed -i "s/MYPOINT-PASSWORD/"$point1password"/g" /usr/local/etc/binkd.cfg
sed -i "s/MYPOINT-PASSWORD/"$point1password"/g" /usr/local/etc/fido/config

sed -i "s/FIRSTLINK-NODE-NAME/$uplinkname1/g" /usr/local/etc/fido/config
sed -i "s/FIRSTLINK-NODE-NAME/$uplinkname1/g" /usr/local/etc/fido/uplink.lst
sed -i "s/FIRSTLINK-NODE-NAME/$uplinkname1/g" /usr/local/etc/fido/route-default.lst

sed -i "s/FIRSTLINK-NODE-ADDRESS/"$uplinkftnaddress1"/g"  /usr/local/etc/binkd.cfg
sed -i "s/FIRSTLINK-NODE-ADDRESS/"$uplinkftnaddress1"/g" /usr/local/etc/fido/config
sed -i "s/FIRSTLINK-NODE-ADDRESS/"$uplinkftnaddress1"/g" /usr/local/etc/fido/uplink.lst
sed -i "s/FIRSTLINK-NODE-ADDRESS/"$uplinkftnaddress1"/g" /usr/local/etc/fido/route-default.lst


sed -i "s/FIRSTLINK-HOST-DOMAIN-NAME/"$uplinkdnsaddress"/g" /usr/local/etc/binkd.cfg

sed -i "s/FIRSTLINK-NODE-PASSWORD/"$uplinkpassword"/g" /usr/local/etc/binkd.cfg
sed -i "s/FIRSTLINK-NODE-PASSWORD/"$uplinkpassword"/g" /usr/local/etc/fido/uplink.lst


sed -i "s/SHORTNODE-NAME/"$SHORTNAMEUPLINK"/g" /usr/local/etc/golded+/macro.cfg
sed -i "s/LINK-NODE-PASSWORD/"$uplinkpassword"/g" /usr/local/etc/golded+/macro.cfg
sed -i "s/LINK-NODE-ADDRESS/"$uplinkftnaddress1"/g" /usr/local/etc/golded+/macro.cfg
sed -i "s/LINK-NODE-ADDRESS/"$uplinkftnaddress1"/g" /usr/local/bin/poll

pointname=`echo "$fullname" | sed "s| .*||g"`

cp /usr/local/etc/fidoip/node/welcome2.template-node /tmp/welcome2.template-node
cp /usr/local/etc/fidoip/node/announce1.template-node /tmp/announce1.template-node
cp /usr/local/etc/fidoip/node/announce.template-node /tmp/announce.template-node


sed -i "s|POINT-NAME|$pointname|g" /tmp/welcome2.template-node
sed -i "s|MYNODE-ADDRESS|$ftnaddress1|g" /tmp/welcome2.template-node
sed -i "s|SYSTEM-NAME|"$stationname1"|g" /tmp/welcome2.template-node

sed -i "s|POINT-FULL-NAME|$fullname1|g" /tmp/announce.template-node
sed -i "s|MYNODE-ADDRESS|$ftnaddress1|g" /tmp/announce.template-node
sed -i "s|SYSTEM-NAME|"$stationname1"|g" /tmp/announce.template-node
sed -i "s|POINT-NUMBER|1|g" /tmp/announce.template-node

sed -i "s|LINK-FULL-NAME|$uplinkname1|g" /tmp/announce1.template-node
sed -i "s|LINK-ADDRESS|$uplinkftnaddress1|g" /tmp/announce1.template-node
sed -i "s|MYNODE-ADDRESS|$ftnaddress1|g" /tmp/announce1.template-node
sed -i "s|SYSTEM-NAME|"$stationname1"|g" /tmp/announce1.template-node

sed -i "s|SYSTEM-NAME|"$stationname1"|g" /home/fido/rules2.txt
sed -i "s|MYNODE-ADDRESS|$ftnaddress1|g" /home/fido/rules2.txt
sed -i "s/SHORTNODE-NAME/"$SHORTNODENAMEUP"/g" /home/fido/rules2.txt
sed -i "s/SYSTEM-OPERATOR-NAME/$fullname/g" /home/fido/rules2.txt
sed -i "s|SYSTEM-NAME|"$stationname1"|g" /home/fido/rules1.txt
sed -i "s|MYNODE-ADDRESS|$ftnaddress1|g" /home/fido/rules1.txt
sed -i "s/SHORTNODE-NAME/"$SHORTNODENAMEUP"/g" /home/fido/rules1.txt
sed -i "s/SYSTEM-OPERATOR-NAME/$fullname/g" /home/fido/rules1.txt
sed -i "s|SYSTEM-NAME|"$stationname1"|g" /home/fido/rules.txt
sed -i "s|MYNODE-ADDRESS|$ftnaddress1|g" /home/fido/rules.txt
sed -i "s/SHORTNODE-NAME/"$SHORTNODENAMEUP"/g" /home/fido/rules.txt
sed -i "s/SYSTEM-OPERATOR-NAME/$fullname/g" /home/fido/rules.txt


echo
echo "Generating welcome and announce messages"
echo ""

export FIDOCONFIG=/usr/local/etc/fido/config
/usr/local/sbin/txt2pkt -nf "Developer of fidoip"  -xf "$ftnaddress"  -xt "$ftnaddress" -nt "$fullname" -t "Powered by automatic fidoip NMS(Node Management System)" -o "http://sourceforge.net/apps/mediawiki/fidoip" -s "Welcome to new node, sysop!" -e ""$SHORTNODENAME".local" -d /home/fido/localinb /tmp/welcome2.template-node
/usr/local/sbin/txt2pkt -nf "Dumb-robot" -xf "$ftnaddress".333  -xt "$ftnaddress"  -t "Powered by automatic fidoip NMS(Node Management System)" -o "http://sourceforge.net/apps/mediawiki/fidoip" -s "Uplink ""$uplinkftnaddress"" is created " -e ""$SHORTNODENAME".official" -d /home/fido/localinb /tmp/announce1.template-node
/usr/local/sbin/txt2pkt -nf "Dumb-robot" -xf "$ftnaddress".333  -xt "$ftnaddress"  -t "Powered by automatic fidoip NMS(Node Management System)" -o "http://sourceforge.net/apps/mediawiki/fidoip" -s "System point ""$ftnaddress"".1 is added for sysop" -e ""$SHORTNODENAME".official" -d /home/fido/localinb /tmp/announce.template-node
/usr/local/sbin/txt2pkt -nf "Dumb-robot" -xf "$ftnaddress".333  -xt "$ftnaddress"  -t "Powered by automatic fidoip NMS(Node Management System)" -o "http://sourceforge.net/apps/mediawiki/fidoip" -s "Rules of ""$SHORTNODENAMEUP"".test" -e ""$SHORTNODENAME".test" -d /home/fido/localinb /home/fido/rules2.txt
/usr/local/sbin/txt2pkt -nf "Dumb-robot" -xf "$ftnaddress".333  -xt "$ftnaddress"  -t "Powered by automatic fidoip NMS(Node Management System)" -o "http://sourceforge.net/apps/mediawiki/fidoip" -s "Rules of ""$SHORTNODENAMEUP"".forwards" -e ""$SHORTNODENAME".forwards" -d /home/fido/localinb /home/fido/rules1.txt
/usr/local/sbin/txt2pkt -nf "Dumb-robot" -xf "$ftnaddress".333  -xt "$ftnaddress"  -t "Powered by automatic fidoip NMS(Node Management System)" -o "http://sourceforge.net/apps/mediawiki/fidoip" -s "Rules of ""$SHORTNODENAMEUP"".local" -e ""$SHORTNODENAME".local" -d /home/fido/localinb /home/fido/rules.txt

/usr/local/bin/toss 2> /dev/null

cp golded/.screenrc /usr/local/etc/golded+/

echo "OK. Original configuration files modified successfully."
echo "Please start GoldEd with ge, g or gl command to see welcome message"  

rm -f /tmp/fidoiptmp
rm -f /tmp/welcome2.template-node
rm -f /tmp/announce1.template-node
rm -f /tmp/announce.template-node

elif [ "$reply" = "n" ];
	then 
echo "Please run this script again."

fi
