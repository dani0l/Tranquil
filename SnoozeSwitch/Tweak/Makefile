THEOS_PACKAGE_DIR_NAME = debs
TARGET = :clang:
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

TWEAK_NAME = SnoozeSwitchDemo
SnoozeSwitchDemo_FILES = SnoozeSwitchDemo.xm SSSwitch.m
SnoozeSwitchDemo_FRAMEWORKS = UIKit CoreGraphics QuartzCore
SnoozeSwitchDemo_PRIVATE_FRAMEWORKS = MobileTimer
SnoozeSwitchDemo_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete
internal-after-install::
	install.exec "killall -9 backboardd"
