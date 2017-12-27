# -*- coding: utf-8 -*-

import salt.client
import minion_nodes


def minions():
    local = salt.client.LocalClient()
    target = minion_nodes.MinionNodes()
    search = target.minion_nodes
    _minions = local.cmd(search, 'grains.get', ['id'], tgt_type="compound").values()

    return _minions


def one_minion():
    ret = minions()
    
    return ret[0]
