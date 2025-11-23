nagios
=========

Install Nagios

Requirements
------------

NA

Role Variables
--------------

- nagios_reinstall:   if nagios should be reinstalled
- nagios_ver:         the version to install
- nagios_plugins_ver: the plugin version
- nagios_debs:        the extra packages to install
- nagios_admin_pw:    the password for the admin account
- nagiostv_version:   the nagiostv version

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
    - role: nagios
      vars:
        x: 42

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
