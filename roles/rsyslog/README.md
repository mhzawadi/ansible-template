Mayden rsyslog
=========

Installs the rocket-fast system logger

Requirements
------------

N/A

Role Variables
--------------

`mode: install` (string):  *This role can run in install and uninstall modes*

`rsyslog_packages: rsyslog` (list[string]): *The list of packages that should be installed to facilitate rsyslog acting as the system's logging daemon*

Dependencies
------------

N/A

Example Playbook
----------------

```
- hosts: servers
  roles:
      - role: rsyslog
```

License
-------

MIT

Author Information
------------------

Alex Musselwhite [alex.musselwhite@mayden.co.uk]
