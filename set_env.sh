# 配置环境变量
echo "export JAVA_HOME=\$(readlink -f /usr/bin/java | sed "s:bin/java::")
export HADOOP_HOME=/home/modules/hadoop-2.8.3
export PATH=\$JAVA_HOME/bin:\$PATH
export PATH=\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin:\$PATH
export HADOOP_CLASSPATH=/home/modules/hadoop-2.8.3/share/hadoop/tools/lib/*:\$HADOOP_CLASSPATH" >> /etc/profile

source /etc/profile

