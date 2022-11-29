

tar zcvf /home/modules/hadoop-2.10.2
ssh root@slave1 "mkdir -p /home/modules" && scp -r /home/modules/hadoop-2.10.2.tar.gz root@slave1:/home/modules
ssh root@slave2 "mkdir -p /home/modules" && scp -r /home/modules/hadoop-2.10.2.tar.gz root@slave2:/home/modules

ssh root@slave1 "cd /home/modules && tar xzvf hadoop-2.10.2.tar.gz"
ssh root@slave2 "cd /home/modules && tar xzvf hadoop-2.10.2.tar.gz"

source ./set_env.sh
ssh -o StrictHostKeyChecking=no root@slave1 source -s < ./set_env.sh 
ssh -o StrictHostKeyChecking=no root@slave2 source -s < ./set_env.sh 
