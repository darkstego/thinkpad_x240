#!/bin/bash

synclient RightButtonAreaTop=0 RightButtonAreaRight=0 RightButtonAreaLeft=4201 RightButtonAreaBottom=1900
synclient MiddleButtonAreaTop=0 MiddleButtonAreaRight=4200 MiddleButtonAreaLeft=3167 MiddleButtonAreaBottom=1900

ID=`xinput | grep TouchPad | sed 's/.*id=\([0-9]\+\).*/\1/'`

xinput set-prop $ID "Device Accel Constant Deceleration" 9999999
