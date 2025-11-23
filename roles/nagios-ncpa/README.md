nagios-ncpa
=========

Install NCPA

Requirements
------------

- NA

Role Variables
--------------

- nagios_ncpa_version: the version to install
- nagios_ncpa_api_key: the API key to use

Dependencies
------------

- NA

Example Playbook
----------------

- hosts: servers
  roles:
     - role: nagios-ncpa
       vars:
         nagios_ncpa_version: 2.4.0
         nagios_ncpa_api_key: my-secret-key

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
