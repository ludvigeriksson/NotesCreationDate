SHARED_CFLAGS = -fobjc-arc
ARCHS = armv7 armv7s arm64

# Uncomment before release to remove build number
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

include theos/makefiles/common.mk

TWEAK_NAME = NotesCreationDate
NotesCreationDate_FILES = Tweak.xm
NotesCreationDate_FRAMEWORKS = UIKit, CoreGraphics

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileNotes"
