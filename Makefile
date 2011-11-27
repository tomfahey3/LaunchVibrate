export GO_EASY_ON_ME = 1
include theos/makefiles/common.mk

TWEAK_NAME = LaunchVibrate
LaunchVibrate_FILES = Tweak.xm
LaunchVibrate_FRAMEWORKS = Foundation UIKit AudioToolbox

include $(THEOS_MAKE_PATH)/tweak.mk
