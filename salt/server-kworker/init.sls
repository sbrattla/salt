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
