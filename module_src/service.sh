#!/system/bin/sh
# shellcheck disable=SC1091
# shellcheck disable=SC2009
# shellcheck disable=SC2143
# shellcheck disable=SC2154
MODDIR=${0%/*}

. "$MODDIR"/util_functions.sh
previous_mios_version="$(grep_get_prop ro.mi.os.version.incremental)"
echo "$previous_mios_version" >"$MODDIR"/now_mios_version
