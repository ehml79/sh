#!/bin/bash
 
mongodb_host=192.168.1.243
mongodb_port=27017

backup_dir="/data/backup/mongodb/mongodb_oplog/mongo-${mongodb_port}"

 
 
echo -e "\033[31;1m*****[ Mongodb ] 增量恢复脚本*****\033[0m"
 
echo -e "\033[32;1m[ 选择要恢复增量的日期(格式：年月日时分秒) ] \033[0m"
for time_file in `ls ${backup_dir}`; do
    echo $time_file
done
 
read -p ">>>" date_bak

if [[ $date_bak == "" ]] || [[ $date_bak == '.' ]] || [[ $date_bak == '..' ]]; then
    echo -e "\033[31;1m输入不能为特殊字符.\033[0m"
    exit 1
fi

if [ -d ${backup_dir}/$date_bak ]; then
    read -p "请确认是否恢复[$date_bak]增量备份[y/n]:" choice
    if [ "$choice" == "y" ];then
        mkdir -p /tmp/mongodb/ && cp -a ${backup_dir}/$date_bak/local/oplog.rs.bson /tmp/mongodb/oplog.bson
        /data/service/mongodb-database-tools/bin/mongorestore --host ${mongodb_host} --port ${mongodb_port} --oplogReplay /tmp/mongodb/ && rm -rf /tmp/mongodb/
        if [ $? -eq 0 ];then
            echo -e "\033[32;1m--------[$date_bak]增量恢复成功.--------\033[0m"
        else
            echo -e "\033[31;1m恢复失败,请手动检查!\033[0m"
            exit 3
        fi
    else
        exit 2
    fi
else
    echo -e "\033[31;1m输入信息错误.\033[0m"
    exit 1
fi
