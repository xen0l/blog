---
categories:
- OpenIndiana
tags:
- OpenIndiana
comments: true
date: 2012-02-11T00:00:00Z
title: OpenIndiana involvement
url: /2012/02/11/openindiana-involvement/
---

I have been watching OpenSolaris development for a long time. As a technology fan, I really like all the cool features OpenSolaris offers: ZFS filesystem capabilities, service management with SMF, dynamic tracing and application debugging with DTrace, container-based virtualization with Solaris zones, network virtualization with Crossbow, safe system upgrades and downtime minimalization via Boot Environments and integratiom of all these features together makes it perfect operating system for a server. However, OpenSolaris is dead and it continues to live as [OpenIndiana](http://www.openindiana.org), which is a [Illumos](http://www.illumos.org)-based derivate. Illumos is an open source project providing Solaris and OpenSolaris kernel and driver source code. OpenIndiana aims to be a direct continuation of the OpenSolaris operating system.

As a fan and satisfied user of [Zabbix](http://www.zabbix.com) monitoring software, I decided to port, package and maintain Zabbix monitoring suite for OpenIndiana. Zabbix agent already made it to the package repository. Zabbix server and possibly proxy will follow in upcoming months. I am also planning to maintain other software I am actively using e.g tor, php-fpm and DNS related software.

In January I have set up first Slovak OpenIndiana mirror, which is running at [dlc-1.sk.openindiana.org](http://dlc-1.sk.openindiana.org/) and is reachable via both IPv4 and IPv6. Big thanks goes to my employer, [Digmia](http://www.digmia.com), which provided hardware and network bandwidth.

In the future, I would like to get more involved in helping with OpenIndiana infrastructure tasks, maintaining some software and possibly OpenIndiana documentation project and helping with OpenIndiana handbook, which should be a complete user guide to the OpenIndiana operating system.
