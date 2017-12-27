# -*- coding: utf-8 -*-

import sys
import os
import salt.client


def get(node):
    local = salt.client.LocalClient()
    authkey = local.cmd(node, 'pillar.get', ['corosync_authkey'])
    result = local.cmd(node, 'file.read', [authkey[node]])
    with open("/srv/salt/authkey", 'w') as f:
        f.write(result[node])

    return True
