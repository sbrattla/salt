# Server Configurations

This repository holds server configurations. The configurations are written using SALT Stack. 

To provision any given server, simply log on to that server and execute the below commands **as root**. It is 
assumed that the server you are about to provision runs on Ubuntu 16.04.

```
cd /tmp && \
  wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add - && \
  echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list && \
  apt-get update && \
  apt-get install -y python-software-properties && \
  apt-get install -y software-properties-common && \
  apt-get install -y salt-minion && \
  cd /var/local && \
  git clone https://github.com/sbrattla/salt.git salt && \
  ln -s /var/local/salt/salt /srv/salt && \
  ln -s /var/local/salt/pillar /srv/pillar && \
  salt-call --local state.highstate && \
  sudo systemctl restart salt-minion
```

# Configuration Update

To update a server with the latest configuration from this repository, simply log on to that server and execute `sudo updateconfig`.

# Hostname

Any given server will be provisioned based on its hostname. Please look at the `salt/top.sls` for a list of hostname which currently
are supported.
