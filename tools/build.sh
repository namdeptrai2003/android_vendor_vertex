#!/bin/bash
echo "Choose build type:"
select choice in OFFICIAL-user TEST-user TEST-userdebug TEST-eng EXPERIMENTAL-user EXPERIMENTAL-userdebug EXPERIMENTAL-eng
do
    case "$choice" in
        "OFFICIAL-user")
            export VERTEX_BUILDTYPE=OFFICIAL
            export BUILD_VARIANT=user
            find . -name "*Development*.apk" | xargs rm
            break;;
        "TEST-user")
            export VERTEX_BUILDTYPE=TEST
            export BUILD_VARIANT=user
            break;;
        "TEST-userdebug")
            export VERTEX_BUILDTYPE=TEST
            export BUILD_VARIANT=userdebug
            break;;
        "TEST-eng")
            export VERTEX_BUILDTYPE=TEST
            export BUILD_VARIANT=eng
            break;;
        "EXPERIMENTAL-user")
            export VERTEX_BUILDTYPE=EXPERIMENTAL
            export BUILD_VARIANT=user
            break;;
        "EXPERIMENTAL-userdebug")
            export VERTEX_BUILDTYPE=EXPERIMENTAL
            export BUILD_VARIANT=userdebug
            break;;
        "EXPERIMENTAL-eng")
            export VERTEX_BUILDTYPE=EXPERIMENTAL
            export BUILD_VARIANT=eng
            break;;
        *) echo "Invalid option. Try again!"
            ;;
    esac
done

if [[ -z "$BUILD_DEVICE" ]]; then
    export BUILD_DEVICE=oneplus3
fi

. build/envsetup.sh
lunch vertex_${BUILD_DEVICE}-${BUILD_VARIANT}

time make bacon -j16
