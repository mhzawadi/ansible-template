rclone
=========

Install rclone and setup config

Requirements
------------

NA

Role Variables
--------------

- rclone_arch:       the architecture to install
- rclone_b2_account: the backblaze account ID, also used to copy up config
- rclone_b2_key:     backblaze account key
- rclone_b2_endpoint backblaze endpoint

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
    - role: rclone
      vars:
        rclone_arch: amd64
        rclone_b2_account: q5af38socj2v4s2or4
        rclone_b2_key: XbqJXG2f6kcNkGC3UXWenQ
        rclone_b2_endpoint: s3.us-west-002.backblazeb2.com

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
