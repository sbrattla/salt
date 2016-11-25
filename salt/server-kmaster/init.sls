/opt/kubernetes:
  file.recurse:
    - user: root
    - group: root
    - file_mode: 0644
    - dir_mode: 0755
    - source: salt://server-kmaster/opt/kubernetes
    - include_empty: True

configure-kube-controller-manager:
  file.managed:
    - name: /etc/systemd/system/kube-controller-manager.service
    - user: root
    - group: root
    - source: salt://server-kmaster/etc/systemd/system/kube-controller-manager.service
    - template: jinja
    - clean: True

configure-kube-apiserver:
  file.managed:
    - name: /etc/systemd/system/kube-apiserver.service
    - user: root
    - group: root
    - source: salt://server-kmaster/etc/systemd/system/kube-apiserver.service
    - template: jinja
    - clean: True

configure-kube-scheduler:
  file.managed:
    - name: /etc/systemd/system/kube-scheduler.service
    - user: root
    - group: root
    - source: salt://server-kmaster/etc/systemd/system/kube-scheduler.service
    - template: jinja
    - clean: True
