#!/bin/sh
python core/utf8togbk.py
cd android/demo/jni
sh makejni.sh;
ndk-build NDK_DEBUG=1
cd ../../..
python core/restore_utf8.py
