#!/bin/bash

#------------------------------------------------
#脚本功能
#获取系统信息,例如系统名称，系统版本，内核版本等
#------------------------------------------------

cat /.buildstamp > /home/os_info.txt
kernel_ver=`uname -r`

kernel_ver_Str="Kernel_Version=${kernel_ver}"
echo $kernel_ver_Str
sed -i "/Compose/i\\${kernel_ver_Str}" /home/os_info.txt

os_type=`cat /.buildstamp |grep Product|awk -F"=" '{print $2}'`

BuildInfoFile=/home/os_info.txt
OSInfoFile=/home/OSInfo_Detail.txt

os_type=`cat ${BuildInfoFile} |grep Product | awk -F"=" '{print $2}'`
echo 系统分类:[${os_type}] > ${OSInfoFile}
os_version=`cat ${BuildInfoFile} |grep UUID | awk -F"=" '{print $2}'`
echo 系统版本:[${os_version}] >> ${OSInfoFile}
kernel_version=`cat ${BuildInfoFile} |grep Kernel_Version | awk -F"=" '{print $2}'`
echo 内核版本:[${kernel_version}] >> ${OSInfoFile}

cat ${OSInfoFile}
