
sync runners:
  salt.runner:
    - name: saltutil.sync_runners
    - failhard: True


sync master:
  salt.state:
    - tgt: '*'
    - sls: crmsh.sync
    - failhard: True
