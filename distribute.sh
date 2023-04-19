# Distribute the hadoop package of the master node to slave1, slave2
tar zcvf /home/modules/hadoop-2.8.3.tar.gz -C /home/modules/ hadoop-2.8.3/
ssh root@slave1 "mkdir -p /home/modules" && scp -r /home/modules/hadoop-2.8.3.tar.gz root@slave1:/home/modules
ssh root@slave2 "mkdir -p /home/modules" && scp -r /home/modules/hadoop-2.8.3.tar.gz root@slave2:/home/modules

ssh root@slave1 "cd /home/modules && tar xzvf hadoop-2.8.3.tar.gz"
ssh root@slave2 "cd /home/modules && tar xzvf hadoop-2.8.3.tar.gz"
