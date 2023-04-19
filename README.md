hadoop-setup

Introduction

This repository aims to quickly build a Hadoop cluster on multiple Linux servers and integrate Huawei's OBS plugin to connect big data computing components such as Spark, MapReduce, Hive, and HBase with the OBS object storage service.

Environment: CentOS 7.6 64-bit

Usage

Clone the project
As the operation of the Hadoop cluster is heavily dependent on the network, it is best to use the private IP address for communication between the clusters. However, one server needs to have a public IP address for us to perform SSH connection and browser access to the web page.

First, select one of the multiple servers as the master node, and set the other nodes as slave1, slave2, etc. Login to the master server with a public IP address, and run the following command in any directory to clone this project.

sh
Copy code
git clone https://github.com/liuyunhaozz/hadoop-setup.git
Add personal configuration information for Huawei Cloud OBS service
Enter the project directory, open ./config/core-site.xml, find the corresponding access key, secret key, and endpoint three blank items. Add the values of the access key, secret key, and endpoint that the individual recorded when purchasing the configuration in obs.

Run the script
Run the script with the following command, where [IP1] [IP2] [IP3] are the private IP addresses of master, slave1, and slave2, respectively, and [PASSWORD1] [PASSWORD2] [PASSWORD3] are the login passwords of master, slave1, and slave2, respectively. These information can all be obtained from the Huawei Cloud console.

sh
Copy code
source main.sh [IP1] [IP2] [IP3] [PASSWORD1] [PASSWORD2] [PASSWORD3]
The script will automatically complete tasks such as node trust, host configuration, openjdk installation, plugin installation, hadoop deployment, and distribution.

hosts adjustment
Since CentOS maps the local hostname to 127.0.0.1 every time it starts up, the port listening address of hadoop is 127.0.0.1, making it inaccessible from the outside. Therefore, we need to open the /etc/hosts file of each server and delete all lines containing 127.0.0.1. This completes the setup.

Start Hadoop
sh
Copy code
hdfs namenode -format 
start-all.sh
References

[1] How to Install Hadoop in Stand-Alone Mode on CentOS 7

[2] Automatic configuration SSH mutual trust script

[3] There are 0 datanode(s) running and no node(s) are excluded in this operation

[4] Hadoop-Examples

[5] Solving Hadoop command running WordCount exception Class WordCount$XXXMapper not found
