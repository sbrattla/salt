base:
  '*kworker*':
    - server-generic
    - server-kgeneric
    - server-docker
    - server-kworker
  '*kmaster*':
    - server-generic
    - server-kgeneric
    - server-kmaster
  '*dregistry*':
    - server-generic
    - server-docker
