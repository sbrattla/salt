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
      - apt-transport-https
      - ca-certificates
      - docker-engine
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
    - source: salt://server-kgeneric/etc/systemd/system/docker.service
    - template: jinja
    - clean: True

#
# kubernetes
#
#install-kubernetes:
#  cmd.run:
#    - name: /tmp/install-kubernetes
#    - unless: test -f /opt/kubernetes/kubernetes.installed
