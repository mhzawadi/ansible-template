smallstep-bootstrap-host
=========

This will get an SSH host certificate from our CA and add a weekly cron job to rotate the host certificate.

Requirements
------------

NA

Role Variables
--------------

- ssh_ca_url:         the URL for the step CA
- ssh_ca_domain:      the domain that a user must be in
- ssh_ca_name:        the name of the CA
- ssh_ca_fingerprint: the CA finger print
- ssh_ca_password:    the password for the JWK

Dependencies
------------

- snallstep-cli: install the step-cli
- smallstep-ca:  the step-ca running

Example Playbook
----------------

- hosts: servers
  roles:
     - role: smallstep-bootstrap-host
       vars:
         - ssh_ca_url: 'https://server:8443'
         - ssh_ca_domain: 'example.com'
         - ssh_ca_name: 'example-ca'
         - ssh_ca_fingerprint: 'abcd1234efgh'
         - ssh_ca_password: 'thisissecure'


License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
