smallstep-ca
=========

Install and setup SmallStep CA

Requirements
------------

NA

Role Variables
--------------

- stepca_oidc_client_id:
- stepca_oidc_client_secret:
- stepca_allowed_domain:
- stepca_ca_name:
- stepca_root_key_password:
- stepca_email:
- stepca_stepcli_version:
- stepca_dns_names:

Dependencies
------------

- smallstep-ca:  the step-ca running

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - role: smallstep-ca
           vars:
             x: 42

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
