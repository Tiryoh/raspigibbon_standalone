#!/usr/bin/env python
# coding:utf-8

import time
import serial
import struct
from RS30X.RS30X import RS304MD as RS30X

if __name__ == '__main__':
    rs = RS30X()

    for i in range(1,6):
        rs.setTorque(i, True)
        time.sleep(0.1)

    for i in range(1,6):
        rs.setAngleInTime(i, 0, 1)

    time.sleep(1)

    for i in range(1,6):
        rs.setAngleInTime(i, -31, 3)
        time.sleep(0.5)

