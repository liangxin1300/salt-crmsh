
sync master:
  salt.state:
    - tgt: {{ salt['pillar.get']('master_node') }}
    - sls: crmsh.sync
