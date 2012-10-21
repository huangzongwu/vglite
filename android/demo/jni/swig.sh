#!/bin/sh
mkdir ../src/touchvg/jni
rm -rf ../src/touchvg/jni/*.*
swig -c++ -java -package touchvg.jni \
    -outdir ../src/touchvg/jni -o touchvg_java_wrap.cpp \
    -I../../../core/canvas -I../../../core/test -I"$JAVA_INCLUDE" touchvg.swig
python replacejstr.py