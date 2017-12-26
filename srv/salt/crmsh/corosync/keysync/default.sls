
sync key file:
  file.managed:
    - name: {{ salt['pillar.get']('corosync_authkey') }}
    - source: salt://authkey
    - mode: 400
