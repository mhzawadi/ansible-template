server-ssh
=========

setup SSH server

Requirements
------------

- NA

Role Variables
--------------

- ssh_port: a custom port

Dependencies
------------

- NA

Example Playbook
----------------

- hosts: servers
  roles:
    - role: server-ssh
     vars:
       ssh_port: 49

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
