# -*- coding: utf-8 -*-

import salt.client


def minions():
    local = salt.client.LocalClient()
    _minions = local.cmd('*', 'grains.get', ['id']).values()

    return _minions


def one_minion():
    ret = minions()
    
    return ret[0]
