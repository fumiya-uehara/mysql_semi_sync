#!/bin/bash

source_c_id="$(docker ps | awk '$2 == "mysql_semi_sync_source" {print $1}')"
replica_c_id="$(docker ps | awk '$2 == "mysql_semi_sync_replica" {print $1}')"

docker exec "${replica_c_id}" bash -c "mysql -uroot -proot -e 'stop replica;'"

docker exec "${source_c_id}" bash -c "
mysql -uroot -proot -e '
SET GLOBAL rpl_semi_sync_master_enabled=1;
SET GLOBAL rpl_semi_sync_master_timeout=3000;
'
"

docker exec "${replica_c_id}" bash -c "
mysql -uroot -proot -e '
SET GLOBAL rpl_semi_sync_slave_enabled=1;
SET GLOBAL read_only=1;
SET GLOBAL super_read_only=1;
'
"

docker exec "${replica_c_id}" bash -c "mysql -uroot -proot -e 'start replica;'"
