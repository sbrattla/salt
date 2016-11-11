name: kubernetes-charlie
ip: 178.62.102.213
advertise-client-urls: http://kubernetes-charlie:2379
initial-advertise-peer-urls: http://kubernetes-charlie:2380
initial-cluster: kubernetes-alpha=http://kubernetes-alpha:2380,kubernetes-bravo=http://kubernetes-bravo:2380,kubernetes-charlie=http://kubernetes-charlie:2380
etcd-endpoints: http://kubernetes-alpha:2379, http://kubernetes-bravo:2379, http://kubernetes-charlie:2379

