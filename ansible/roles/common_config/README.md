Common Config
=========

Packages and configuration details that are common across all clients

This includes packages needed to manage things such as apt or selinux
from within ansible but *should not* include configuration of users or
similar.

Requirements
------------

None

Role Variables
--------------

This role should only require variables such as distro-specific
package names.

Dependencies
------------

This role *must not* depend on any other roles

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: common_config }

License
-------

MIT

Author Information
------------------

Matthew Macdonald-Wallace <matthew@devopsguys.com>
