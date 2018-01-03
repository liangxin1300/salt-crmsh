# salt-crmsh

## How to use it:

#### prepare:

  - 3 nodes(leap 42.3): salt-1, salt-2, salt-3
  
  - firewall disabled
  
  - salt-1 as master node; salt-2 and salt-3 as minion nodes, also as cluster nodes
  
  - on salt-1:
     > zypper install salt-master salt-minion
     
     > systemctl enable salt-master
     
     > systemctl enable salt-minion
     
     > systemctl start salt-master
     
     > systemctl start salt-minion
     
  - on salt-2 and salt-3:
     > zypper install salt-minion crmsh
     
     > systemctl enable salt-minion
     
     > systemctl start salt-minion
     
  - on all nodes:

     edit /etc/salt/minion, point to salt-1 hostname or address
     
  - on salt-1:
  
     accept all minions' keys;
     
     salt '*' test.ping
     
  - in /salt-crmsh/srv
  
     scp -rp * root@salt-1:/srv



#### configure:
  - on salt-1:
  
     in /srv/pillar/crmsh/constents.sls, edit "bind net address/multicast address/multicast port";

     edit master_minion.sls and minion_nodes.sls if hostname changed.


#### run:
  - on salt-1: 
    
    > salt-run state.orch crmsh.stage.0
    
    > salt-run state.orch crmsh.stage.1


then cluster service is started.
