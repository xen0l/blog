---
categories:
- 35C3
- CCC
tags:
- CCC
toc: true
title: "Refreshing Memories: report from 35c3"
date: 2019-01-22T15:39:09+01:00
---

This blog post will summarize my experience attending 35th Chaos Communication Congress AKA 35c3, which took place between 27th and 30th December 2018 in Leipzig, Germany. The Congress hosts a variety of talks, assemblies and serves as a meeting point for thousands of people from the security and hackerspace communities. Moreover, the Congress covers many other different topics ranging from arts & culture, technology, hobby projects as well as politics. In this post, I will be mainly focusing on the security and technical talks of the conference.


<figure>
    <img src="/images/35c3-sign.jpg" title="35c3 sign on Congress Centre Leipzig"/>
    <center>
        <figcaption>35c3 sign on Congress Centre Leipzig</figcaption>
    </center>
</figure>

<figure>
    <img src="/images/35c3-rocket.jpg" title="C3 Rocket on 35c3"/>
    <center>
        <figcaption>C3 Rocket on 35c3</figcaption>
    </center>
</figure>

<figure>
    <img src="/images/35c3-entrance-hall.jpg" title="Congress Centre Leipzig Entrance Hall"/>
    <center>
        <figcaption>Congress Centre Leipzig Entrance Hall</figcaption>
    </center>
</figure>

<figure>
    <img src="/images/35c3-entrance-hall-lasers.jpg" title="Lasers in the Entrance Hall"/>
    <center>
        <figcaption>Lasers in the Entrance Hall</figcaption>
    </center>
</figure>

<figure>
    <img src="/images/35c3-angel-badge.jpg" title="My angel badge"/>
    <center>
        <figcaption>My Angel badge</figcaption>
    </center>
</figure>

# Mobility

Given the size of the CCL, a lot of people were using scooters, both eletrical and mechanical, as well as special tailor-made mobile vechiles.

<center>
<figure>
    <img src="/images/35c3-mobile-armchair.gif" title="Moving armchair?! What else?!"/>
    <figcaption>Moving armchair?! What else?!</figcaption>
</figure>
</center>

As some of the mobile vechiles were actually causing traffic problems, traffic warning signs were put up around the Congress. In addition, not many attendees realized that scooters were as a matter of fact not free-for-all and were owned by participants.

<figure>
    <img src="/images/35c3-traffic-sign.jpg" title="Traffic sign"/>
    <center>
        <figcaption>Traffic sign (use of mobile armchair prohibited)</figcaption>
    </center>
</figure>

Oh, and let's not forget the racing track!

<center>
<figure>
    <img src="/images/35c3-ikea-racing-track.gif" title="35c3 racing track"/>
    <figcaption>Wheely Armchair on the racing track! (only available at IKEA)</figcaption>
</figure>
</center>

# Talks

I went along to the following talks:


## Day 1

