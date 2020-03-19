#!/bin/bash
#Created By lzn

check-db-talbe-size(){
  local tb=${1:-"tableName"}
  local db=${2:-"dbName"}
  local user=${3:-"userName"}
  local paswd=${4:-"password"}
  mysql -u$user -p$paswd -e '''
SELECT 
truncate(data_length/1024/1024, 2) as "数据容量(MB)",
truncate(index_length/1024/1024, 2) as "索引容量(MB)" 
FROM information_schema.tables  
WHERE table_schema="'${db}'"
AND table_name="'${tb}'";
'''
}

check-db-talbes-size(){
  local db=${1:-"dbName"}
  local user=${2:-"userName"}
  local paswd=${3:-"password"}
  mysql -u$user -p$paswd -e '''
SELECT
table_schema as "数据库",
table_name as "表名",
table_rows as "记录数,
truncate(data_length/1024/1024, 2) as "数据容量(MB)",
truncate(index_length/1024/1024, 2) as "索引容量(MB)
FROM information_schema.tables  
WHERE table_schema="'${db}'"
order by data_length desc, index_length desc;
'''
}

main(){
  check-db-talbes-size
}
main