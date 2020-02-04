#/bin/bash

#----------------------------------------------------------------
cmdStr=''
retCode=0
#----------------------------------------------------------------
cmdEndStr="Remote Test:Remote scenario Test End-------------------------"
ServerIP=''
ServerUser='root'
ServerPass='loongson'
cmdLine=''
scenarioLine=''
retCode=0
#----------------------------------------------------------------------------------
source ./shell-log.sh
logFile=$logFile
#echo $logFile
write_log=$write_log
#----------------------------------------------------------------------------------
source ./exceptionTrap.sh
exit_end=$exit_end
exit_err=$exit_err
exit_int=$exit_int
#----------------------------------------------------------------------------------
trap 'exit_end "${cmdEndStr}"' EXIT
trap 'exit_err $LINENO $?'     ERR
trap 'exit_int $LINENO'        INT
#----------------------------------------------------------------------------------

write_log "INFO" "Remote Test:Remote scenario Test Begin-----------------------"
echo "Remote Test:start the remote node..."

if [ $# -ne 2 ];then
    echo "Parameter error,usage:Test-Server-scenario-param.sh ServerIP cmdLine"
    exit 1
fi


#Exit the script if an error happens
#set -e

#====================================================================================================
#sshpass -p 'loongson' ssh root@10.20.42.220 'pwd'

#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 $dest_path/$script_name

#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 /tmp/3B_Ctrl/3B_on.sh
#sshpass -p 'loongson' ssh  -o StrictHostKeyChecking=no root@$10.20.42.220 /tmp/3B_Ctrl/3B_off.sh

#====================================================================================================

echo "Remote connection Test..."

#-----------------------------------------------------------------------
ServerIP=$1
scenarioLine=$2
#sh RemoteConnTest-param.sh $ServerIP $cmdLine

cmdLine='pwd'
#-----------------------------------------------------------------------
trap - ERR

sh Test-Server-cmd-param.sh $ServerIP $cmdLine
retCode=$?

trap 'exit_err $LINENO $?'     ERR

if [ $retCode -eq 0 ]; then
  cmdStr="=====connect to $ServerIP success."
  echo $cmdStr
  write_log "INFO" "${cmdStr}"
  echo ""
else
  cmdStr="Error:connect to $ServerIP failed!Please check it!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi

#====================================================================================================

curtimeBegin=`echo $(date +"%F %T")`
echo "===================current time is:$curtimeBegin"
echo ""

#scenarioLine='/tmp/3B_Ctrl/3B_off.sh'

#sshpass -p 'loongson' ssh  root@$10.20.42.220 /tmp/3B_Ctrl/3B_off.sh
#sshpass -p $ServerPass ssh $ServerUser@$ServerIP $cmdLine

trap - ERR

sshpass -p $ServerPass ssh $ServerUser@$ServerIP -C "/bin/bash" <$scenarioLine
retCode=$?
echo "=====remote execute:[$scenarioLine],retCode: $retCode"

trap 'exit_err $LINENO $?'     ERR

if [ $retCode -eq 0 ]; then
  cmdStr="=====remote scenario executed success."
  echo $cmdStr
  write_log "INFO" "${cmdStr}"
  echo ""
  curtimeEnd=`echo $(date +"%F %T")`
  echo "===================current time is:$curtimeEnd"
else
  cmdStr="Error:remote scenario executed failed!Please check it!"
  echo $cmdStr
  write_log "ERROR" "${cmdStr}"
  exit 1
fi


