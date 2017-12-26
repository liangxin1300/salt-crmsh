
generate corosync authkey:
  cmd.run:
    - name: '{{ salt['pillar.get']('corosync_keygen') }}'
    - fire_event: True
    - unless: ! test -f {{ salt['pillar.get']('corosync_authkey') }}
