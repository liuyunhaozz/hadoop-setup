#!/bin/bash
# author:Fire
 
# How to use: Run this script on any server to enable SSH mutual trust between the specified server clusters 


# The following variables are the host IP array from top to bottom, the user name array for configuring SSH, and the password array
servers=($1 $2 $3)
users=(root root root)
passwords=($4 $5 $6)
 
 
function checkSize() {
server_size=${#servers[@]}
user_size=${#users[@]}
password_size=${#passwords[@]}
 
if [ $server_size -ne $user_size ] || [ $server_size -ne $password_size ]; then 
	echo "Mismatched number of arguments"
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
 
# The following is the main function 
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
 
## End of the main function

