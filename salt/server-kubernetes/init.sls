install-prerequisites:
  pkg.installed:
    - pkgs:
      - build-essentials
      - bison
      - git
      - curl

install-go-version-manager:
  file.managed:
    - name: /tmp/install-go-version-manager
    - source: salt://server-kubernetes/tmp/install-go-version-manager
  cmd.run:
    - name: /tmp/install-go-version-manager
