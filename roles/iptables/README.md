iptables
=========

install and configure iptables

Requirements
------------

NA

Role Variables
--------------

- iptables_nets: an array of nets to allow access from
- ip6tables_nets: an array of nets to allow access from

```
ip6tables_nets:
  - net: ::1/128
iptables_nets:
  - net: 192.168.1.0/24
  - net: 192.168.2.0/24
iptables_ports:
  - port: 80
    proto: tcp
  - port: 443
    proto: tcp
```

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
    - role: iptables
      vars:
        iptables_nets:
          - net: 192.168.1.1
        iptables_ports:
          - port: 80
            proto: tcp
          - port: 443
            proto: tcp

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