* **The Rocky Road to TLS 1.3 and better Internet Encryption** ([Video](https://media.ccc.de/v/35c3-9607-the_rocky_road_to_tls_1_3_and_better_internet_encryption) [Slides](https://cdn.media.ccc.de/congress/2018/slides-pdf/35c3-9607-the_rocky_road_to_tls_1_3_and_better_internet_encryption.pdf)) - this talk gives a detailed overview of TLS 1.3, hilighting reasons for decisions that were made in the design of  the new TLS version and how it differs from TLS 1.2 as well as talks about deployment peculiarities.

* **First Sednit UEFI Rootkit Unveiled** ([Video](https://media.ccc.de/v/35c3-9561-first_sednit_uefi_rootkit_unveiled) [Slides](https://mirrors.dotsrc.org/cdn.media.ccc.de/congress/2018/slides-pdf/35c3-9561-first_sednit_uefi_rootkit_unveiled.pdf)) - researcher presents a detailed analysis of the first UEFI rootkit spotted in the wild and talks about how it works internally.

* **SiliVaccine: North Korea's Weapon of Mass Detection** ([Video](https://media.ccc.de/v/35c3-9375-silivaccine_north_korea_s_weapon_of_mass_detection)) - overview of the antivirus software created by comrades in North Korea and how software engineering problems are handled.


* **It Always Feels Like the Five Eyes Are Watching You** ([Video](https://media.ccc.de/v/35c3-9951-it_always_feels_like_the_five_eyes_are_watching_you)) - EFF's Kurt Opsahl speaks about the espionage alliance between Australia, Canada, New Zealand, the United Kingdom and the United States, it's past and present and what are they doing in order to enable mass surveillance.

<figure>
    <img src="/images/35c3-australian-laws.jpg" title="Australian laws"  />
    <center>
        <figcaption>The laws of mathematics do not apply in Australia!</figcaption>
    </center>
</figure>

## Day 2

* **Jailbreaking iOS** ([Video](https://media.ccc.de/v/35c3-9618-jailbreaking_ios)) - talk gives a general overview how iOS jailbreaking works, describing past techniques and how newer iOS protections are making it more complicated. A few jailbreaking pieces of software were also described.

* **The year in post-quantum crypto** ([Video](https://media.ccc.de/v/35c3-9926-the_year_in_post-quantum_crypto) [Slides](https://cdn.media.ccc.de/congress/2018/slides-pdf/35c3-9926-the_year_in_post-quantum_crypto.pdf)) - traditional talk one cannot miss out on! Speakers, Daniel J. Bernstein and Tanja Lange, summarize the development during the last year in post-quantum cryptography space ranging from events that appeared in the news to PQ cipher analysis.

## Day 3

* **Enclosure-PUF** ([Video](https://media.ccc.de/v/35c3-9611-enclosure-puf)) - ever wondered how to design a tamper-proof physical case for computers? This talk will give you an insight on how to use electromagnetic waves for this exact purpose. Speakers also talk about the design and issues of such solution.

* **Sneaking In Network Security** ([Video](https://media.ccc.de/v/35c3-9603-sneaking_in_network_security)) - summary of how Airbnb tackled and deployed network segmentation into their infrastructure, what problems they ran into and how one should approach the whole problem.

* **Attacking Chrome IPC** ([Video](https://media.ccc.de/v/35c3-9579-attacking_chrome_ipc)) - this talk unveils techniques on how to become proficient in bug hunting as well as talking about how the speaker was able to apply these methods in finding vulnerabilities in Chrome IPC. Definitely a must watch for somebody who is interested in becoming a security researcher!

<figure>
    <img src="/images/35c3-becoming-a-security-pro.jpg" title="Becoming a security pro"  />
    <center>
        <figcaption>How to become a security professional?</figcaption>
    </center>
</figure>

* **Internet of Dongs** ([Video](https://media.ccc.de/v/35c3-9523-internet_of_dongs)) - one of my most favourite talks at the Congress this year! The speaker talks about how smart sex toys were researched, what kind of bugs and issues were found and how by misuse of these tools one might commit a criminal activity.

* **The foodsaving grassroots movement** ([Video](https://media.ccc.de/v/35c3-9882-the_foodsaving_grassroots_movement) [Slides](https://koeln.ftp.media.ccc.de/congress/2018/slides-pdf/35c3-9882-the_foodsaving_grassroots_movement.pdf)) - this talk introduces the foodsharing movement, whose aim is to reduce the food waste and what people can do to help. This one was quite inspiring!


## Day 4

I skipped Day 4 as my flight was scheduled early in the morning. However, here are some talks that I find of great interest and I would have visited them if I was still at the Congress on Day 4:

* [**Kernel Tracing With eBPF**](https://fahrplan.events.ccc.de/congress/2018/Fahrplan/events/9532.html) ([Video](https://media.ccc.de/v/35c3-9532-kernel_tracing_with_ebpf) [Slides](https://koeln.ftp.media.ccc.de/congress/2018/slides-pdf/35c3-9532-kernel_tracing_with_ebpf.pdf))
* [**Dissecting Broadcom Bluetooth**](https://fahrplan.events.ccc.de/congress/2018/Fahrplan/events/9498.html) ([Video](https://media.ccc.de/v/35c3-9498-dissecting_broadcom_bluetooth) [Slides](https://mirror-1.server.selfnet.de/CCC/congress/2018/slides-pdf/35c3-9498-dissecting_broadcom_bluetooth.pdf))
* [**35C3 Infrastructure Review**](https://fahrplan.events.ccc.de/congress/2018/Fahrplan/events/9576.html)([Video](https://media.ccc.de/v/35c3-9576-35c3_infrastructure_review))


# Other talks

Talks I haven't frequented, but sounded interesting:

* **Hunting the Sigfox: Wireless IoT Network Security** ([Video](https://media.ccc.de/v/35c3-9491-hunting_the_sigfox_wireless_iot_network_security))
* **wallet.fail** ([Video](https://media.ccc.de/v/35c3-9563-wallet_fail))
* **Compromising online accounts by cracking voicemail systems** ([Video](https://media.ccc.de/v/35c3-9383-compromising_online_accounts_by_cracking_voicemail_systems) [Slides](https://ftp.fau.de/cdn.media.ccc.de/congress/2018/slides-pdf/35c3-9383-compromising_online_accounts_by_cracking_voicemail_systems.pdf))
* **What The Fax?!** ([Video](https://media.ccc.de/v/35c3-9462-what_the_fax) )
* **Modchips of the State** ([Video](https://media.ccc.de/v/35c3-9597-modchips_of_the_state))
* **Inside the AMD Microcode ROM** ([Video](https://media.ccc.de/v/35c3-9614-inside_the_amd_microcode_rom)) [Slides](https://mirrors.dotsrc.org/cdn.media.ccc.de/congress/2018/slides-pdf/35c3-9614-inside_the_amd_microcode_rom.pdf))
* **SD-WAN a New Hop** ([Video](https://media.ccc.de/v/35c3-9446-sd-wan_a_new_hop) [Slides](https://berlin-ak.ftp.media.ccc.de/congress/2018/slides-pdf/35c3-9446-sd-wan_a_new_hop.pdf))
* **Exploring fraud in telephony networks** ([Video](https://media.ccc.de/v/35c3-9852-exploring_fraud_in_telephony_networks))
* **Modern Windows Userspace Exploitation** ([Video](https://media.ccc.de/v/35c3-9660-modern_windows_userspace_exploitation))
* **Smart Home - Smart Hack** ([Video](https://media.ccc.de/v/35c3-9723-smart_home_-_smart_hack))
* **Analyze the Facebook algorithm and reclaim data sovereignty** ([Video](https://media.ccc.de/v/35c3-9797-analyze_the_facebook_algorithm_and_reclaim_data_sovereignty))
* **Attacking end-to-end email encryption** ([Video](https://media.ccc.de/v/35c3-9463-attacking_end-to-end_email_encryption))
* **Wallet Security** ([Video](https://media.ccc.de/v/35c3-9492-wallet_security) [Slides](https://mirror.us.oneandone.net/projects/media.ccc.de/congress/2018/slides-pdf/35c3-9492-wallet_security.pdf))
* **A Christmas Carol - The Spectres of the Past, Present, and Future** ([Video](https://media.ccc.de/v/35c3-9893-a_christmas_carol_-_the_spectres_of_the_past_present_and_future))
* **The Layman's Guide to Zero-Day Engineering** ([Video](https://media.ccc.de/v/35c3-9979-the_layman_s_guide_to_zero-day_engineering))
* **From Zero to Zero Day** ([Video](https://media.ccc.de/v/35c3-9657-from_zero_to_zero_day))
* **Provable Security** ([Video](https://media.ccc.de/v/35c3-9517-provable_security) [Slides](https://mirror.us.oneandone.net/projects/media.ccc.de/congress/2018/slides-pdf/35c3-9517-provable_security.pdf))
* **Viva la Vita Vida** ([Video](https://media.ccc.de/v/35c3-9364-viva_la_vita_vida))
* **In Soviet Russia Smart Card Hacks You** ([Video](https://media.ccc.de/v/35c3-9346-in_soviet_russia_smart_card_hacks_you) [Slides](https://mirror-1.server.selfnet.de/CCC/congress/2018/slides-pdf/35c3-9346-in_soviet_russia_smart_card_hacks_you.pdf))
* **Memsad** ([Video](https://media.ccc.de/v/35c3-9788-memsad))
* **Web-based Cryptojacking in the Wild** ([Video](https://media.ccc.de/v/35c3-9483-web-based_cryptojacking_in_the_wild) [Slides](https://mirror-1.server.selfnet.de/CCC/congress/2018/slides-pdf/35c3-9483-web-based_cryptojacking_in_the_wild.pdf))
* **Circumventing video identification using augmented reality** ([Video](https://media.ccc.de/v/35c3-9616-circumventing_video_identification_using_augmented_reality))

Other interesting links:

* [Fahrplan (35c3 schedule)](https://fahrplan.events.ccc.de/congress/2018/Fahrplan/)
* [35C3 videos on media.ccc.de](https://media.ccc.de/c/35c3)
* [34C3 EN video playlist on YouTube](https://www.youtube.com/watch?v=OTys3VzCe7o&list=PL_IxoDz1Nq2YUlQqBSg0F2PB5jqXMoNmu)
* [35C3 FR video playlist on YouTube](https://www.youtube.com/watch?v=FXClBjrLERA&list=PL_IxoDz1Nq2YfIVb40c-gLHEdIYGBq6_e)
* [35C3 ES video playlist on YouTube](https://www.youtube.com/watch?v=XbwPFqZ9Bhc&list=PL_IxoDz1Nq2YMB-ULnutjEyYu3scmfkhd)
* [35C3 DE video playlist on YouTube](https://www.youtube.com/watch?v=MRqWaRMFsPs&list=PL_IxoDz1Nq2bN-jVVGW0Fs5vXVnMSBNFV)

To conclude, I enjoyed 35C3 very much and I am looking forward to 36C3. See you there!
