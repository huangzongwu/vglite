#!/bin/sh
mkdir ._java
mkdir ._java/touchvg
mkdir ._java/touchvg/jni
rm -rf ._java/touchvg/jni/*.*

swig -c++ -java -package touchvg.jni \
    -outdir ._java/touchvg/jni -o touchvg_java_wrap.cpp \
    -I../../../core/canvas -I../../../core/test -I"$JAVA_INCLUDE" touchvg.swig

cd ._java/touchvg/jni; javac *.java; cd ../../..
cd ._java; jar cfv touchvg.jar touchvg/jni/*.class; cd ..
mkdir ../libs
cp -v ._java/touchvg.jar ../libs