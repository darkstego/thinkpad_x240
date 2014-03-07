#!/bin/bash

ID=`xinput | grep TrackPoint | sed 's/.*id=\([0-9]\+\).*/\1/'`

xinput set-prop $ID "Device Accel Profile" 2
xinput set-prop $ID "Device Accel Velocity Scaling" 150
xinput set-prop $ID "Device Accel Constant Deceleration" 1.35
