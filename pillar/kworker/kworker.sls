#
# Configure cluster configuration
# 
# ip: [ip]
# hostname: [hostname]
initial-cluster: kworker-alpha=http://kworker-alpha:2380,kworker-bravo=http://kworker-bravo:2380,kworker-charlie=http://kworker-charlie:2380
etcd-endpoints: http://kworker-alpha:2379, http://kworker-bravo:2379, http://kworker-charlie:2379
