{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

prepare-home:
  file.recurse:
    - name: /opt
    - user: root
    - group: root
    - file_mode: 0644
    - dir_mode: 0755
    - source: salt://server-kworker/opt
    - include_empty: True

prepare-installers:
  file.recurse:
    - name: /tmp
    - user: root
    - group: root
    - file_mode: 0754
    - dir_mode: 0755
    - source: salt://server-kworker/tmp
    - include_empty: True

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
    - source: salt://server-kworker/etc/systemd/system/etcd.service
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
    - source: salt://server-kworker/etc/systemd/system/flannel.service
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
    - skip_verify: True
    - pkgs:
      - linux-image-extra-{{kernelrelease}}
      - apt-transport-https
      - ca-certificates
      - docker-engine
  group.present:
    - name: docker
    - gid: 999
    - members:
      - administrator

configure-docker:
  file.managed:
    - name: /etc/systemd/system/docker.service
    - user: root
    - group: root
    - source: salt://server-kworker/etc/systemd/system/docker.service
    - template: jinja
    - clean: True

#
# kubelet
#
configure-kubelet:
  file.managed:
    - name: /etc/systemd/system/kubelet.service
    - user: root
    - group: root
    - source: salt://server-kworker/etc/systemd/system/kubelet.service
    - template: jinja
    - clean: True
