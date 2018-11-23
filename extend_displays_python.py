#!/usr/bin/env python3

import signal
import sys
import subprocess
import shlex
import re

def close_and_clean(sig, frame):
        print('You pressed Ctrl+C!')
        print("Need to finish this function")
        sys.exit(0)

# display_type can either be " connected" or "disconnected"
def get_displays(display_type):
    #cmd = ['xrandr', '-q', '|', 'grep', 'disconnected' ,'|', 'cut', '-d" "', '-f1']
    displays = []
    cmd = 'xrandr -q'
    process = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE)
    output, error = process.communicate()
    output = output.decode('ascii')
    
    # print("=========Output:============")
    # print(output)

    # print("==========Error==========")
    # print(error)

    if (not error):
        # print([m.start() for m in re.finditer('disconnected', output)])
        # line = re.findall(r'disconnected', output)
        # print(line)
        # if line:
        #     line = line[0].split('"')[1]
        # print (line)
        output = output.split('\n')
        for line in output:
            if display_type in line:
                displays.append(line.split(' ')[0])
        
    return displays


def check_display_mode():
    pass

def create_display_mode():
    pass

def add_display_mode():
    pass

def output_display():
    pass


if __name__ == '__main__':

    signal.signal(signal.SIGINT, close_and_clean)
    # signal.pause()
    disconnected = get_displays("disconnected")
    connected = get_displays(" connected")

    print("Connected displays: ")
    print(connected)
    print("Disconnected displays: ")
    print(disconnected)
