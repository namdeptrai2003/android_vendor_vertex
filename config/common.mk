# Boot Animation - Black Google Pixel
PRODUCT_COPY_FILES += \
    vendor/vertex/prebuilt/common/bootanimation/bootanimation.zip:system/media/bootanimation.zip

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Enable Google Assistant
PRODUCT_PROPERTY_OVERRIDES += \
	ro.opa.eligible_device=true
							  
# Import some sounds
$(call inherit-product-if-exists, frameworks/base/data/sounds/GoogleAudio.mk)

# Default notification/alarm sounds
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.notification_sound=Titan.ogg \
    ro.config.alarm_alert=Awaken.ogg

ifneq ($(TARGET_BUILD_VARIANT),user)
# Thank you, please drive thru!
PRODUCT_PROPERTY_OVERRIDES += persist.sys.dun.override=0
endif

ifneq ($(TARGET_BUILD_VARIANT),eng)
# Enable ADB authentication
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=1
endif

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/vertex/CHANGELOG.mkdn:system/etc/CHANGELOG-VertexOS.txt

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/vertex/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/vertex/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/vertex/prebuilt/common/bin/50-vertex.sh:system/addon.d/50-vertex.sh \
    vendor/vertex/prebuilt/common/bin/blacklist:system/addon.d/blacklist

# Backup Services whitelist
PRODUCT_COPY_FILES += \
    vendor/vertex/config/permissions/backup.xml:system/etc/sysconfig/backup.xml

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/vertex/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/vertex/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/vertex/prebuilt/common/bin/sysinit:system/bin/sysinit

ifneq ($(TARGET_BUILD_VARIANT),user)
# userinit support
PRODUCT_COPY_FILES += \
    vendor/vertex/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit
endif

# Vertex-specific init file
PRODUCT_COPY_FILES += \
    vendor/vertex/prebuilt/common/etc/init.local.rc:root/init.vertex.rc

# Copy over added mimetype supported in libcore.net.MimeUtils
PRODUCT_COPY_FILES += \
    vendor/vertex/prebuilt/common/lib/content-types.properties:system/lib/content-types.properties

# Required Vertex packages
PRODUCT_PACKAGES += \
    Development \

# Optional Vertex packages
PRODUCT_PACKAGES += \
    libemoji \
    LiveWallpapersPicker \

# Include explicitly to work around GMS issues
PRODUCT_PACKAGES += \
    libprotobuf-cpp-full \
    librsjni

# Custom Vertex packages
PRODUCT_PACKAGES += \
    ExactCalculator \
    Launcher3 \
    LockClock \
	masquerade

# Exchange support
PRODUCT_PACKAGES += \
    Exchange2

# Extra tools in Vertex
PRODUCT_PACKAGES += \
    bzip2 \
    curl \
    fsck.ntfs \
    gdbserver \
    libsepol \
    micro_bench \
    mke2fs \
    mkfs.ntfs \
    mount.ntfs \
    pigz \
    sqlite3 \
    strace \
    tune2fs \
    wget

# Custom off-mode charger
ifneq ($(WITH_CM_CHARGER),false)
PRODUCT_PACKAGES += \
    charger_res_images \
    cm_charger_res_images \
    font_log.png \
    libhealthd.cm
endif

# ExFAT support
WITH_EXFAT ?= true
ifeq ($(WITH_EXFAT),true)
TARGET_USES_EXFAT := true
PRODUCT_PACKAGES += \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat
endif

# Openssh
PRODUCT_PACKAGES += \
    scp \
    sftp \
    ssh \
    sshd \
    sshd_config \
    ssh-keygen \
    start-ssh

# rsync
PRODUCT_PACKAGES += \
    rsync

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# Storage manager
PRODUCT_PROPERTY_OVERRIDES += \
    ro.storage_manager.enabled=true

# Telephony
PRODUCT_PACKAGES += \
    telephony-ext

PRODUCT_BOOT_JARS += \
    telephony-ext

# These packages are excluded from user builds
ifneq ($(TARGET_BUILD_VARIANT),user)
PRODUCT_PACKAGES += \
    procmem \
    procrank \
    su
endif

PRODUCT_PROPERTY_OVERRIDES += \
    persist.sys.root_access=0

DEVICE_PACKAGE_OVERLAYS += vendor/vertex/overlay/common

# Set version
PRODUCT_VERSION = v1.7
CODE_NAME = ATLAS

# Unofficial by default unless defined
ifndef VERTEX_BUILDTYPE
	VERTEX_BUILDTYPE := UNOFFICIAL	
endif

VERTEX_VERSION := VertexOS-$(CODE_NAME)-$(PRODUCT_VERSION)-$(VERTEX_BUILDTYPE)-$(shell date -u +%Y%m%d)-$(VERTEX_BUILD)

VERTEX_MODVERSION := $(CODE_NAME)-$(PRODUCT_VERSION)-$(VERTEX_BUILDTYPE)-$(shell date -u +%Y%m%d)

PRODUCT_PROPERTY_OVERRIDES += \
  ro.vertex.version=$(VERTEX_VERSION) \
  ro.vertex.releasetype=$(VERTEX_BUILDTYPE) \
  ro.modversion=$(VERTEX_MODVERSION)


PRODUCT_PROPERTY_OVERRIDES += \
  ro.vertex.display.version=$(VERTEX_VERSION)


ifeq ($(OTA_PACKAGE_SIGNING_KEY),)
    PRODUCT_EXTRA_RECOVERY_KEYS += \
        vendor/vertex/build/target/product/security/vertex \
        vendor/vertex/build/target/product/security/vertex-devkey
endif

-include vendor/vertex-priv/keys/keys.mk
