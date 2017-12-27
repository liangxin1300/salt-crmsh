
sync master:
  salt.state:
    - tgt: '{{ salt['pillar.get']('minion_nodes') }}'
    - sls: crmsh.sync
    - failhard: True


create corosync key:
  salt.state:
    - tgt: '{{ salt.saltutil.runner('select.one_minion') }}'
    - sls: crmsh.corosync.keygen
    - failhard: True


get key:
  salt.runner:
    - name: authkey.get
    - node: {{ salt.saltutil.runner('select.one_minion') }}
    - onchanges:
      - create corosync key


sync key:
  salt.state:
    - tgt: '{{ salt['pillar.get']('minion_nodes') }}'
    - sls: crmsh.corosync.keysync
    - failhard: True
