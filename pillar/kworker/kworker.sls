#
# Configure hosts. All application servers need to be configured with the below$
# in order for applications to function correctly. The 'tunnel2uprightds' hostn$
# used by the 'server-sync' profile to configure an SSH tunnel to the 'uprightd$
# server.
#
hosts:
  10.131.36.35: kubernetes-alpha
  10.131.36.36: kubernetes-bravo
  10.131.7.153: kubernetes-charlie

#
# Configure cluster configuration
# 
# ip: [ip]
# hostname: [hostname]
initial-cluster: kubernetes-alpha=http://kubernetes-alpha:2380,kubernetes-bravo=http://kubernetes-bravo:2380,kubernetes-charlie=http://kubernetes-charlie:2380
etcd-endpoints: http://kubernetes-alpha:2379, http://kubernetes-bravo:2379, http://kubernetes-charlie:2379

