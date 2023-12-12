#!/bin/bash
datenow=$(date +%Y\ %B\ %d)
kernelname="San-Kernel-V4.19-Mesh-R1"
echo $datenow
echo $release
sed -i "s/\(ini_set(\"kernel_name\", \s*\)\"[^\"]*\"/\1\"$kernelname\"/" META-INF/com/google/android/aroma-config
sed -i "s/\(ini_set(\"kernel_date\", \s*\)\"[^\"]*\"/\1\"$datenow\"/" META-INF/com/google/android/aroma-config
zip -r9 $kernelname.zip * -x .git README.md *placeholder *zip zip.sh *txt
