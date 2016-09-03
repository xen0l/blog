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
date: 2016-09-03T12:10:21+02:00
title: Managing illumos networking with Ansible
---

On August 30th, my work on Ansible modules for managing Solaris/illumos networking was merged into [ansible-modules-extras](https://github.com/ansible/ansible-modules-extras/commits/devel) repository. This functionality will be available in the next release of Ansible. Following modules were contributed:

* [dladm_etherstub](https://docs.ansible.com/ansible/dladm_etherstub_module.html)
* [dladm_vnic](https://docs.ansible.com/ansible/dladm_vnic_module.html)
* [ipadm_if](https://docs.ansible.com/ansible/ipadm_if_module.html)
* [ipadm_prop](https://docs.ansible.com/ansible/ipadm_prop_module.html)
* [flowadm](https://docs.ansible.com/ansible/flowadm_module.html)

This also marks a major milestone for automating the deployment of Solaris/illumos zones with Ansible. There already was a module for creating/deleting zones and manipulating their state - [solaris_zone](https://docs.ansible.com/ansible/solaris_zone_module.html). However, there was not a way to manage the networking aspect of zones until now.

In the future, I have plans to contribute more modules for Solaris/illumos networking management and also other aspects of these systems. I have collected some module ideas in the [Github repository](https://github.com/xen0l/ansible-illumos-modules). If you have any module ideas, be sure to create an issue of send a PR to the repository.