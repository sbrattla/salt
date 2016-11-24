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
# kubernetes
#
install-kubernetes:
  cmd.run:
    - name: /tmp/install-kubernetes
    - unless: test -f /opt/kubernetes/kubernetes.installed
