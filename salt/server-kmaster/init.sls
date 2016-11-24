configure-kube-controller-manager:
  file.managed:
    - name: /etc/systemd/system/kube-controller-manager.service
    - user: root
    - group: root
    - source: salt://server-kmaster/etc/systemd/system/kube-controller-manager.service
    - template: jinja
    - clean: True
