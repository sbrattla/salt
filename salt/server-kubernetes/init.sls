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
    - cwd: /opt/kubernetes
  cmd.run:
    - name: /tmp/install-etcd
