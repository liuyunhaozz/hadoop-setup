# main script 
# $1, $2, $3 -> intranet ip of three servers, $4, $5, $6 -> root password of three servers

# Install expect in host 
yum install -y expect
# Configure ssh two by two in the server cluster
source ./autossh.sh $1 $2 $3 $4 $5 $6

# Add host to the three servers, named master, slave1, slave2
source ./autohost.sh $1 $2 $3 
ssh -o StrictHostKeyChecking=no root@slave1 'bash -s' < ./autohost.sh $1 $2 $3
ssh -o StrictHostKeyChecking=no root@slave2 'bash -s' < ./autohost.sh $1 $2 $3

# Install openjdk
yum install -y java-1.8.0-openjdk
ssh root@slave1 "yum install -y java-1.8.0-openjdk"
ssh root@slave2 "yum install -y java-1.8.0-openjdk"

# Download hadoop-2.8.3 and OBS 
wget https://hub.nuaa.cf/liuyunhaozz/hadoop-setup/releases/download/hadoop-2.8.3/hadoop-2.8.3.tar.gz -P /home/modules
tar xzvf /home/modules/hadoop-2.8.3.tar.gz -C /home/modules/
rm /home/modules/hadoop-2.8.3.tar.gz
wget https://hub.nuaa.cf/huaweicloud/obsa-hdfs/raw/master/release/hadoop-huaweicloud-2.8.3-hw-45.jar -P /home/modules
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/common/lib/
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/tools/lib/
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/httpfs/tomcat/webapps/webhdfs/WEB-INF/lib/
cp /home/modules/hadoop-huaweicloud-2.8.3-hw-45.jar /home/modules/hadoop-2.8.3/share/hadoop/hdfs/lib/

# Modify the corresponding configuration file 
cp ./config/core-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/hdfs-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/yarn-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/mapred-site.xml /home/modules/hadoop-2.8.3/etc/hadoop/
cp ./config/slaves /home/modules/hadoop-2.8.3/etc/hadoop/

# Create new directories specified in the two configuration files
mkdir -p /home/modules/data/buf
mkdir -p /home/nm/localdir

# Distribute hadoop package to slave
source ./distribute.sh

# Configure environment variables
source ./set_env.sh
ssh -o StrictHostKeyChecking=no root@slave1 < ./set_env.sh
ssh -o StrictHostKeyChecking=no root@slave2 < ./set_env.sh
