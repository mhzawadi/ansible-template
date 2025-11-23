php
=========

Install and config PHP

Requirements
------------

NA

Role Variables
--------------

- php_version:         the version of php to install
- php_extensions:      a list of modules to install (if you need FPM, add it to the list)
- php_pecl_extensions: a list of PECL extensions
- php_pear:            a list of PAER channels and packages

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
    - role: php
      vars:
        php_version: '7.4'
        php_extensions:
          - php7.4-fpm
        php_pecl_extensions:
          - mcrypt

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
