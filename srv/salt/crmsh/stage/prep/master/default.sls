
sync master:
  salt.state:
    - tgt: '*'
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
    - tgt_type: compound
    - sls: crmsh.corosync.keysync
    - failhard: True


create corosync conf:
  salt.state:
    - tgt: '{{ salt['pillar.get']('minion_nodes') }}'
    - tgt_type: compound
    - sls: crmsh.corosync.config
    - failhard: True


start pacemaker:
  salt.state:
    - tgt: '{{ salt['pillar.get']('minion_nodes') }}'
    - tgt_type: compound
    - sls: crmsh.pacemaker.start
    - failhard: True
