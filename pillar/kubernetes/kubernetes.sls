#
# Configure hosts. All application servers need to be configured with the below$
# in order for applications to function correctly. The 'tunnel2uprightds' hostn$
# used by the 'server-sync' profile to configure an SSH tunnel to the 'uprightd$
# server.
#
hosts:
  138.68.168.20: alpha kubernetes-alpha
  138.68.168.41: bravo kubernetes-bravo
  178.62.102.213: charlie kubernetes-charlie

#
# Configure cluster configuration
# 
# name: [name]
# advertise-client-urls: http://[IP]:2379
# initial-advertise-peer-urls: http://[IP]:2380
# initial-cluster: [name]=[node],[name]=[node]...
# client-urls: [node],[node],[node]

