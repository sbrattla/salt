#
# Software
#
mariadb:
  file.managed:
    - name: /etc/apt/preferences.d/mariadb.pref
    - source: salt://server-mariadb/etc/apt/preferences.d/mariadb.pref
  pkgrepo.managed:
    - humanname: MariaDB 10.3 Repository
    - name: deb [arch=amd64,i386] http://mirror.one.com/mariadb/repo/10.3/ubuntu xenial main
    - dist: xenial
    - file: /etc/apt/sources.list.d/mariadb.list
    - keyid: F1656F24C74CD1D8
    - keyserver: hkp://keyserver.ubuntu.com:80
  pkg.installed:
    - skip_verify: True
    - pkgs:
      - mariadb-server
      - mariadb-client
      - python-mysqldb
  debconf.set:
    - data:
        'mysql-server/root_password_again': {'type': 'password', 'value': 'root'}
        'mysql-server/root_password': {'type': 'password', 'value': 'root'}
        'mysql-server/start_on_boot': {'type': 'boolean', 'value': 'true'}
    - require_in:
      - pkg: mariadb       

mysql_multi_patch:
  file.managed:
    - name: /tmp/mysqld_multi_pidcheck.patch 
    - source: salt://server-mariadb/tmp/mysqld_multi_pidcheck.patch 
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: patch /usr/bin/mysqld_multi -i /tmp/mysqld_multi_pidcheck.patch
    - creates: /usr/bin/mysqld_multi.orig

mysql_startup:
  file.managed:
    - name: /etc/systemd/system/mysqld_multi@.service
    - source: salt://server-mariadb/etc/systemd/system/mysqld_multi@.service
    - user: root
    - group: root
    - mode: 644
  
xtrabackup:
  pkg.installed:
    - skip_verify: True
    - pkgs:
      - percona-xtrabackup

#
# Configurations
#

/etc/mysql/my.cnf.default:
  file.managed:
    - source: salt://server-mariadb/etc/mysql/my.cnf.default
    - user: root
    - group: root
    - mode: 644

/etc/mysql/conf.d:
  file.recurse:
    - user: root
    - group: root
    - source: salt://server-mariadb/etc/mysql/conf.d
    - template: jinja
    - clean: True
