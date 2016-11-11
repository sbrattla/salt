name: kubernetes-bravo
advertise-client-urls: http://kubernetes-bravo:2379
initial-advertise-peer-urls: http://kubernetes-bravo:2380
initial-cluster: kubernetes-alpha=https://kubernetes-alpha:2380,kubernetes-bravo=https://kubernetes-bravo:2380,kubernetes-charlie=https://kubernetes-charlie:2380

