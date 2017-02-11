---
categories:
  - sysadmin
  - OpenIndiana
  - illumos
  - ansible
tags:
  - OpenIndiana
  - ansible
  - networking
date: 2017-02-11T21:35:37+01:00
title: Managing more illumos networking with Ansible
---

On January 9th, the rest of my work on Ansible modules for managing Solaris/illumos networking was accepted into Ansible and this work will be a part of the next release. With this batch of modules almost every aspect of Solaris/illumos networking (apart from link aggregations and bridges) can be configured and managed by Ansible. The following new modules are available in Ansible:

* [dladm_vlan](https://docs.ansible.com/ansible/dladm_vlan_module.html)
* [dladm_linkprop](https://docs.ansible.com/ansible/dladm_linkprop_module.html)
* [dladm_iptun](https://docs.ansible.com/ansible/dladm_iptun_module.html)
* [ipadm_addr](https://docs.ansible.com/ansible/ipadm_addr_module.html)
* [ipadm_addrprop](https://docs.ansible.com/ansible/ipadm_addrprop_module.html)
* [ipadm_ifprop](https://docs.ansible.com/ansible/ipadm_addrprop_module.html)

In the next blog post I will show some real examples how to accomplish useful work with these modules.
