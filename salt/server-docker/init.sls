{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

docker:
  pkgrepo.managed:
    - humanname: Docker Engine Repository
    - name: "deb https://apt.dockerproject.org/repo ubuntu-xenial main"
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 58118E89F3A912897C070ADBF76221572C52609D
    - keyserver: hkp://p80.pool.sks-keyservers.net:80
  pkg.installed:
    - pkgs:
      - linux-image-extra-{{kernelrelease}}
      - apt-transport-https
      - ca-certificates
      - docker-engine
  group.present:
    - gid: 999
    - members:
      - administrator

docker-compose:
  cmd.run:
    - name: 'curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/lo$
    - creates: /usr/local/bin/docker-compose

/usr/local/sbin/docker-gc:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://server-docker/usr/local/sbin/docker-gc
