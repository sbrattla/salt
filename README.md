This repository will provision either a (a) Kubernetes master or (b) Kubernetes worker. Currently 3 worker nodes are assumed, and the IP addresses are fixed.

The master must have the hostname 'kmaster' and the workers must have the hostnames 'kworker-alpha', 'kworker-bravo' and 'kworker-charlie'.

```
source <(curl -s https://github.com/sbrattla/salt/blob/master/provision.sh)
```
