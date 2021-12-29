#!/bin/sh

# /etc/X11/xorg.conf.d contains host-specific configuration

# Host-specific display layout. Better be in separate script
#xrandr --output VGA-1 --off \
#	--output DVI-D-1 --off \
#	--output DVI-D-2 --off \
#	--output DisplayPort-1-1 --off \
#	--output HDMI-2          --mode 1920x1080 --rate 75 --pos 0x420    --rotate normal \
#	--output HDMI-A-1-0      --mode 1920x1080 --rate 75 --pos 1920x420 --rotate normal \
#	--output DisplayPort-1-0 --mode 1920x1080 --rate 75 --pos 3840x0   --rotate right

sudo ethtool --change enp4s0 speed 10 autoneg off duplex full

 # Disable screensaver
xset -dpms
xset s off

export XDG_CURRENT_DESKTOP=KDE
export XDG_SESSION_DESKTOP=KDE
export KDE_SESSION_VERSION=5
export SAL_USE_VCLPLUGIN=kde5
export QT_QPA_PLATFORMTHEME=qt5ct

kded6 &
