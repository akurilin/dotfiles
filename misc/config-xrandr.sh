#!/bin/bash
# xrandr --output HDMI2 --auto --left-of VGA1
# xrandr --output VGA1 --auto --left-of HDMI2
xrandr --auto --output HDMI2 --primary --left-of VGA1
