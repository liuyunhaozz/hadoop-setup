# 配置 host 信息，默认命名为master, slave1, slave2
hosts=($1 $2 $3) 
names=(master slave1 slave2)


for i in "${!names[@]}";   
do  
    echo "${hosts[$i]} ${names[$i]}" >> /etc/hosts 
done  

