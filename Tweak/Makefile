THEOS_BUILD_DIR = debs
TARGET =: clang
ARCHS = armv7 armv7s arm64

include theos/makefiles/common.mk

BUNDLE_NAME = Tranquil
Tranquil_FILES = TranquilViewController.xm headers/TouchFix/TouchFix.m TranquilViewControllerNew.xm TranquilView.xm TranquilInjections.xm
Tranquil_FRAMEWORKS = Foundation UIKit CoreGraphics
Tranquil_PRIVATE_FRAMEWORKS = MobileTimer BulletinBoard
Tranquil_INSTALL_PATH = /System/Library/WeeAppPlugins
Tranquil_LDFLAGS = -weak_library $(TARGET_PRIVATE_FRAMEWORK_PATH)/SpringBoardUIServices.framework/SpringBoardUIServices
Tranquil_CFLAGS = -fobjc-arc
Tranquil_LIBRARIES = substrate

include $(THEOS_MAKE_PATH)/bundle.mk

before-stage::
	find . -name ".DS_Store" -delete
after-install::
	install.exec "killall -9 backboardd"
