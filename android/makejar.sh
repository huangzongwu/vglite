#!/bin/sh
cd demo/src/touchvg
if [ -f ../../libs/android.jar ]
then
    javac -cp ../../libs/android.jar jni/*.java canvas/*.java;
    cd ..; jar -cfv touchvg.jar touchvg/jni/*.class touchvg/canvas/*.class;
    cd ..; mv -v src/*.jar libs;
    rm -rf src/touchvg/jni/*.class src/touchvg/canvas/*.class;
    cd ..
else
    echo "Need to copy android.jar from ANDROID_SDK_HOME/platforms to android/demo/libs."
    cd ../../..
fi
