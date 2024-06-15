# shellcheck disable=SC1091
# shellcheck disable=SC2034
# shellcheck disable=SC2148
SKIPUNZIP=0

if [[ "$KSU" == "true" ]]; then
  ui_print "- KernelSU 用户空间当前的版本号: $KSU_VER_CODE"
  ui_print "- KernelSU 内核空间当前的版本号: $KSU_KERNEL_VER_CODE"
  if [ "$KSU_KERNEL_VER_CODE" -lt 11089 ]; then
    ui_print "*********************************************"
    ui_print "! 请安装 KernelSU 管理器 v0.6.2 或更高版本"
    abort "*********************************************"
  fi
else
  ui_print "- Magisk 版本: $MAGISK_VER_CODE"
  if [ "$MAGISK_VER_CODE" -lt 26000 ]; then
    ui_print "*********************************************"
    ui_print "! 请安装 Magisk 26.0 或更高版本"
    abort "*********************************************"
  fi
fi

rm -rf /data/system/package_cache
set_perm_recursive "$MODPATH" 0 0 0755 0644 u:object_r:system_file:s0

. "$MODPATH"/util_functions.sh
previous_mios_version="$(grep_get_prop ro.mi.os.version.incremental)"
echo "$previous_mios_version" >"$MODPATH"/now_mios_version
target_mios_version="$(grep_get_prop version "$MODPATH"/module.prop)"
device="$(grep_get_prop ro.product.device)"
if [ "$previous_mios_version" != "$target_mios_version" ]; then
  ui_print "! 目标 HyperOS 版本与您的系统不匹配"
  ui_print "! 当前 HyperOS 版本: $previous_mios_version"
  abort "! 目标 HyperOS 版本: $target_mios_version"
fi
if [ "$device" != "sheng" ]; then
  ui_print "! 目标机型与您的机型不匹配"
  ui_print "! 当前机型: $device"
  abort "! 目标机型: sheng"
fi
