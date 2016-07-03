---
categories:
- sysadmin
- FreeBSD
tags:
- FreeBSD
- jail
- ZFS
comments: true
date: 2012-02-04T00:00:00Z
title: Easy FreeBSD jail management with ZFS and pkgng
url: /2012/02/04/easy-freebsd-jail-management-with-zfs-and-pkgng/
---

I have been using FreeBSD jails ever since I started using FreeBSD on my servers. Jail can be described as a chroot on steroids with own users, process namespace and lately own virtualized network stack.

I am using FreeBSD jails for mainly for securing and separating services. Each service runs in its own separated container on its own ZFS dataset. Each dataset is a ZFS clone from the snapshot of the template jail, which is adapted to have software I need in every jail installed (zsh, git, vim...) and configured. Running FreeBSD jails on separate ZFS datasets is very flexible because we can setup different per-jail mount options, use compression and snapshot each jail separately. Software updates are fine for small amount of jails, while updating software in hundreds of jails can be a scaring experience. This is past with [pkgng](https://github.com/pkgng/pkgng). pkgng is a new project, which brings new binary package manager. It is very easy to build packages from ports, create and serving package repository and updating.

With this setup, I can deploy new jail under 2 minutes as all I have to do is a ZFS snapshot cloning and adding jail configuration into host /etc/rc.conf and thanks to ZFS cloning capabilties we are saving some disk space, too. I wrote a simple [howto](http://wiki.xenol.eu/doku.php?id=zfs_pkgng_jail) on my personal wiki. I have also setup package repository for my needs at [pkg.xenol.eu](http://pkg.xenol.eu). Feel free to use it.
