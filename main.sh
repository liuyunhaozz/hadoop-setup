# 主文件
# $1, $2, $3 -> 三台服务器的内网ip，$4, $5, $6 -> 三台服务器的root密码
# 宿主机安装expect
yum install -y expect
# 在服务器集群两两配置ssh
source ./autossh.sh $1 $2 $3 $4 $5 $6

# 在三台服务器中加入host, 命名为master, slave1, slave2
source ./autohost.sh $1 $2 $3 
ssh -o StrictHostKeyChecking=no root@slave1 'bash -s' < ./autohost.sh $1 $2 $3
ssh -o StrictHostKeyChecking=no root@slave2 'bash -s' < ./autohost.sh $1 $2 $3

# 安装openjdk
yum install -y java-1.8.0-openjdk
ssh root@slave1 "yum install -y java-1.8.0-openjdk"
ssh root@slave2 "yum install -y java-1.8.0-openjdk"

# 下载hadoop-2.8.3及对应的obs
wget https://hub.nuaa.cf/liuyunhaozz/hadoop-setup/releases/download/hadoop-2.8.3/hadoop-2.8.3.tar.gz -P /home/modules
tar xzvf /home/modules/hadoop-2.8.3.tar.gz -C /home/modules/
rm /home/modules/hadoop-2.8.3.tar.gz
wget https://hub.nuaa.cf/huaweicloud/obsa-hdfs/raw/master/release/hadoop-huaweicloud-2.8.3-hw-45.jar -P /home/modules
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/common/lib/
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/tools/lib/
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib/
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/hdfs/lib/

# 修改配置文件
cp ./config/core-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/hdfs-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/yarn-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/mapred-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/slaves /home/modules/hadoop-2.8.3/etc/hadoop/

# 新建两个配置文件中指定的目录
mkdir -p /home/modules/data/buf
mkdir -p /home/nm/localdir
# 分发hadoop包给slave
source ./distribute.sh

# 配置环境变量
source ./set_env.sh
ssh -o StrictHostKeyChecking=no root@slave1 < ./set_env.sh
ssh -o StrictHostKeyChecking=no root@slave2 < ./set_env.sh
