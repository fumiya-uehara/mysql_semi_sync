#!/bin/bash

mysql -uroot -proot -e "
INSTALL PLUGIN rpl_semi_sync_slave SONAME 'semisync_slave.so';
"

mysql -uroot -proot -e "
STOP REPLICA;
CHANGE MASTER TO
  MASTER_HOST='192.168.200.110',
  MASTER_USER='repl',
  MASTER_PASSWORD='Gxy6UEK!nDBV7Wu',
  MASTER_PORT=3306,
  MASTER_AUTO_POSITION=1,
  MASTER_HEARTBEAT_PERIOD=60;
START REPLICA;
"
