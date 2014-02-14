THEOS_PACKAGE_DIR_NAME = debs
TARGET =: clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = Tranquil
Tranquil_FILES = $(wildcard *.xm)
Traunquil_FRAMEWORKS = Foundation UIKit QuartzCore
Traunquil_PRIVATE_FRAMEWORKS = MobileTimer

include $(THEOS_MAKE_PATH)/tweak.mk

internal-after-install::
	install.exec "killall -9 backboardd"
