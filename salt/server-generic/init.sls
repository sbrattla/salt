#
# Software
#

software-properties-common:
  pkg.installed:
    - pkgs:
      - software-properties-common

python-software-properties:
  pkg.installed:
    - pkgs:
      - python-software-properties

debconf-utils:
  pkg.installed:
    - pkgs:
      - debconf-utils

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

# Add sebastian user
administrator:
  user.present:
    - uid: 1000
    - fullname: Administrator
    - password: $1$K1AdZDQi$B2TdOmQJ3SGpe2uGEQskX1
    - shell: /bin/bash
    - home: /home/administrator


{% if pillar['hosts'] is defined %}
{% for ip, hosts in pillar.get('hosts', {}).items() %}
{{host}}:
  host.present:
    - ip: {{ip}}
    - names:
      - {{hosts}}
{% endfor %}
{% endif %}

