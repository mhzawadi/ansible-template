smallstep-cli
=========

Install and setup SmallStep Cli

Requirements
------------

NA

Role Variables
--------------

- stepcli_version: the version of of the cli tool

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
     - role: smallstep-cli
       vars:
        - stepcli_version: 0.22.0

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
