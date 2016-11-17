{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

install-prerequisites:
  pkg.installed:
    - pkgs:
      - build-essential
      - bison
      - git
      - curl

prepare-home:
  file.recurse:
    - name: /opt
    - user: root
    - group: root
    - file_mode: 0644
    - dir_mode: 0755
    - source: salt://server-kubernetes/opt
    - include_empty: True

prepare-installers:
  file.recurse:
    - name: /tmp
    - user: root
    - group: root
    - file_mode: 0754
    - dir_mode: 0755
    - source: salt://server-kubernetes/tmp
    - include_empty: True
#
# certificates
#
configure-certs:
  cmd.run:
    - name: /tmp/configure-certs
    - unless: test -f /opt/certs/ca.csr

#
# gvm
#
install-gvm:
  cmd.run:
    - name: /tmp/install-gvm
    - unless: test -f /opt/kubernetes/gvm.installed

# 
# etcd
#
install-etcd:
  cmd.run:
    - name: /tmp/install-etcd
    - unless: test -f /opt/etcd/etcd.installed

configure-etcd:
  file.managed:
    - name: /etc/systemd/system/etcd.service
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/etcd.service
    - template: jinja
    - clean: True

#
# flannel
#
install-flannel:
  cmd.run:
    - name: /tmp/install-flannel
    - unless: test -f /opt/kubernetes/flannel.installed

configure-flannel:
  file.managed:
    - name: /etc/systemd/system/flannel.service
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/flannel.service
    - template: jinja
    - clean: True

#
# docker
#
install-docker:
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
    - name: docker
    - gid: 999
    - members:
      - administrator
  file.replace:
    - name: /etc/default/docker
    - pattern: ^#DOCKER_OPTS.*$
    - repl: DOCKER_OPTS="--dns 8.8.8.8 -s aufs"

configure-docker:
  file.managed:
    - name: /etc/systemd/system/docker.service
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/docker.service
    - template: jinja
    - clean: True

#
# kubernetes
#
install-kubernetes:
  cmd.run:
    - name: /tmp/install-kubernetes
    - unless: test -f /opt/kubernetes/kubernetes.installed  

configure-kube-controller-manager:
  file.managed:
    - name: /etc/systemd/system/kube-controller-manager.service
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/kube-controller-manager.service
    - template: jinja
    - clean: True
