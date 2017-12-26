# -*- coding: utf-8 -*-

import sys
import os
import salt.client


class MinionNodes(object):
    """
    The minion_nodes pillar variable constrains which minions to use.
    """

    def __init__(self, **kwargs):
        """
        Initialize client and variables
        """
        self.local = salt.client.LocalClient()
        self.minion_nodes = self._query()

    def _query(self):
        """
        Returns the value of minion_nodes
        """
        # When search matches no minions, salt prints to stdout.
        # Suppress stdout.
        _stdout = sys.stdout
        sys.stdout = open(os.devnull, 'w')

        self.local.cmd('*', 'saltutil.pillar_refresh')
        minions = self.local.cmd('*', 'pillar.get', ['minion_nodes'],
                                 tgt_type="compound")
        sys.stdout = _stdout
        for minion in minions:
            if minions[minion]:
                return minions[minion]

        return []


def show(**kwargs):
    target = MinionNodes()
    return target.minion_nodes
