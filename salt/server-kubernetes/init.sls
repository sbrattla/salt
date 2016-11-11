install-prerequisites:
  pkg.installed:
    - pkgs:
      - build-essential
      - bison
      - git
      - curl

install-go-version-manager:
  file.managed:
    - mode: 0544
    - name: /tmp/install-go-version-manager
    - source: salt://server-kubernetes/tmp/install-go-version-manager
  cmd.run:
    - name: /tmp/install-go-version-manager

install-etcd:
  file.managed:
    - mode: 0544
    - name: /tmp/install-etcd
    - source: salt://server-kubernetes/tmp/install-etcd
  cmd.run:
    - name: /tmp/install-etcd

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

/etc/systemd/system/flannel.service:
  file.managed:
    - user: root
    - group: root
    - source: salt://server-kubernetes/etc/systemd/system/flannel.service
    - template: jinja
    - clean: True
