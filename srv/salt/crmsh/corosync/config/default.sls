
create corosync.conf:
  file.managed:
    - name: {{ salt['pillar.get']('corosync_config') }}
    - source: salt://corosync.conf.j2
    - template: jinja
    - replace: False
    - context:
      bindnet_addr: {{ salt['pillar.get']('bind net address') }}
      mcast_addr: {{ salt['pillar.get']('multicast address') }}
      mcast_port: {{ salt['pillar.get']('multicast port') }}
