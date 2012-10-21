#!/bin/sh
python core/utf8togbk.py
cd android/demo/jni
sh makejni.sh
ndk-build
cd ../src/touchvg
javac -cp ../../libs/touchvg.jar:../../libs/android.jar canvas/*.java;
cd ..; jar -cfv paintview.jar touchvg/canvas/*.class;
cd ..; mv -v src/*.jar libs;
rm -rf src/touchvg/canvas/*.class;
cd ../..
python core/restore_utf8.py
