#!/bin/bash
export VERTEX_BUILDTYPE=TEST
export VERTEX_BUILDTYPE=OFFICIAL

echo "Choose build type:"
select choice in OFFICIAL-user TEST-user EXPERIMENTAL-user OFFICIAL-userdebug TEST-userdebug EXPERIMENTAL-userdebug
do
    case "$choice" in
        "OFFICIAL-user")
            export VERTEX_BUILDTYPE=OFFICIAL
            . build/envsetup.sh
            lunch vertex_oneplus3-user
            break;;
        "OFFICIAL-userdebug")
            export VERTEX_BUILDTYPE=OFFICIAL
            . build/envsetup.sh
            lunch vertex_oneplus3-userdebug
            break;;
        "TEST-user")
            export VERTEX_BUILDTYPE=TEST
            . build/envsetup.sh
            lunch vertex_oneplus3-user
            break;;
        "TEST-userdebug")
            export VERTEX_BUILDTYPE=TEST
            . build/envsetup.sh
            lunch vertex_oneplus3-userdebug
            break;;
        "EXPERIMENTAL-user")
            export VERTEX_BUILDTYPE=EXPERIMENTAL
            . build/envsetup.sh
            lunch vertex_oneplus3-user
            break;;
        "EXPERIMENTAL-userdebug")
            export VERTEX_BUILDTYPE=EXPERIMENTAL
            . build/envsetup.sh
            lunch vertex_oneplus3-userdebug
            break;;
        *) echo "Invalid option. Try again!"
            ;;
    esac
done

time mka bacon
