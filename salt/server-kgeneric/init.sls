{% set kernelrelease = salt['grains.get']('kernelrelease') -%}

install-prerequisites:
  pkg.installed:
    - pkgs:
      - build-essential
      - bison
      - git
      - curl

#
# kubernetes
#
install-kubernetes:
  file.managed:
    - name: /tmp/install-kubernetes
    - user: root
    - group: root
    - file_mode: 0754
    - dir_mode: 0755
    - source: salt://server-kgeneric/tmp/install-kubernetes
  cmd.run:
    - name: /tmp/install-kubernetes
    - unless: test -f /opt/kubernetes/kubernetes.installed
