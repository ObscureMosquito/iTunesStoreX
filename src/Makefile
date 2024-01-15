TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = SpringBoard
BUNDLE_NAME = com.mosquito.itunesstorex

archs= armv7

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = iTunesStoreX

iTunesStoreX_FILES = Tweak.x CustomURLProtocol.m
iTunesStoreX_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

