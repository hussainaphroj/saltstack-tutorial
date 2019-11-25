{% from "mysql/map.jinja" import mysql with context %}
mysql_root_user:
  mysql_user.present:
    - name: {{ pillar['mysql']['root']['name'] }}
    - password: {{ pillar['mysql']['root']['password'] }}
    - host: localhost
