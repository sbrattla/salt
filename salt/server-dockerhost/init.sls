{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

docker:
  pkgrepo.managed:
    - humanname: Docker Engine Repository
    - name: "deb https://apt.dockerproject.org/repo ubuntu-xenial main"
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 2C52609D
    - keyserver: p80.pool.sks-keyservers.net
  pkg.installed:
    - pkgs:
      - linux-image-extra-{{ kernelrelease }}
      - aufs-tools
      - apt-transport-https
      - ca-certificates
      - docker-engine
  cmd.run:
      - name: modprobe auf
      - unless: modinfo aufs > /dev/null 2>&1
  group.present:
    - gid: 999
    - members:
      - administrator
  file.replace:
    - name: /etc/default/docker
    - pattern: ^#DOCKER_OPTS.*$
    - repl: DOCKER_OPTS="--dns 8.8.8.8 -s aufs"