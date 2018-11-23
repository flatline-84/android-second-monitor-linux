#!/bin/sh

trap ctrl_c INT

ctrl_c() {
        echo "Shutting down..."
        xrandr --output DisplayPort-1 --off
}

# Spare Display
DISPLAY="DisplayPort-1"
LAPTOP_DISPLAY="eDP"

# Which side the Android Tablet will be on
RIGHT=false

WIFI=true

# Set your Android screen resolution here
ANDROID_X=1920
ANDROID_Y=1080

DISPLAY_SETTINGS=`cvt ${ANDROID_X} ${ANDROID_Y} | grep Modeline | cut -d' ' -f2-`
DISPLAY_NAME=`echo $DISPLAY_SETTINGS | cut -d' ' -f1`

#echo $DISPLAY_NAME

xrandr --newmode $DISPLAY_SETTINGS
#xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#Activate second screen
#xrandr --addmode DisplayPort-1 1920x1080_60 

xrandr --addmode $DISPLAY $DISPLAY_NAME
#xrandr --addmode DisplayPort-1 1920x1080_60 --output DisplayPort-1 --mode 1920x1080_60 --right-of eDP
#-rfbauth /home/peter/.vnc/passwd

if $RIGHT
then
    xrandr --output $DISPLAY --mode $DISPLAY_NAME --right-of eDP
    x11vnc  -display :0 -clip 1920x1080+${ANDROID_X}+0  -nocursorshape -nocursorpos 2> /dev/null
else
    xrandr --output $DISPLAY --mode $DISPLAY_NAME --left-of eDP
    x11vnc  -display :0 -clip 1920x1080+0+0  -nocursorshape -nocursorpos 2> /dev/null
fi


xrandr --output DisplayPort-1 --off
