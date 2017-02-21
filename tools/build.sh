#!/bin/bash
export VERTEX_BUILDTYPE=TEST
export VERTEX_BUILDTYPE=OFFICIAL

echo "Choose build type:"
select choice in OFFICIAL TEST EXPERIMENTAL
do
    case "$choice" in
        "OFFICIAL")
            export VERTEX_BUILDTYPE=OFFICIAL
            break;;
        "TEST")
            export VERTEX_BUILDTYPE=TEST
            break;;
        "EXPERIMENTAL")
            export VERTEX_BUILDTYPE=EXPERIMENTAL
            break;;
        *) echo "Invalid option. Try again!"
            ;;
    esac
done

. build/envsetup.sh
lunch vertex_oneplus3-userdebug
time mka bacon
