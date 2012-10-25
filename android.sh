#!/bin/sh
# need copy $ANDROID_SDK_HOME/platforms/android-?/android.jar to android/demo/libs
python core/utf8togbk.py
cd android/demo/jni
sh swig.sh
ndk-build
cd ../..
sh makejar.sh
cd ..
python core/restore_utf8.py
