{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

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
