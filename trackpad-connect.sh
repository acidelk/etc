#!/usr/bin/env bash

TRACKPAD_MAC=ac-88-fd-ee-ad-de
blueutil --unpair $TRACKPAD_MAC
read -n 1 -p "Restart your trackpad and press any key..." -s
blueutil --pair $TRACKPAD_MAC
