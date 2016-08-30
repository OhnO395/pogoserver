#!/bin/sh
/usr/bin/mysqld_safe &
sleep 5
mysql -u root -e "create database pogosql"
cd /POGOserver
./run-linux.sh
