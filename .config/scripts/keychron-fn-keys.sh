#!/usr/bin/bash

echo 0 | sudo tee /sys/module/hid_apple/parameters/fnmode
echo "Now hold fn + X + L"
