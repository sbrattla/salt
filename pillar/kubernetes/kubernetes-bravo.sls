name: kubernetes-bravo
advertise-client-urls: http://kubernetes-bravo:2379
initial-advertise-peer-urls: http://kubernetes-bravo:2380
initial-cluster: kubernetes-alpha=http://kubernetes-alpha:2380,kubernetes-bravo=http://kubernetes-bravo:2380,kubernetes-charlie=http://kubernetes-charlie:2380

