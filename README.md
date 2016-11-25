This repository will provision either a (a) Kubernetes master or (b) Kubernetes worker. Currently 3 worker nodes are assumed, and the IP addresses are fixed.

The master must have the hostname 'kmaster' and the workers must have the hostnames 'kworker-alpha', 'kworker-bravo' and 'kworker-charlie'.

```
cd /tmp
source <(curl -s https://raw.githubusercontent.com/sbrattla/salt/master/provision.sh)
chmod u+x provision.sh
./provision.sh
```
