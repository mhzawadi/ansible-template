deb-interface
=========

Setup custom interfaces

Requirements
------------

- NA

Role Variables
--------------

- interface_ipv6_address: the address to use
- interface_ipv6_gateway: the gateway to use

Dependencies
------------

- NA

Example Playbook
----------------

```
- hosts: servers
  roles:
    - role: deb-interface
      vars:
        interface_ipv6_address: "fe80::cc83:79ff:fe6a:1553/64"
        interface_ipv6_gateway: "fe80::/64"
```

License
-------

MIT

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
