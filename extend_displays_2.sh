#!/bin/sh

trap ctrl_c INT

ctrl_c() {
        echo "Shutting down..."
        xrandr --output DisplayPort-1 --off
}

# Set your Android screen resolution here
ANDROID_X=1920
ANDROID_Y=1080

DISPLAY_SETTINGS=`cvt ${ANDROID_X} ${ANDROID_Y} | grep Modeline | cut -d' ' -f3-`
#DISPLAY_NAME=`echo $DISPLAY_SETTINGS | cut -d' ' -f1`

#echo $DISPLAY_NAME

#xrandr --newmode "1920x1080_60" ${DISPLAY_SETTINGS}
xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#Activate second screen
xrandr --addmode DisplayPort-1 1920x1080_60 
xrandr --output DisplayPort-1 --mode 1920x1080 --right-of eDP
#xrandr --addmode DisplayPort-1 1920x1080_60 --output DisplayPort-1 --mode 1920x1080_60 --right-of eDP
#-rfbauth /home/peter/.vnc/passwd
x11vnc  -display :0 -clip 1920x1080+1920+0  -nocursorshape -nocursorpos

xrandr --output DisplayPort-1 --off
