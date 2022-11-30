#!/bin/bash
# author:Fire
 
# 使用办法： 在任意一台服务器上运行该脚本，则可以使指定服务器集群之间实现SSH互信
 
# 以下变量从上到下为主机IP数组，配置SSH的用户名数组，密码数组
servers=($1 $2 $3)
users=(root root root)
passwords=($4 $5 $6)
 
 
function checkSize() {
server_size=${#servers[@]}
user_size=${#users[@]}
password_size=${#passwords[@]}
 
if [ $server_size -ne $user_size ] || [ $server_size -ne $password_size ]; then 
	echo "参数数量不匹配"
	exit 1
fi
 
size=$server_size
}
 
function createRsa() {
user=$1
server=$2
password=$3
/usr/bin/expect <<EOF
 
set timeout 1
 
spawn ssh $user@$server
 
expect "yes" {
	send "yes\n";
}
expect "password:" {
	send "$password\r";
}
expect "*#*#*#"
 
expect " ~]" {
	send "ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa\r";
}
 
expect "Overwrite" {
	send "no\n";
}
expect " ~]" {
	send "exit\r";
}
 
expect "*#*#*#"
 
EOF
}
 
function sendRsaKey() {
user01=$1
server01=$2
password01=$3
user02=$4
server02=$5
password02=$6
/usr/bin/expect <<EOF
 
set timeout 1
 
spawn ssh $user01@$server01
 
expect "yes" {
	send "yes\n";
}
expect "password:" {
	send "$password01\r";
}
expect "*#*#*#"
 
expect " ~]" {
	send "ssh-copy-id -i ~/.ssh/id_rsa.pub $user02@$server02\r";
}
 
expect "yes" {
	send "yes\n";
}
 
expect "password:" {
	send "$password02\r";
}
 
expect " ~]" {
	send "exit\r";
}
expect "*#*#*#"
 
EOF
}
 
 
# 下面是主函数
size=0
checkSize
 
for((i=0;i<$size;i++));
do
	createRsa ${users[$i]} ${servers[$i]} ${passwords[$i]}
done
 
for((i=0;i<$size;i++));
do
	for((j=0;j<$size;j++));
	do
		sendRsaKey ${users[$i]} ${servers[$i]} ${passwords[$i]} ${users[$j]} ${servers[$j]} ${passwords[$j]}
	done
done
 
## 主函数结束

