#
# Software
#

fail2ban:
  pkg.installed:
    - pkgs:
      - fail2ban

software-properties-common:
  pkg.installed:
    - pkgs:
      - software-properties-common

{% if grains['oscodename'] == 'trusty' %}
python-software-properties:
  pkg.installed:
    - pkgs:
      - python-software-properties
{% endif %}

debconf-utils:
  pkg.installed:
    - pkgs:
      - debconf-utils

duplicity:
  pkg.installed:
    - pkgs:
      - duplicity
      - ncftp
      - lftp

wget:
  pkg.installed:
    - pkgs:
      - wget

telnet:
  pkg.installed:
    - pkgs:
      - telnet

nano:
  pkg.installed:
    - pkgs:
      - nano

ssh:
  pkg.installed:
    - pkgs:
      - openssh-server
  service:
    - running

traceroute:
  pkg.installed:
    - pkgs:
      - traceroute

lsof:
  pkg.installed:
    - pkgs:
      - lsof

nfs:
  pkg.installed:
    - pkgs:
      - nfs-common

htop:
  pkg.installed:
    - pkgs:
      - htop

# Configure timezone
/usr/local/bin/updateconfig:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://server-generic/usr/local/bin/updateconfig

# Configure timezone
/etc/timezone:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://server-generic/etc/timezone
  cmd.wait:
    - name: dpkg-reconfigure -f noninteractive tzdata
    - watch:
      - file: /etc/timezone

# Set message of the day / login message
/etc/motd:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://server-generic/etc/motd
    - template: jinja

# Add default sudoers file to server
/etc/sudoers.d/default:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://server-generic/etc/sudoers.d/default

# Add SSH server configuration
/etc/ssh/sshd_config:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://server-generic/etc/ssh/sshd_config

# Add SALT minion configuration
/etc/salt/minion:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - source: salt://server-generic/etc/salt/minion

# Add administrator user
administrator:
  user.present:
    - uid: 1100
    - fullname: Administrator
    - password: $1$xyz$vEGZQdEO58lLqJO2eiEPD/
    - shell: /bin/bash
    - home: /home/administrator


{% for ip, hosts in pillar.get('hosts', {}).items() %}
{{ip}}:
  host.present:
    - ip: {{ip}}
    - names:
      - {{hosts}}
{% endfor %}

