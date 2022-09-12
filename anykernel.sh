# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=KCUFKernel-V1
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=whyred
device.name2=
device.name3=
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
'; } # end properties

# shell variables
block=/dev/block/bootdevice/by-name/boot;
is_slot_device=0;
ramdisk_compression=auto;
patch_vbmeta_flag=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;

aroma_get_value() {
  [ -f /tmp/aroma/${1}.prop ] && cat /tmp/aroma/${1}.prop | head -n1 | cut -d'=' -f2 || echo ""
}

## AnyKernel boot install
split_boot;

# extract Image and dtb
xz -d ${home}/Image.xz || abort
xz -d ${home}/kernel_dtb.xz || abort

# Read value by user selected from aroma prop files
blobs_newcam=$(aroma_get_value blobs_newcam)
cpu_overclock=$(aroma_get_value cpu_overclock)

# Camera Blobs
if [ "$blobs_newcam" == "2" ]; then
	$bin/bspatch ${home}/Image ${home}/Image ${home}/bspatch/cam_newblobs || abort
fi

# cpu overclock
if [ "$cpu_overclock" == "2" ]; then
	patch_cmdline "androidboot.cpuoverclock" "androidboot.cpuoverclock=1"
else
	patch_cmdline "androidboot.cpuoverclock" ""
fi

flash_boot;
## end boot install
