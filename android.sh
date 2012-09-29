#!/bin/sh
cd android/demo/jni
sh makejni.sh;
ndk-build NDK_DEBUG=1
cd ..
cd ..
cd ..
