#!/bin/bash


###############################################################
#log Function 
source ./shell-log.sh
logFile=$logFile
#echo $logFile
write_log=$write_log

##############################################################
TempFileList="TempFile.list"
##############################################################

function exit_end()
{
  #delete temp files when exit
  #python -c "import logging;import log;logging.info('Before end,remove temp files.')"(Mark:shell call python)
  #python rmTempFile.py $pmonStdtmp $pmonStdtmp.bak $pxeStdtmp $pxeStdtmp.bak
  if [ -s "$TempFileList" ]; then
    #echo "==================测试=========================="
    str=`cat $TempFileList | xargs echo`
    echo $str
    #echo "==================测试=========================="
    python rmTempFile.py $str
    sleep 1s
    echo "Remove temp files end"
    rm $TempFileList
  fi  
  echo  "$0:End."
  write_log "INFO" "$1"
}

function exit_err()
{
  local cmdStr="ErrorFile:[$0],LineNum:$1,ErrCode:$2,ErrCmd:$BASH_COMMAND"
  echo $cmdStr  
  write_log "ERROR" "${cmdStr}";exit $2
}

function exit_int()
{
  cmdStr="Warning:You pressed ctrl-c,exit"
  echo $cmdStr
  write_log "WARN" "${cmdStr}";exit
}
###############################################################
