Role Name
=========

Installs and configures NTP server.

Requirements
------------

None

Role Variables
--------------

`ntp_server` defines the NTP server used in the ntp.conf template.

Dependencies
------------

None

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: ntp, ntp_server: 1.2.3.4 }


License
-------

MIT

Author Information
------------------

