#ifdef SWIGJAVA
%insert("runtime") %{
#define SWIG_JAVA_NO_DETACH_CURRENT_THREAD
#define SWIG_JAVA_ATTACH_CURRENT_THREAD_AS_DAEMON
%}
#endif

%module(directors="1") touchvg
%{
#include <gicanvas.h>
#include <testcanvas.h>
%}

%feature("director") GiCanvas;
%include <gicanvas.h>
%include <testcanvas.h>

#ifdef SWIGJAVA
%{
#include <jni.h>

JNIEXPORT jint JNICALL JNI_OnLoad(JavaVM* /*ajvm*/, void* /*reserved*/) {
    return JNI_VERSION_1_6;
}
%}
#endif
