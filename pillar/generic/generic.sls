#
# Configure hosts. All application servers need to be configured with the below$
# in order for applications to function correctly. The 'tunnel2uprightds' hostn$
# used by the 'server-sync' profile to configure an SSH tunnel to the 'uprightd$
# server.
#
hosts:
  10.131.35.108: kmaster
  10.131.36.35: kworker-alpha
  10.131.34.23: kworker-bravo
  10.131.7.153: kworker-charlie
