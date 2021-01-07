#!/bin/bash

mysql -uroot -proot -e "
INSTALL PLUGIN rpl_semi_sync_master SONAME 'semisync_master.so';
GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%';
"
