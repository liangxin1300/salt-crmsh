
sync master:
  salt.state:
    - tgt: '{{ salt['pillar.get']('minion_nodes') }}'
    - sls: crmsh.sync

create corosync key:
  salt.state:
    - tgt: '{{  salt.saltutil.runner('select.one_minion') }}'
    - sls: crmsh.corosync.keygen
