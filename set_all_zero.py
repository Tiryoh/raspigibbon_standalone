#!/usr/bin/env python
# coding:utf-8

import time
import serial
import struct
import argparse
from RS30X.RS30X import RS304MD as RS30X


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="usage:set servo goal time as '--time 2' or '-t 2'")
    parser.add_argument("-t", "--time", type=int, default=0, help="define raspigibbon servo goal time")
    args = parser.parse_args()

    servo = RS30X()

    for i in range(1,6):
        servo.reboot(i)
        time.sleep(0.01)
        servo.setTorque(i, True)
        time.sleep(0.01)

    for i in range(1,6):
        servo.setAngleInTime(i, 0, args.time)
        time.sleep(0.1)

