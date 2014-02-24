thinkpad_x240
=============

Configuration to make Linux run smoothly on the Lenovo Thinkpad x240


Background
==========

I have an x240 with FHD touchscreen display that I will be running Linux on. I am using this public repo as a place to put all the configuration and scripts I will be using to get Linux running well on my x240 lapotop, in hopes that it might be useful to others or maybe others would contribute so we have a spot to gather the ideas on getting everything working correctly.


Distro Installation
===================

I am running SolydK (amd64) with kernel version 3.11.10, Xorg 1.14.5. Installation required running the UEFI in legacy (BIOS) mode to enable the install. After that everything went smoothly. 

*TODO* Make linux boot through UEFI.

High DPI Issues
===============

The screen dimensions and DPI were not reported correctly in xdpyinfo. Turns out Xorg uses a logical dpi of '96' instead of the physical dpi. This mimics the behaviour of other OSes since many websites and applications assume a 96 dpi and setting a higher dpi would not render these correctly.

On the FHD of the x240 this results in text that is too small. This can be fixed by changing the dpi from within the DE. In KDE the it can be found under System Settings -> Application Appearance -> Fonts -> Force fonts DPI. Setting the DPI to 110 provides a good font size for the screen.

If you would like Xorg to use the actual screen dpi then you will need to include the appropriate conf file. You will have to create a xorg.conf.d directory first if you do not already have one.
```
  sudo mkdir /etc/X11/xorg.conf.d/
  sudo cp 90-monitor.conf /etc/X11/xorg.conf.d/
```

Dual Battery
============

In some DEs (KDE for example) the power management settings sets the battery level to critical when it reaches 5%. This also happens to be when the second (built in) battery takes over. Under the default settings the laptop will hibernate on critical and never utilize the second battery. In order to get around this you need to set the critical battery level to 4% under the power managment settings.


Touchpad Settings
=================

The following are Touchpad options that are recommended for use with the x240. You can setup all the options by adding the appropriate xorg conf file by running the following:
```
  sudo mkdir /etc/X11/xorg.conf.d/
  sudo cp 99-synaptics-x240.conf /etc/X11/xorg.conf.d/
```
After which a restart of Xorg will be required. Or the options could be changed through synclient. The following are the settings used:

* "HorizHysteresis"=30 # Used to reduce mouse "jitter"
* "VertHysteresis"=30 # Used to reduce mouse "jitter"
* "FingerLow"=40
* "FingerHigh"=45 

Any other suggestions for touchpad settings are welcome.

Trackpoint Settings
===================

Adjustments for the the trackpoint speed can be found in the file `trackpoint-speed.sh`. Running this file should make the trackpoint faster and far more usable. Make sure that the script has is executable by running
```
  chmod +x trackpoint-speed.sh
```
The problem is that using the trackpad as a button causes mouse movement when you attempt to click. So in order to use the trackpoint properly the trackpad has to be disabled. That is done by executing the script `trackpad-disable.sh`. It can be re-enabled by using `trackpad-enable.sh`. These scripts could be linked to keyboard shortcuts for quick enabling and disabling of the touchpad.


Syndaemon Alternative
=====================

Given the clickpad needs to be pushed down to register a click for the mouse, the issue of the mouse moving around due to accidently grazing the touchpad with your palm while typing is not longer a serious problem (unless you decide to allow touchpad soft press to register as a click, in which case syndaemon might still be neseccary since currently palm detection is not fully supported in linux). There is however the requirement for a similar deamon that disables the trackpad while the trackpoint is being used so the clicks do not register as mouse movements. This would be far more useful than manually enabling and disabling the trackpad. I will try to code something that hopefully does this task.

