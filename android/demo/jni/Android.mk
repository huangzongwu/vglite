LOCAL_PATH := $(call my-dir)
COREINC    := $(LOCAL_PATH)/../../../core
CORESRC    := ../../../core

include $(CLEAR_VARS)

LOCAL_MODULE := touchvg
LOCAL_SHARED_LIBRARIES := libcutils libdl libstlport
LOCAL_PRELINK_MODULE   := false
LOCAL_CFLAGS           := -frtti -g  -Wall -Wextra -D__ANDROID__

ifeq ($(TARGET_ARCH),arm)
# Ignore "note: the mangling of 'va_list' has changed in GCC 4.4"
LOCAL_CFLAGS += -Wno-psabi
endif

ifndef NDK_ROOT
include external/stlport/libstlport.mk
endif

LOCAL_C_INCLUDES := $(COREINC)/canvas \
                    $(COREINC)/test

LOCAL_SRC_FILES  := touchvg_java_wrap.cpp \
                    $(CORESRC)/test/testcanvas.cpp

include $(BUILD_SHARED_LIBRARY)
