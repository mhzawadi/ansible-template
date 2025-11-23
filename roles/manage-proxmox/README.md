manage-proxmox
=========

Build and boot LXC or KVM systems

Requirements
------------

NA

Role Variables
--------------

- api_user:
- api_password:
- api_host:
- node:
- pve_lxc_template:
- pve_kvm_template:

Dependencies
------------

A list of other roles hosted on Galaxy should go here, plus any details in regards to parameters that may need to be set for other roles, or variables that are used from other roles.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - role: manage-proxmox
           vars:
             x: 42

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
