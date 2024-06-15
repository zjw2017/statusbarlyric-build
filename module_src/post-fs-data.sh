#!/system/bin/sh
# shellcheck disable=SC1091
# shellcheck disable=SC2154
MODDIR=${0%/*}

. "$MODDIR"/util_functions.sh
new_mios_version="$(grep_get_prop ro.mi.os.version.incremental)"
previous_mios_version="$(cat "$MODDIR"/now_mios_version)"
if [ "$new_mios_version" != "$previous_mios_version" ]; then
  touch "$MODDIR"/disable
fi
