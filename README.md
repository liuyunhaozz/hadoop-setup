# hadoop-setup

## 简介

本仓库旨在快速在多台 `Linux` 服务器上构建 `Hadoop` 集群，并集成华为的 `OBS` 插件，以实现大数据计算`Spark`、`MapReduce`、`Hive`、`HBase`等组件与OBS对象存储服务的对接

环境：`CentOS 7.6 64bit` 

## 使用方法

### clone本项目

因为 `Hadoop `集群的运行强烈依赖于网络，因此各集群之间的联系最好使用内网 `IP`。但是需要一台服务器具有公网 `IP` 以便于我们进行 `ssh` 连接和浏览器访问网页.

首先在多台服务器中选择一台进行设为主节点`master`，其他的节点设为`slave1`, `slave2`等等。使用公网 `IP` 登录`master` 服务器，在任意目录运行以下命令 `clone` 本项目。

```sh
git clone https://github.com/liuyunhaozz/hadoop-setup.git
```

### 添加华为云OBS服务个人配置信息

进入项目目录，打开 `./config/core-site.xml`, 找到对应的 `access key` , `secret key` 和 ` endpoint` 三个空项上。添加个人在`obs` 购买配置时，所记录的 `access key` , `secret key` 和 ` endpoint` 的值。

### 运行脚本

以如下命令运行脚本，其中 `[IP1] [IP2] [IP3]` 为 `master`, `slave1`, `slave2` 的内网 `IP` 地址，`[PASSWORD1] [PASSWORD2] [PASSWORD3` 为 `master`, `slave1`, `slave2` 的登录密码，这些信息都可在华为云控制台获得。

```sh
source main.sh [IP1] [IP2] [IP3] [PASSWORD1] [PASSWORD2] [PASSWORD3]
```

该脚本将自动完成节点互信，`host` 配置，`openjdk` 安装，插件安装，`hadoop` 部署和分发等任务

### `hosts` 调整

由于 `CentOS` 在每次开机后都会将本机 `hostname` 映射到 `127.0.0.1`, 导致 `hadoop` 的端口监听地址为`127.0.0.1`，外部无法访问。故最后我们需要打开每台服务器的 `/etc/hosts` 文件，删掉所有包含 `127.0.0.1` 的行。这样就完成了设置。

### 启动 `Hadoop`

```sh
hdfs namenode -format 
start-all.sh
```

## 参考资料

[1] [How to Install Hadoop in Stand-Alone Mode on CentOS 7](https://www.vultr.com/docs/how-to-install-hadoop-in-stand-alone-mode-on-centos-7/)

[2] [自动配置SSH互信脚本](https://blog.csdn.net/qq_19344391/article/details/116325172)

[3] [There are 0 datanode(s) running and no node(s) are excluded in this operation](https://stackoverflow.com/quest//ions/26545524/there-are-0-datanodes-running-and-no-nodes-are-excluded-in-this-operation)



