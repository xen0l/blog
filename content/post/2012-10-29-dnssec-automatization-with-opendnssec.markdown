---
categories:
- sysadmin
- FreeBSD
- DNS
tags:
- FreeBSD
- DNS
- security
comments: true
date: 2012-10-29T00:00:00Z
title: DNSSEC automatization with OpenDNSSEC
url: /2012/10/29/dnssec-automatization-with-opendnssec/
---

DNSSEC is an amazing piece of technology. DNSSEC data is digitally signed. The validating DNS server can check if the data it receives is identical to those on the authoritative DNS server. This helps us mitigate DNS cache poisoning.

I have signed my domain back in January 2012, signing my zone by hand. However, I forgot to resign my zone and the zone signature expired making it unresolvable. This made me wonder how could I automatize the whole process. I read about [OpenDNSSEC](https://www.opendnssec.org). OpenDNSSEC is a wonderful piece of software, which automates the DNSSEC zone managements. OpenDNSSEC is used by several NICs around the world to manage their TLD zones. I didn't try OpenDNSSEC at first as I found it to be too complex and not suitable for a single zone. I tried BIND 9.9 DNSSEC inline-signing, instead. It worked, but I was unhappy with it. Inline signing in BIND converts manually maintained zone into a dynamic one and signs it. All DNSSEC changes are made to the journal file format, which I dislike working with. As I wasn't satisfied with this solution, I gave OpenDNSSEC a try.

I deployed OpenDNSSEC on my personal FreeBSD server. The configuration didn't take more than 15 minutes thanks to the excellent official [documentation](https://wiki.opendnssec.org/display/DOCS/OpenDNSSEC+Documentation+Home). Once, I started the OpenDNSSEC service, it generated both KSK and ZSK for my zone. I published [DS record](https://tools.ietf.org/rfc/rfc3658.txt) via my registrar's web management portal. I am using RSASHA256 cipher for both KSK and ZSK. I wanted to use ECDSA, but my registrar doesn't support it yet. I hope this will change in the near future. Any DNSSEC-related operations are now made automatically without any manual intervertion. Whenever I add new DNS records into my zone, I just call ods-signer to resign my zone. The zone resigning will be scheduled and the new records will be published alongside with their signatures. I love automatic things!

My zone also contains [SSHFP](https://tools.ietf.org/html/rfc4255) records with my SSH server fingerprints and I am now able to finally make use of OpenSSH client's VerifyHostKeyDNS feature. I tried out [IPSECKEY](https://tools.ietf.org/html/rfc4025) record. It worked with racoon. More on how to configure racoon to get IPSec peer's certificate from the DNS can be found in racoon.conf(5). Lastly, I am very interested in [DANE](https://tools.ietf.org/html/rfc6698) and TLSA resource record. I think that this will be the biggest feature of DNSSEC in the upcoming years because DANE makes commercial CAs obsolete. Why should I pay for certificates, when I can generate one and just publish it in the DNS? This is very nice feature, but it's dependent on a wider DNSSEC adoption, which isn't happening massively. I hope this will change pretty soon.

I wrote simple howto about running OpenDNSSEC with BIND on FreeBSD. I published it on my [wiki](http://wiki.xenol.eu/doku.php?id=freebsd_bind_opendnssec) and I hope it will help somebody. Feedback is welcome. I am also planning to package both SoftHSM and OpenDNSSEC for [OpenIndiana](http://www.openindiana.org), once I am done with other tasks I am working on. However, I do not expect this to happen during this month. More realistic date is December.
