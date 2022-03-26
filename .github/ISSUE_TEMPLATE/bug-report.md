---
name: Bug Report
about: Report an issue with functionality
title: 'Bug Report: '
labels: ''
assignees: ''

---

**I am using the:**
- [ ] AUR Release
- [ ] Flatpak
- [ ] Manual Install

**Description of Issue:**
Cannot re-enable mod after disabling it.

**Steps to Reproduce:**
1. r2mod setup
2. r2mod install wildbook-TooManyFriends-1.2.1
3. r2mod disable wildbook-TooManyFriends-1.2.1
4. r2mod enable wildbook-TooManyFriends-1.2.1

**Shell Output**
```
$ r2mod disable wildbook-TooManyFriends-1.2.1
→ Disabling: wildbook-TooManyFriends-1.2.1
$ r2mod enable wildbook-TooManyFriends-1.2.1
→ Enabling: wildbook-TooManyFriends-1.2.1
✖ wildbook-TooManyFriends-1.2.1 not found in plugins_disabled
```
