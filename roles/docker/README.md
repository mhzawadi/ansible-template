docker
=========

Install Docker

Requirements
------------

NA

Role Variables
--------------

- docker_arch: what arch to use (amd64, arm64, armhf)


Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
     - role: docker
       vars:
         docker_arch: amd64

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
