Role Name
=========

Installs a .vimrc file for a given user, specified by the variable vim_user.
This vimrc is entirely based on Mark Phillips' [vimrc](https://github.com/phips/dotfiles/blob/master/default/vimrc).

Requirements
------------


Role Variables
--------------

You need to set vim_user.

Dependencies
------------


Example Playbook
-------------------------

    - hosts: servers
      roles:
         - { role: vim, vim_user: vagrant }

License
-------

BSD

Author Information
------------------

Mark Phillips <mark@devopsguys.com>
