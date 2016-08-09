---
categories:
  - sysadmin
  - OpenIndiana
tags:
  - OpenIndiana
  - IPS
toc: true
date: 2016-08-09T00:09:28+02:00
title: Mirroring OpenIndiana IPS repositories - part 1
---

# Introduction

In this blog post, I will show how one can create a mirror of OpenIndiana IPS
repositories. IPS repositories hold packages coming from multiple sources, most
notably from [illumos-gate](https://github.com/illumos/illumos-gate) and
[oi-userland](https://github.com/OpenIndiana/oi-userland). Every time user runs
**pkg update** on his OpenIndiana installation, **pkg**  contacts IPS repository
to fetch catalog metadata and determines if there are any new updates available.
If updates are available, **pkg** downoalds only changed files over HTTP.
IPS application server is written in Python and [CherryPy](http://www.cherrypy.org/)
web framework. I will also describe how to configure nginx as
a reverse proxy for IPS mirror and make it more robust. The nice thing about
setting IPS mirror is that it is very easy to do as we have it deeply integrated
with other illumos technologies: SMF and ZFS.

If unsure whetever you should create your own IPS repository mirror, consider these
use cases:

* have a reasonable big OpenIndiana infrastructure and want to have a better control over updates
* save network bandwidth
* want to provide IPS repository mirror for the community

It is enough to do steps in the first part of this blog post to get IPS mirror up and running. This
configuration should also work on other illumos IPS distributions such as OmniOS with minimal changes.
In the next part, I will mainly concentrate on how to increase IPS server
performance by leveraging caching, nginx settings and deploying TLS.

# Preparation

I will be using OpenIndiana hipster 2016.04 [vagrant]{https://www.vagrantup.com/} box as my working
environemnt. It provides me with a basic setup: base install, network configuration and access to the
Internet. The user **vagrant** has **Primary Administrator** RBAC role assigned, so it can get access
to superuser privileges. Configuring these is out of scope of this document.

# Configuring IPS mirroring service

IPS mirroring service is provided by **svc:/application/pkg/mirror:default** SMF service. This service
will configure everything necesseary from creating ZFS datasets for every pkg/mirror instance to creating
crontab entry.

We start by adding publishers, which we want to mirror from. I will mirror two publishers:

* **openindiana.org** publisher from **http://pkg.openindiana.org/hipster** repository (**~77GB** as of August 2016)
* **hipster-encumbered** publisher from **http://pkg.openindiana.org/hipster-encumbered** repository (**~1GB** as of August 2016)

```bash
vagrant@openindiana:/export/home/vagrant$ pkg publisher
PUBLISHER                   TYPE     STATUS P LOCATION
openindiana.org             origin   online F http://pkg.openindiana.org/hipster/
vagrant@openindiana:/export/home/vagrant$ pfexec pkg set-publisher \
                                            -p http://pkg.openindiana.org/hipster-encumbered
pkg set-publisher:
  Added publisher(s): hipster-encumbered
vagrant@openindiana:/export/home/vagrant$ pkg publisher
PUBLISHER                   TYPE     STATUS P LOCATION
openindiana.org             origin   online F http://pkg.openindiana.org/hipster/
hipster-encumbered          origin   online F http://pkg.openindiana.org/hipster-encumbered/
```

Please note that **openindiana.org** IPS publisher is preconfigured by default. If it is not present, add it:

```bash
pfexec pkg set-publisher -p http://pkg.openindiana.org/hipster
```

We need to create **rpool/VARSHARE/pkg** ZFS dataset as **pkg/mirror** expects it. I placed it on a root pool as **pkg/mirror** expects
\<BE root pool\>/VARSHARE. We also enable **lz4 compression**
on this dataset, so  child datasets inherit the compression setting. Now, create the dataset:

```bash
vagrant@openindiana:/export/home/vagrant$ pfexec zfs create -o mountpoint=/var/share rpool/VARSHARE
vagrant@openindiana:/export/home/vagrant$ pfexec zfs create -o compression=lz4 rpool/VARSHARE/pkg
vagrant@openindiana:/export/home/vagrant$ zfs list
NAME                         USED  AVAIL  REFER  MOUNTPOINT
rpool                       4.43G  43.8G  29.5K  /rpool
rpool/ROOT                  2.36G  43.8G    19K  legacy
rpool/ROOT/openindiana      2.36G  43.8G  2.18G  /
rpool/ROOT/openindiana/var   119M  43.8G   107M  /var
rpool/VARSHARE                38K  43.8G    19K  /var/share
rpool/VARSHARE/pkg            19K  43.8G    19K  /var/share/pkg
rpool/dump                  1.00G  43.8G  1.00G  -
rpool/export                65.5K  43.8G    19K  /export
rpool/export/home           46.5K  43.8G    19K  /export/home
rpool/export/home/vagrant   27.5K  43.8G  27.5K  /export/home/vagrant
rpool/swap                  1.06G  44.7G   117M  -
```

We continue with configuring **pkg/mirror** instances for every IPS publisher:

```bash
svccfg -s pkg/mirror add hipster
svccfg -s pkg/mirror:hipster addpg config application
svccfg -s pkg/mirror:hipster setprop config/cache_dir="/var/cache/pkg/mirror"
svccfg -s pkg/mirror:hipster setprop config/crontab_period='"0 18,6 * * *"'
svccfg -s pkg/mirror:hipster setprop config/publishers="openindiana.org"
svccfg -s pkg/mirror:hipster setprop config/repository="/var/share/pkg/repositories/hipster"

svccfg -s pkg/mirror add hipster-encumbered
svccfg -s pkg/mirror:hipster-encumbered addpg config application
svccfg -s pkg/mirror:hipster-encumbered setprop config/cache_dir="/var/cache/pkg/mirror"
svccfg -s pkg/mirror:hipster-encumbered setprop config/crontab_period='"0 17,4 * * *"'
svccfg -s pkg/mirror:hipster-encumbered setprop config/publishers=astring: "hipster-encumbered"
svccfg -s pkg/mirror:hipster-encumbered setprop config/repository="/var/share/pkg/repositories/hipster-encumbered"
```

Once SMF instances are created and configured, we need to start them and also a service called
**svc:/application/pkg/repositories-setup:default**, which will create ZFS datasets:

```bash
vagrant@openindiana:/export/home/vagrant$ svcs -a | grep pkg/mirror
disabled       23:34:02 svc:/application/pkg/mirror:default
-              -        svc:/application/pkg/mirror:hipster
-              -        svc:/application/pkg/mirror:hipster-encumbered
vagrant@openindiana:/export/home/vagrant$ svcadm enable svc:/application/pkg/mirror:hipster
vagrant@openindiana:/export/home/vagrant$ svcadm enable svc:/application/pkg/mirror:hipster-encumbered
vagrant@openindiana:/export/home/vagrant$ svcadm enable svc:/application/pkg/repositories-setup:default
vagrant@openindiana:/export/home/vagrant$ svcs -xv
vagrant@openindiana:/export/home/vagrant$
```

ZFS datasets for **pkg/mirror** instances have been created and entries were added to **pkg5serv**'s crontab:

```bash
vagrant@openindiana:/export/home/vagrant$ zfs list
NAME                                                 USED  AVAIL  REFER  MOUNTPOINT
rpool                                               4.43G  43.8G  29.5K  /rpool
rpool/ROOT                                          2.36G  43.8G    19K  legacy
rpool/ROOT/openindiana                              2.36G  43.8G  2.18G  /
rpool/ROOT/openindiana/var                           119M  43.8G   107M  /var
rpool/VARSHARE                                        96K  43.8G    19K  /var/share
rpool/VARSHARE/pkg                                    77K  43.8G    19K  /var/share/pkg
rpool/VARSHARE/pkg/repositories                       58K  43.8G    19K  /var/share/pkg/repositories
rpool/VARSHARE/pkg/repositories/hipster             19.5K  43.8G  19.5K  /var/share/pkg/repositories/hipster
rpool/VARSHARE/pkg/repositories/hipster-encumbered  19.5K  43.8G  19.5K  /var/share/pkg/repositories/hipster-encumbered
rpool/dump                                          1.00G  43.8G  1.00G  -
rpool/export                                        65.5K  43.8G    19K  /export
rpool/export/home                                   46.5K  43.8G    19K  /export/home
rpool/export/home/vagrant                           27.5K  43.8G  27.5K  /export/home/vagrant
rpool/swap                                          1.06G  44.7G   117M  -
pkg5srv@openindiana:~$ /usr/bin/crontab -l
0 17,4 * * * /usr/sbin/svcadm refresh svc:/application/pkg/mirror:hipster-encumbered
0 18,6 * * * /usr/sbin/svcadm refresh svc:/application/pkg/mirror:hipster
```

The data will appear in **/var/cache/pkg/repositories/hispter** and **/var/cache/pkg/repositories/hispter-encumbered**
after cron runs initial synchronization. Please, keep in mind that initial sync may take longer depending on your network
connection speed.

# Serving the data

Once the data is mirrored, we need to serve it to users. This is accomplished by creating **pkg.depot** instance for every
mirrored repository. The **pkg.depot** comes installed with **package/pkg** package and should be present on the system.
Creating IPS repository instance is just a matter of configuring a few SMF services (replace \<DOMAIN\> with a hostname you want to use,
I will use **pkg.domain.tld** in this example):

```bash
svccfg -s svc:/application/pkg/server add hipster
svccfg -s svc:/application/pkg/server:hipster addpg pkg application
svccfg -s svc:/application/pkg/server:hipster setprop \
                            pkg/inst_root="/var/share/pkg/repositories/hipster"
svccfg -s svc:/application/pkg/server:hipster setprop \
                            pkg/port="10100"
svccfg -s svc:/application/pkg/server:hipster setprop \
                            pkg/pkg_root="/"
svccfg -s svc:/application/pkg/server:hipster setprop \
                            pkg/readonly="true"
svccfg -s svc:/application/pkg/server:hipster setprop \
                            pkg/proxy_base="http://<DOMAIN>/hipster"
svccfg -s svc:/application/pkg/server:hipster setprop \
                            pkg/address="127.0.0.1"

svccfg -s svc:/application/pkg/server add hipster-encumbered
svccfg -s svc:/application/pkg/server:hipster-encumbered addpg pkg application
svccfg -s svc:/application/pkg/server:hipster-encumbered setprop \
                            pkg/inst_root="/var/share/pkg/repositories/hipster-encumbered"
svccfg -s svc:/application/pkg/server:hipster-encumbered setprop \
                            pkg/port="10101"
svccfg -s svc:/application/pkg/server:hipster-encumbered setprop \
                            pkg/pkg_root="/"
svccfg -s svc:/application/pkg/server:hipster-encumbered setprop \
                            pkg/readonly="true"
svccfg -s svc:/application/pkg/server:hipster-encumbered setprop \
                            pkg/proxy_base="http://<DOMAIN>/hipster-encumbered"
svccfg -s svc:/application/pkg/server:hipster-encumbered setprop \
                            pkg/address="127.0.0.1"
```

After **pkg/server** instances have been configured, ensure thay are present and start them:

```bash
vagrant@openindiana:/export/home/vagrant$ svcs pkg/server
STATE          STIME    FMRI
disabled       Aug_05   svc:/application/pkg/server:default
-              -        svc:/application/pkg/server:hipster
-              -        svc:/application/pkg/server:hipster-encumbered
vagrant@openindiana:/export/home/vagrant$ pfexec svcadm enable pkg/server:hipster
vagrant@openindiana:/export/home/vagrant$ pfexec svcadm enable pkg/server:hipster-encumbered
vagrant@openindiana:/export/home/vagrant$ svcs -xv
vagrant@openindiana:/export/home/vagrant$
```

If everything went good, two **pkg.depotd** instances should be running:

```bash
vagrant@openindiana:/export/home/vagrant$ svcs -p pkg/server
STATE          STIME    FMRI
disabled       Aug_05   svc:/application/pkg/server:default
online         13:37:02 svc:/application/pkg/server:hipster
               13:37:02     2107 pkg.depotd
online         13:37:04 svc:/application/pkg/server:hipster-encumbered
               13:37:04     2131 pkg.depotd
```

# Configuring nginx as a reverse proxy

Using reverse proxy with **pkg.depot** is essential as we can increase performance and security by proper configuration. Many reverse proxy implementations also come with caching and loadbalancing features, which we
can use as well. Another important thing is to configure a webserver for serving static files. I chose [nginx](https://www.nginx.org) as it excels at serving static files, reverse proxying and caching. Install the package:

```bash
pkg install nginx
```

Once the package is installed, copy the following configuration snippet into **/etc/nginx/nginx.conf** (or other place where nginx can find it), so nginx can start handling requests arriving at our IPS mirror instances from the outside world. Do not forget to replace **pkg.domain.tld** with the actual hostname for the newly configured IPS mirror:

```bash
server {
  listen 80;
  server_name pkg.domain.tld;

  access_log /var/nginx/logs/pkg.domain.tld-access.log main;
  error_log /var/nginx/logs/pkg.domain.tld-error.log debug;

  root /var/share/pkg/repositories;

  location /hipster/ {

    location ~ ^/hipster/file/0/(..)(.*)$ {
      try_files /hipster/publisher/openindiana.org/file/$1/$1$2 =404;
    }

    location ~ ^/hipster/openindiana.org/file/1/(..)(.*)$ {
      try_files /hipster/publisher/openindiana.org/file/$1/$1$2 =404;
    }

    location ~^/hipster/(open|abandon|add|close)/ {
      allow 127.0.0.0/8;
      deny all;
    }

    rewrite ^/hipster/$ / break;
    rewrite ^/hipster/(.*) /$1 break;

    proxy_pass http://127.0.0.1:10100;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_buffering off;
  }

  location /hipster-encumbered/ {

    location ~ ^/hipster-encumbered/file/0/(..)(.*)$ {
      try_files /hipster-encumbered/publisher/hipster-encumbered/file/$1/$1$2 =404;
    }

    location ~ ^/hipster-encumbered/hipster-encumbered/file/1/(..)(.*)$ {
      try_files /hipster-encumbered/publisher/hipster-encumbered/file/$1/$1$2 =404;
    }

    location ~^/hipster-encumbered/(open|abandon|add|close)/ {
      allow 127.0.0.0/8;
      deny all;
    }

    rewrite ^/hipster-encumbered/$ / break;
    rewrite ^/hipster-encumbered/(.*) /$1 break;

    proxy_pass http://127.0.0.1:10101;
    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
    proxy_redirect off;
    proxy_buffering off;
  }

  location / {
    return 301 http://pkg.domain.tld/hipster/en/index.shtml;
  }
}
```

Before enabling nginx service, test if the configuration is correct and don't forget to check for
service issues afterwards:

```bash
vagrant@openindiana:/export/home/vagrant$ pfexec nginx -t
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
vagrant@openindiana:/export/home/vagrant$ svcadm enable nginx
vagrant@openindiana:/export/home/vagrant$ svcs -xv
vagrant@openindiana:/export/home/vagrant$
```

We are now ready to serve IPS data to the outside world. In the next chapter, we will look at how
to get maximum out of nginx capabilities.
