#!/usr/bin/env python
# coding:utf-8

import time
import serial
import struct
from RS30X.RS30X import RS304MD as RS30X


if __name__ == '__main__':
    servo = RS30X()

    for i in range(1,6):
        servo.reboot(i)
        time.sleep(0.01)
        servo.setTorque(i, True)
        time.sleep(0.01)

    for i in range(1,6):
        servo.setAngleInTime(i, 0, 2)
        time.sleep(0.1)

    while servo.readAngle(2) > 2 or servo.readAngle(2) < -2:
        time.sleep(0.1)

    servo.setAngle(1,0)
    time.sleep(0.1)
    servo.setAngleInTime(2, 80, 4)
    time.sleep(0.1)
    servo.setAngleInTime(3, -130, 4)
    time.sleep(0.1)
    servo.setAngleInTime(4, -80, 4)
    time.sleep(0.1)
    servo.setAngle(5,0)
    time.sleep(0.1)

    while servo.readAngle(4) > -80:
        time.sleep(0.1)

    for i in range(1,6):
        servo.setTorque(i, False)
        time.sleep(0.1)

