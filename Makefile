TARGET = iphone:latest:10.0:12.2
ARCHS = armv7 arm64
MODULES = jailed
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = instap4tch0
DISPLAY_NAME = InstaP4tch0
BUNDLE_ID = it.codecraft.instap4tch0

instap4tch0_FILES = Tweak.xm Categories.xm $(wildcard lib/*.swift)
instap4tch0_IPA = ../Instagram.ipa
instap4tch0_CFLAGS = -fobjc-arc -FFrameworks
instap4tch0_LDFLAGS = -FFrameworks
instap4tch0_EMBED_FRAMEWORKS = $(wildcard Frameworks/*.framework)

_THEOS_INTERNAL_SWIFTFLAGS += -FFrameworks $(patsubst %.framework,-framework %,$(notdir $(instap4tch0_EMBED_FRAMEWORKS)))

include $(THEOS_MAKE_PATH)/tweak.mk
