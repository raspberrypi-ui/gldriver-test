#!/bin/bash

# Glamor should run unless the platform is not Pi 4 and the legacy driver is not in use.
# First line identifies platforms earlier than Pi 4; second line identifies whether KMS or fKMS are running.

if { grep -s -q "^Revision\s*:\s*00[0-9a-fA-F][0-9a-fA-F]$" /proc/cpuinfo || grep -q "^Revision\s*:\s*[ 123][0-9a-fA-F][0-9a-fA-F][012][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]$" /proc/cpuinfo; } && \
	{ grep -s -q okay /proc/device-tree/soc/v3d@7ec00000/status || grep -s -q okay /proc/device-tree/soc/firmwarekms@7e600000/status || grep -s -q okay /proc/device-tree/v3dbus/v3d@7ec04000/status; } ; then
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
