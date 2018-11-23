#!/bin/sh

# Check if root
#if [ "$(id -u)" != "0" ]; then
#	echo "This program needs to be run as root"
#	exit 1
#fi

LOCAL=false

if [ -z "$1"]
then
    echo "Running VNC over WiFi"
else
    echo "Running VNC over cable"
    LOCAL=true
fi

# Set display size to laptop + tablet
# Laptop Display: 1920x1080
# Android Tablet: 2560x1600 
# Will keep laptop height

ANDROID_X=1920
LAPTOP_X=1920
TOTAL_Y=1080
TOTAL_X=`expr $LAPTOP_X + $ANDROID_X`

DISPLAY=xrandr | grep -m 1 " connected" | cut -d' ' -f1
#DISPLAY="eDP"
#echo ${DISPLAY}
#echo "wtf is going on"
#exit 0

echo "Setting screen resolution to ${TOTAL_X}x${TOTAL_Y} on display ${DISPLAY}"
sudo xrandr --fb ${TOTAL_X}x${TOTAL_Y} --output ${DISPLAY} --panning ${TOTAL_X}x${TOTAL_Y}+0+0/${TOTAL_X}x${TOTAL_Y}+0+0

echo "Waiting for monitor to adjust..."
sleep 3

echo "Setting workspace for Android tablet to go on the left..."
sudo xrandr --fb ${TOTAL_X}x${TOTAL_Y} --output ${DISPLAY} --panning ${LAPTOP_X}x${TOTAL_Y}+0+0/${TOTAL_X_X}x${TOTAL_Y}+0+0

# --output ${DISPLAY}
echo "Running VNC..."

if $LOCAL
then
    # Lock VNC down to localhost. Will port forward over ADB
    sudo x11vnc -rfbauth /home/peter/.vnc/passwd -display ${DISPLAY} -localhost -clip ${LAPTOP_X}x${TOTAL_Y}+${ANDROID_X}+0 -nocursorshape -nocursorpos 2> /dev/null
    adb forward tcp:5900 tcp:5900
else
    sudo x11vnc -rfbauth /home/peter/.vnc/passwd -display ${DISPLAY} -clip ${LAPTOP_X}x${TOTAL_Y}+${ANDROID_X}+0 -nocursorshape -nocursorpos 2> /dev/null 
fi


echo "Returning everything to normal..."
sudo xrandr --fb 1920x1080

echo "Finished!"
exit 0
