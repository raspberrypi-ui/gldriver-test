#!/bin/bash

if grep -q "^Revision\s*:\s*00[0-9a-fA-F][0-9a-fA-F]$" /proc/cpuinfo || grep -q "^Revision\s*:\s*[ 123][0-9a-fA-F][0-9a-fA-F][012][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$" /proc/cpuinfo ; then
	if ! [ -e /usr/share/X11/xorg.conf.d/20-noglamor.conf ] ; then
		cat > /usr/share/X11/xorg.conf.d/20-noglamor.conf << EOF
Section "Device"
	Identifier "kms"
	Driver "modesetting"
	Option "AccelMethod" "none"
EndSection
EOF
	fi
else
	if [ -e /usr/share/X11/xorg.conf.d/20-noglamor.conf ] ; then
		rm /usr/share/X11/xorg.conf.d/20-noglamor.conf
	fi
fi
