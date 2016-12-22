# Security Baseline

Sets sensible defaults for linux servers based on best practice

## Variables

| Variable | Description | Default |
|----------|-------------|---------|
| user_inactivity_timeout | the number of seconds a user should be inactive for before their connection is terminated | 300 (5 minutes) |
| baseline_security.templates | A hash of template files to be shipped to disk, see the examples below for more details | N/A |
| baseline_security.login_defs | A hash of perameters for /etc/login.defs and associated values | N/A |

## Examples

### baseline_security.templates

The `baseline_security.templates` hash allows you to create multiple templates
and roll them all out with a single task.

To role out the template, create the file in the "templates" directory and
create an associated hash as follows:

```
baseline_security:
    templates:
        - template_name: 'autologout.sh'
          template_destination: '/etc/profile.d'
          template_mode: '0755'
          template_owner: 'root'
          template_group: 'root'
```

This will deploy a template called `autologout.sh` to
`/etc/profile.d/autologout.sh`, set the owner and group to `root` and set the
mode of the file to `755`.

*NOTE:* By default, the owner is `root`, the group is `root` and the mode is
`0640`, so only `root` will be allowed to read these files.  This is deliberate
and ensures least privilege.

### baseline_security.login_defs

The `baseline_security.login_defs` set values in `/etc/login.defs`.  Most of
the options in this file are now obsolete, however, there are a few that
surround password expiry times that have not yet been integrated into PAM
modules.

As with `baseline_security.templates`, you need to provide a hash as follows:

```
baseline_security:
    login_defs:
        - name: PASS_MAX_DAYS
          value: 90
        - name: PASS_MIN_DAYS
          value: 0
        - name: PASS_WARN_AGE
          value: 7
```

This will set the maximum password age to 90 days, the minimum age to 0 days
and the warning on login to seven days before the password expires
