# Mayden user-mysql

Add new MySQL user

## Requirements

NA

## Role Variables

- mysql_admin:          the admin account to connect as
- mysql_adminPW:        the admin password
- mysql_host:           if not devops, the host the user can connect from
- user_profiles:        (array) human users to add
- iaptus_service_users: (array) iaptus service users to add

  ```
  user_profiles:
  - initials: mho            - initials of the user
    prefix: mayhealthv_      - if a different prefix should be used, defaults to mayhealthv_
    sudo_hash: password      - the user OS password
    mysql_hash: password     - the MySQL password
    ssh_key: <SSHKEY>        - the public ssh key
    devops: 0                - this is GOD permissions on both OS and MySQL
    mysqlRW: 0               - MySQL read and write permissions
    sudo: 0                  - give the sudo, but not GOD access
    hostgroup: 1             - what proxySQL host group to use
    active: 1                - if the user is active in proxySQL
    state: present           - where to create or delete the user
  ```
  ```
  iaptus_service_users:
    - username:     service_name
      password:     *somebighashhere
      database:     IAPTus_Service1
      allowedhost:  10.3.200.%
      hostgroup:    1
  ```
  ## Dependencies

- SSH access to MySQL server

- MySQL server to add user too

## Example Playbook

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

```
- hosts: servers

  vars_prompt:
    - name: "mysql_admin"
      prompt: "Please enter MySQL admin user"
      private: no
    - name: "mysql_adminPW"
      prompt: "Please enter MySQL admin password for {{ mysql_admin }}"
  roles:
     - role: user-mysql
       vars:
         mysql_host: "127.0.0.1"
         user_profiles:
           # Add user without key
           - initials: ml3
             sudo_hash: $6$4zfk0K3CB/6mt8xS$ez1rZlzmkab7FEt0dvOUqyaxgG4LSVUY.jPO7jinDdTrQazG0vlnZT4y6MEPUhiSo2l0V/5CbzGftc27Vsmat/
             ssh_key: false
             devops: false
             sudo: false
             state: present
           - iaptus_service_users:
               - username:     service_name
                 password:     *somebighashhere
                 database:     IAPTus_Service1
                 allowedhost:  10.3.200.%
                 hostgroup:    1
```

## License

BSD

## Author Information

Matthew Horwood [matt.horwood@mayden.co.uk]
