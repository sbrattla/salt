{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

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

docker-compose:
  cmd.run:
    - name: 'curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose'
    - creates: /usr/local/bin/docker-compose

/usr/local/sbin/docker-gc:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://server-docker/usr/local/sbin/docker-gc
