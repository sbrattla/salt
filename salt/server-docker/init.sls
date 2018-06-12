{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

deployer:
  user.present:
    - uid: 1200
    - fullname: Deployer
    - shell: /bin/bash
    - home: /home/deployer

docker-dependencies:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - ca-certificates
      - curl
      - software-properties-common

docker:
  pkgrepo.managed:
    - humanname: Docker Engine Repository
    - name: "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"
    - file: /etc/apt/sources.list.d/docker.list
    - key_url: https://download.docker.com/linux/ubuntu/gpg
  pkg.installed:
    - pkgs:
      - docker-ce
  group.present:
    - gid: 999
    - members:
      - administrator
      - deployer
  
/usr/local/sbin/docker-gc:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://server-docker/usr/local/sbin/docker-gc

/etc/systemd/system/docker.service.d/overrides.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - makedirs: True
    - source: salt://server-docker/etc/systemd/system/docker.service.d/overrides.conf
