#!/bin/bash

#-----------------------------------------------------------------
username=root
passwd=loongson

remoteIP=''
#-----------------------------------------------------------------
IP_List_File='hostlist.txt'
#tmpIP_List_File='hostlist_filter.tmp'
tmpIP_List_File="${IP_List_File}.tmp"
output_file=output_scenario.file
#-----------------------------------------------------------------
retCode=0
success=0
failed=0
cmdLine=''
scenarioLine=''
serverCmdTag=1
ipcount=0
#-----------------------------------------------------------------

if [ $# -ne 1 ];then
    echo "Parameter error,usage:$0 file_name"
    exit 1
fi


do_command()
{
        #hosts=`sed -n '/^[^#]/p' hostlist.txt`
        #hosts=`cat hostlist.txt |awk '{print $0}'`
        #cat hostlist.txt|while read host
        #echo "hosts:$hosts"
        #for host in $hosts
        #FINDFILE='hostlist.txt'
        #tmpIP_List_File='hostlist_filter.tmp'
        exec 3<$tmpIP_List_File
        while read host <&3
        do
		echo "--------------------------------------------------------"
                ipcount=$(($ipcount+1))
		remoteIP=$host
		echo "remoteIP: [$remoteIP]"

                #sh remote_scenario_param.sh $remoteIP $scenarioLine > /dev/null 2>&1
                sh remote_scenario_param.sh $remoteIP $scenarioLine >> $output_file
                retCode=$?

                if [ $retCode -eq 0 ]; then
                  serverCmdTag=0
                  statTag='OK'
                  success=$(($success+1))
                  echo -e "\n\033[32m$remoteIP | success\033[0m\n"
                  result="[$success] IP:[$ServerIp],cmd:[$scenarioLine],result:[OK]"
                  echo $remoteIP >> ip_server_scenario_test_ok.file
                  result_all="[$ipcount] IP:[$ServerIp],cmd:[$scenarioLine],result:[$statTag]"
                  echo $result_all >> ip_server_scenario_test_result.file
                else
                  statTag='OK' 
                  failed=$(($failed+1))
                  echo -e "\n\033[32m$remoteIP | failed\033[0m\n"
                  result="[$failed] IP:[$ServerIp],cmd:[$scenarioLine],result:[ERROR]"
                  echo $Server >> ip_server_scenario_test_error.file
                  result_all="[$ipcount] IP:[$ServerIp],cmd:[$scenarioLine],result:[$statTag]"
                  echo $result_all >> ip_server_scenario_test_result.file
                fi
                
#                if [ $retCode -eq 0 ]; then
#                  statTag='OK'
#                  result="[$ipcount] IP:[$ServerIp],cmd:[$scenarioLine],result:[$statTag]"
#                  echo $remoteIP >> ip_server_scenario_test_result.file
#                else
#                  statTag='ERROR'
#                  result="IP:[$ServerIp],cmd:[$scenarioLine],result:[$statTag]"
#                  echo $Server >> ip_server_scenario_test_result.file
#                fi

        done < $tmpIP_List_File

        return 0
}


rm -f ip_server_scenario_test_ok.file
rm -f ip_server_scenario_test_error.file
rm -f ip_server_scenario_test_result.file
rm -f $output_file
#Delete the space lines and comment lines
sed '/^#.*\|^[[:space:]]*$/d' $IP_List_File > $tmpIP_List_File

#local_ip=10.20.42.41

#Example:execute scenario_test.sh
#scenarioLine='scenario_test.sh'
scenarioLine=$1

echo -e "\033[31m执行脚本: $scenarioLine \033[0m"
do_command $scenarioLine

#echo -e '\n========================================================'
echo  '========================================================'
#echo -e "\033[32mServer -> success: $debugerSuccess | failed: $debugerFailed \033[0m"
#echo -e "\033[32mServer  -> success: $serverSuccess | failed: $serverFailed \033[0m"
echo -e "\033[32msuccess: $success | failed: $failed \033[0m"
echo ""
if [ $serverCmdTag -eq 0 ]; then
  echo "The IP list of successful remote scenario executed is as follows:"
  cat ip_server_scenario_test_ok.file
fi

