nginx
=========

Install and config nginx

Requirements
------------

NA

Role Variables
--------------

- enable_all: true [Binary variable.
    True will link all sites_available conf files to sites_enabled, false will not link them. This defaults to true.]
- nginx_config: the template files to upload
- update_config: drop and reload config

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
     - role: nginx
       vars:
        enable_all: false
        nginx_config_template: home
        update_config: false

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
