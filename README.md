# hadoop-setup

## Introduction

This repository aims to quickly build a `Hadoop` cluster on multiple `Linux` servers and integrate Huawei's `OBS` plugin to enable the integration of big data computing components such as `Spark`, `MapReduce`, `Hive`, `HBase`, and OBS object storage services.

Environment: `CentOS 7.6 64bit`

## Usage

### Clone the project

Because the operation of the `Hadoop` cluster strongly depends on the network, it is best to use the intranet `IP` for communication between the nodes. However, one server needs to have a public network `IP` for `ssh` connection and browser access.

Firstly, select one of the multiple servers as the master node `master`, and set the others as `slave1`, `slave2`, etc. Log in to the `master` server with the public network `IP` and run the following command in any directory to clone this project.

```sh
git clone https://github.com/liuyunhaozz/hadoop-setup.git
```

### Add personal configuration information for Huawei Cloud OBS service

Enter the project directory, open `./config/core-site.xml`, and find the three empty items for `access key`, `secret key`, and `endpoint`. Add the `access key`, `secret key`, and `endpoint` values recorded when configuring `obs` service.

### Run the script

Run the script with the following command, where `[IP1] [IP2] [IP3]` are the intranet `IP` addresses of `master`, `slave1`, and `slave2`, and `[PASSWORD1] [PASSWORD2] [PASSWORD3]` are the login passwords of `master`, `slave1`, and `slave2`. All this information can be obtained from the Huawei Cloud console.

```sh
source main.sh [IP1] [IP2] [IP3] [PASSWORD1] [PASSWORD2] [PASSWORD3]
```

The script will automatically complete tasks such as node intercommunication, `host` configuration, `openjdk` installation, plugin installation, `hadoop` deployment and distribution.

### Adjust `hosts`

Since `CentOS` maps the local `hostname` to `127.0.0.1` after each boot, `hadoop` listens on `127.0.0.1`, making it inaccessible from the outside. Therefore, we need to open the `/etc/hosts` file on each server and delete all lines containing `127.0.0.1`. This completes the setup.

### Start `Hadoop`

```sh
hdfs namenode -format 
start-all.sh
```

## References

[1] [How to Install Hadoop in Stand-Alone Mode on CentOS 7](https://www.vultr.com/docs/how-to-install-hadoop-in-stand-alone-mode-on-centos-7/)

[2] [SSH Intercommunication Script](https://blog.csdn.net/qq_19344391/article/details/116325172)

[3] [There are 0 datanode(s) running and no node(s) are excluded in this operation](https://stackoverflow.com/quest//ions/26545524/there-are-0-datanodes-running-and-no-nodes-are-excluded-in-this-operation)

[4] [Hadoop-Examples](https://github.com/Coursal/Hadoop-Examples)

[5] [Solving the Exception of Running WordCount in Hadoop: Class WordCount$XXXMapper not found](https://blog.csdn.net/difffate/article/details/78759376)
