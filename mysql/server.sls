{% from "mysql/map.jinja" import mysql with context %}
mysql_server_install:
  pkg.installed:
    - name: {{ mysql.server }}
