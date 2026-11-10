#!/bin/bash

# Glamor should not run on platforms prior to Pi 4.
PIGEN=$(rcn nonint get_pi_gen)
if [ "$PIGEN" -ne 4 ] && [ "$PIGEN" -ne 5 ]; then
	if ! [ -e /usr/share/X11/xorg.conf.d/20-noglamor.conf ] ; then
		cat > /usr/share/X11/xorg.conf.d/20-noglamor.conf << EOF
Section "Device"
	Identifier "kms"
	Driver "modesetting"
	Option "AccelMethod" "msdri3"
	Option "UseGammaLUT" "off"
EndSection
EOF
	fi
else
	if [ -e /usr/share/X11/xorg.conf.d/20-noglamor.conf ] ; then
		rm /usr/share/X11/xorg.conf.d/20-noglamor.conf
	fi
fi
