server-snmp
=========

install and config SNMP

Requirements
------------

NA

Role Variables
--------------

- snmp_location: the location of the host
- snmp_contact: who to contact
- snmp_port: what port does it run on
- snmp_access: an array of community and hosts

```
snmp_access:
  - community: horwood
    hosts: 192.168.1.1
  - community: horwood
    hosts: 192.168.1.0/24
```

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
    - role: server-snmp
      vars:
        snmp_port: udp:161
        snmp_access:
          - community: horwood
             hosts: 192.168.1.1
          - community: horwood
             hosts: 192.168.1.0/24
        snmp_contact: host <email@address.com>
        snmp_location: a small hole in the floor

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
