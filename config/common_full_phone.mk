# Inherit common VERTEX stuff
$(call inherit-product, vendor/vertex/config/common_full.mk)

# Required VERTEX packages
PRODUCT_PACKAGES += \
    LatinIME

# Include VERTEX LatinIME dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/vertex/overlay/dictionaries

ifeq ($(TARGET_SCREEN_WIDTH) $(TARGET_SCREEN_HEIGHT),$(space))
    PRODUCT_COPY_FILES += \
        vendor/vertex/prebuilt/common/bootanimation/480.zip:system/media/bootanimation.zip
endif

$(call inherit-product, vendor/vertex/config/telephony.mk)
