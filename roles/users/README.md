users
=========

Setup my users

Requirements
------------

- the ssh client

Role Variables
--------------

- user_pi: if installing on a Pi remove access to the account
- users_list: the list of users to add, also generate or upload SSH key

```
users_list:
  - name: test1
    password: "password hash here"
    gen_ssh_key: false
    ssh_key: "ssh key here"
  - name: test2
    password: "password hash here"
    gen_ssh_key: true
    ssh_key: false
```

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
     - role: users
       vars:
         user_pi: false
         users_list:
           - name: test1
             password: "password hash"
             gen_ssh_key: false
             ssh_key: "ssh key"
           - name: test2
             password: "password hash"
             gen_ssh_key: true
             ssh_key: false

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
