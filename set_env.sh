cat "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk
export HADOOP_HOME=/home/modules/hadoop-2.10.2
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
export HADOOP_CLASSPATH=/home/modules/hadoop-2.10.2/share/hadoop/tools/lib/*:$HADOOP_CLASSPATH" >> /etc/profile

source /etc/profile

