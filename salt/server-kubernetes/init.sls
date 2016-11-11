install-prerequisites:
  pkg.installed:
    - pkgs:
      - build-essential
      - bison
      - git
      - curl

install-gvm:
  file.managed:
    - mode: 0544
    - name: /tmp/install-gvm
    - source: salt://server-kubernetes/tmp/install-gvm
  cmd.run:
    - name: /tmp/install-gvm
    - onlyif: [ ! -f /opt/kubernetes/gvm.installed ] && echo 1

install-etcd:
  file.managed:
    - mode: 0544
    - name: /tmp/install-etcd
    - source: salt://server-kubernetes/tmp/install-etcd
  cmd.run:
    - name: /tmp/install-etcd
    - onlyif: [ ! -f /opt/kubernetes/etcd.installed ] && echo 1

/etc/systemd/system/etcd.service:
  file.managed:
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/etcd.service
    - template: jinja
    - clean: True

install-flannel:
  file.managed:
    - mode: 0544
    - name: /tmp/install-flannel
    - source: salt://server-kubernetes/tmp/install-flannel
  cmd.run:
    - name: /tmp/install-flannel
    - onlyif: [ -f /opt/kubernetes/flannel.installed ] && echo 1

/etc/systemd/system/flannel.service:
  file.managed:
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/flannel.service
    - template: jinja
    - clean: True

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

/etc/systemd/system/docker.service:
  file.managed:
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/docker.service
    - template: jinja
    - clean: True
  
