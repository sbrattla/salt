`su root`

`wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -`

`echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list`

`apt-get update`

`apt-get install -y python-software-properties`

`apt-get install -y software-properties-common`

`apt-get install -y salt-minion`

`cd /var/local`

`git clone https://github.com/sbrattla/salt.git salt`

`ln -s /var/local/salt/salt /srv/salt`

`ln -s /var/local/salt/pillar /srv/pillar`

`salt-call --local state.highstate`

`sudo systemctl restart salt-minion`
