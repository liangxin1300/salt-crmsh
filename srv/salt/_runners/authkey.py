# -*- coding: utf-8 -*-

import sys
import os
import salt.runner
import salt.config
import salt.client


def get():
    __opts__ = salt.config.client_config('/etc/salt/master')
    runner = salt.runner.RunnerClient(__opts__)

    _stdout = sys.stdout
    sys.stdout = open(os.devnull, 'w')
    imp_minion = runner.cmd('select.one_minion')
    sys.stdout = _stdout

    local = salt.client.LocalClient()
    authkey = local.cmd(imp_minion, 'pillar.get', ['corosync_authkey'])
    result = local.cmd(imp_minion, 'file.read', [authkey[imp_minion]])
    with open("/srv/salt/authkey", 'w') as f:
        f.write(result[imp_minion])

    return True
