lvm
=========

Make an LVM

Requirements
------------

NA

Role Variables
--------------

- physical_devices : The devices to partition
- lvm_group_name : The group
- lvm_physical_devices : The device to add the LVM too
- lvm_logical_volume_name : The volume that will have the file system on it
- lvm_mount_point : Where to mount the LV

Dependencies
------------

NA

Example Playbook
----------------

- hosts: servers
  roles:
    - role: lvm
      vars:
        - physical_devices: '/dev/sdb'
        - lvm_group_name: 'vg_data'
        - lvm_physical_devices: '/dev/sdb1'
        - lvm_logical_volume_name: 'lv_data'
        - lvm_mount_point: 'data'

License
-------

BSD

Author Information
------------------

Matthew Horwood <matt@horwood.biz>
