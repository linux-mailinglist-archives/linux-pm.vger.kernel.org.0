Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85BEB359CB
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 11:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfFEJqg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 05:46:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:36699 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbfFEJqf (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 05:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559727969;
        bh=V19qkMcNM+z06H3tHIRTDJO/aM1Nl8PEfSKRTP7GqaM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=imjHOtTtpjl0n/5wx3ijKfqgnIuIgVEFqJroTH4e2Crmu/oEfmcJjTkk/v//sGCXj
         c9GK6VbM743yCIDrA/fZc5kQtPp1C3gN1yHKtE2nnDP9PvkZdiqc7GXWAwRWg78qVL
         2nEhaA9K9E5NtoXeFxe3HmJBRraLTCqFbHmr7DVQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MYx2x-1h2x6p3OoF-00VhrB; Wed, 05
 Jun 2019 11:46:08 +0200
Subject: Re: [PATCH 0/4] cpufreq support for the Raspberry Pi
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     f.fainelli@gmail.com, ptesarik@suse.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <2ece3f20-ef8c-c39e-941c-76635ddbe185@gmx.net>
Date:   Wed, 5 Jun 2019 11:46:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604173223.4229-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:H++l6H+L51qajNvnkshjARw2D+PmdDWwwT3lb2+cYxNB18LWA1q
 X5X7qhkvi2LH6Mb5BhejoBWHDPQFV5E+mwuSLV+BZY+nxTxsK+xtYLTGNUDbZjwNMfSTSv6
 OsTulSqXeasloINJExfV+1HkKuXStcftu9in57jM3CieaMtJ7XYYejsjlJeL4uCKF9DhLcj
 ClY+6Gzu8j1tzFFC2MD0w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AxL4D/To2jQ=:Pd16HiejKGGTI3e8uuSoQT
 dZOqYF3cGFtBY7O83W8Q9pMDbycJOC//mAJnx0sxnEj56Ir2O8N2Cj2cOSz20tB5XzDGz01aI
 PcyD8srPgKWEkTBlLTl5Mrg2Hr6vknUvwdQz+Om/8nBq+F8vtLVpmI2WlkljH13D0E/Riki75
 cjY6EHgmfQMoE5hYFkM0qQOgM5L+YqpFyAczjju2mET7FkPZ9cLIEWqXYOr70QX2JdJT5nCTQ
 fDeET9KJkPj58me7+61tquShjrqwr8/ZHzpR6Yg/rQJaQgUosYJ3kgrmaTG07RtPq0W58sT8u
 4Es5G7OaZyqozS2R1LHhxf5xGp3JIJ/M6KrGTAIrjI8fj9usQc2GmdgjFcOfBO2FClP66KTmr
 8Q+tfOwgrIfya2UjmnNrePU1CIqGkKMYkMTaNd1oyY9kZUViNhuRssnvdK81ztnNw3ZGrwHeh
 hec+HCm/iLy7ktoaTVMToRC56iIV6IcFbQsiqnM9sxKlx5ce44SDF7HGXcC7AI7E4QGjkH0ST
 CRv44GJVN44qC9Y0hzoUT/y+H1tg9kOtgByocpx97c1Q/WzhFHzqq1113VW65vmuV8VdwGgzx
 3g0EQDj5pl0rvWMVT2P35t0t3Ngp77qBE6M4nzceAKTypWeq9WyfbyOHf3otV8iO1jJi/X2Ws
 u8ehV0rD3FJkuE4JWqs0RuRql7GGtQeQ0z6Rg1hK6KjYqinBxj5u4BxW9zoAYjKGkjWFJYQqn
 oOwNIjUuN1G2uW+FROPKRkGeRqchpFRCaB8zbfrE2m7rwm5DPyq8OZSvSKLPrtO692D8GkH3W
 RUzL7kCi6zrSjf+P9jy9O1L7hxplkgsjujg1NAxVCId7XEIFxxxWnC0BrH4w181kXQVHfocfZ
 OAmLlKxIh665Lq//zhW8MUMBvm53XQC/oQaQ62agQ1qOfkxPKoGY3GgufJBNOTi5HpZFAZrVv
 sGyEYM45iRkzpyso4U7PhRwN9YF/2atXGPQj15PP9zwpcjgFIn4kihrz5Mt8TGlVu6mHKWQyH
 Pg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Nicolas,

Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
> Hi all,
> this series aims at adding cpufreq support to the Raspberry Pi family of
> boards.
>
> The previous revision can be found at: https://lkml.org/lkml/2019/5/20/4=
31
>
> The series first factors out 'pllb' from clk-bcm2385 and creates a new
> clk driver that operates it over RPi's firmware interface[1]. We are
> forced to do so as the firmware 'owns' the pll and we're not allowed to
> change through the register interface directly as we might race with the
> over-temperature and under-voltage protections provided by the firmware.
it would be nice to preserve such design decision in the driver as a
comment, because the cover letter usually get lost.
>
> Next it creates a minimal cpufreq driver that populates the CPU's opp
> table, and registers cpufreq-dt. Which is needed as the firmware
> controls the max and min frequencies available.

I tested your series on top of Linux 5.2-rc1 with multi_v7_defconfig and
manually enable this drivers. During boot with Raspbian rootfs i'm
getting the following:

[=C2=A0=C2=A0=C2=A0 1.177009] cpu cpu0: failed to get clock: -2
[=C2=A0=C2=A0=C2=A0 1.183643] cpufreq-dt: probe of cpufreq-dt failed with =
error -2
[=C2=A0=C2=A0=C2=A0 1.192117] sdhci: Secure Digital Host Controller Interf=
ace driver
[=C2=A0=C2=A0=C2=A0 1.198725] sdhci: Copyright(c) Pierre Ossman
[=C2=A0=C2=A0=C2=A0 1.207005] Synopsys Designware Multimedia Card Interfac=
e Driver
[=C2=A0=C2=A0=C2=A0 1.319936] sdhost-bcm2835 3f202000.mmc: loaded - DMA en=
abled (>1)
[=C2=A0=C2=A0=C2=A0 1.326641] sdhci-pltfm: SDHCI platform and OF driver he=
lper
[=C2=A0=C2=A0=C2=A0 1.336568] ledtrig-cpu: registered to indicate activity=
 on CPUs
[=C2=A0=C2=A0=C2=A0 1.343713] usbcore: registered new interface driver usb=
hid
[=C2=A0=C2=A0=C2=A0 1.350275] usbhid: USB HID core driver
[=C2=A0=C2=A0=C2=A0 1.357639] bcm2835-mbox 3f00b880.mailbox: mailbox enabl=
ed
[=C2=A0=C2=A0=C2=A0 1.367490] NET: Registered protocol family 10
[=C2=A0=C2=A0=C2=A0 1.375013] Segment Routing with IPv6
[=C2=A0=C2=A0=C2=A0 1.381696] sit: IPv6, IPv4 and MPLS over IPv4 tunneling=
 driver
[=C2=A0=C2=A0=C2=A0 1.388980] NET: Registered protocol family 17
[=C2=A0=C2=A0=C2=A0 1.395624] can: controller area network core (rev 20170=
425 abi 9)
[=C2=A0=C2=A0=C2=A0 1.402358] NET: Registered protocol family 29
[=C2=A0=C2=A0=C2=A0 1.408997] can: raw protocol (rev 20170425)
[=C2=A0=C2=A0=C2=A0 1.415599] can: broadcast manager protocol (rev 2017042=
5 t)
[=C2=A0=C2=A0=C2=A0 1.422219] can: netlink gateway (rev 20170425) max_hops=
=3D1
[=C2=A0=C2=A0=C2=A0 1.429369] Key type dns_resolver registered
[=C2=A0=C2=A0=C2=A0 1.437190] Registering SWP/SWPB emulation handler
[=C2=A0=C2=A0=C2=A0 1.444443] Loading compiled-in X.509 certificates
[=C2=A0=C2=A0=C2=A0 1.455693] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 =
(irq =3D 81,
base_baud =3D 0) is a PL011 rev2
[=C2=A0=C2=A0=C2=A0 1.462768] serial serial0: tty port ttyAMA0 registered
[=C2=A0=C2=A0=C2=A0 1.478755] mmc0: host does not support reading read-onl=
y switch,
assuming write-enable
[=C2=A0=C2=A0=C2=A0 1.488792] mmc0: new high speed SDHC card at address 00=
07
[=C2=A0=C2=A0=C2=A0 1.495766] raspberrypi-firmware soc:firmware: Attached =
to firmware
from 2019-03-27 15:45
[=C2=A0=C2=A0=C2=A0 1.496862] mmcblk0: mmc0:0007 SDCIT 14.6 GiB
[=C2=A0=C2=A0=C2=A0 1.512768] raspberrypi-clk raspberrypi-clk: CPU frequen=
cy range: min
600000000, max 1400000000
[=C2=A0=C2=A0=C2=A0 1.513012]=C2=A0 mmcblk0: p1 p2
[=C2=A0=C2=A0=C2=A0 1.558085] dwc2 3f980000.usb: 3f980000.usb supply vusb_=
d not found,
using dummy regulator
[=C2=A0=C2=A0=C2=A0 1.565355] dwc2 3f980000.usb: 3f980000.usb supply vusb_=
a not found,
using dummy regulator
[=C2=A0=C2=A0=C2=A0 1.623246] dwc2 3f980000.usb: DWC OTG Controller
[=C2=A0=C2=A0=C2=A0 1.630318] dwc2 3f980000.usb: new USB bus registered, a=
ssigned bus
number 1
[=C2=A0=C2=A0=C2=A0 1.637439] dwc2 3f980000.usb: irq 33, io mem 0x3f980000
[=C2=A0=C2=A0=C2=A0 1.645268] hub 1-0:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 1.652317] hub 1-0:1.0: 1 port detected
[=C2=A0=C2=A0=C2=A0 1.665867] sdhci-iproc 3f300000.sdhci: allocated mmc-pw=
rseq
[=C2=A0=C2=A0=C2=A0 1.704788] mmc1: SDHCI controller on 3f300000.sdhci [3f=
300000.sdhci]
using PIO
[=C2=A0=C2=A0=C2=A0 1.717694] hctosys: unable to open rtc device (rtc0)
[=C2=A0=C2=A0=C2=A0 1.724967] sysfs: cannot create duplicate filename
'/devices/platform/cpufreq-dt'
[=C2=A0=C2=A0=C2=A0 1.732120] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
5.2.0-rc1-00004-g5aa6d98-dirty #2
[=C2=A0=C2=A0=C2=A0 1.739288] Hardware name: BCM2835
[=C2=A0=C2=A0=C2=A0 1.746421] [<c0312304>] (unwind_backtrace) from [<c030c=
c08>]
(show_stack+0x10/0x14)
[=C2=A0=C2=A0=C2=A0 1.753636] [<c030cc08>] (show_stack) from [<c0e7d358>]
(dump_stack+0xb4/0xc8)
[=C2=A0=C2=A0=C2=A0 1.760840] [<c0e7d358>] (dump_stack) from [<c0503b64>]
(sysfs_warn_dup+0x58/0x64)
[=C2=A0=C2=A0=C2=A0 1.768105] [<c0503b64>] (sysfs_warn_dup) from [<c0503c8=
c>]
(sysfs_create_dir_ns+0xd8/0xe8)
[=C2=A0=C2=A0=C2=A0 1.775481] [<c0503c8c>] (sysfs_create_dir_ns) from [<c0=
e82520>]
(kobject_add_internal+0xb0/0x2fc)
[=C2=A0=C2=A0=C2=A0 1.782958] [<c0e82520>] (kobject_add_internal) from [<c=
0e827c8>]
(kobject_add+0x5c/0xc0)
[=C2=A0=C2=A0=C2=A0 1.790534] [<c0e827c8>] (kobject_add) from [<c096b1cc>]
(device_add+0xf8/0x608)
[=C2=A0=C2=A0=C2=A0 1.798180] [<c096b1cc>] (device_add) from [<c0971098>]
(platform_device_add+0x110/0x214)
[=C2=A0=C2=A0=C2=A0 1.805945] [<c0971098>] (platform_device_add) from [<c0=
971ae4>]
(platform_device_register_full+0x130/0x148)
[=C2=A0=C2=A0=C2=A0 1.813866] [<c0971ae4>] (platform_device_register_full)=
 from
[<c15a7a30>] (raspberrypi_cpufreq_driver_init+0x128/0x178)
[=C2=A0=C2=A0=C2=A0 1.821916] [<c15a7a30>] (raspberrypi_cpufreq_driver_ini=
t) from
[<c0302eec>] (do_one_initcall+0x54/0x21c)
[=C2=A0=C2=A0=C2=A0 1.830099] [<c0302eec>] (do_one_initcall) from [<c15010=
f8>]
(kernel_init_freeable+0x244/0x2e0)
[=C2=A0=C2=A0=C2=A0 1.838312] [<c15010f8>] (kernel_init_freeable) from [<c=
0e949d4>]
(kernel_init+0x8/0x10c)
[=C2=A0=C2=A0=C2=A0 1.846541] [<c0e949d4>] (kernel_init) from [<c03010e8>]
(ret_from_fork+0x14/0x2c)
[=C2=A0=C2=A0=C2=A0 1.854783] Exception stack(0xea89dfb0 to 0xea89dff8)
[=C2=A0=C2=A0=C2=A0 1.863036] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 1.871450] dfc0: 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 1.879860] dfe0: 00000000 00000000 00000000 00000000 00=
000013 00000000
[=C2=A0=C2=A0=C2=A0 1.888251] kobject_add_internal failed for cpufreq-dt w=
ith -EEXIST,
don't try to register things with the same name in the same directory.
[=C2=A0=C2=A0=C2=A0 1.896910] cpu cpu0: Failed to create platform device, =
-17

>
> This was tested on a RPi3b+ and RPI2b which are the boards I have access
> to. Until this is tested broadly the cpufreq driver takes care of
> filtering out the rest of boards.
Unfortunately this makes it harder to test on other boards. So i welcome
your decision to remove it.
>
> That's all,
> kind regards,
> Nicolas
>
> [1] https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interf=
ace
>
> ---
>
> Changes since RFC:
>   - Addressed Viresh's comments in cpufreq driver
>   - Addressed Stefan's comments in both cpufreq & clk drivers
Just a note for the future, this make it hard for other reviewers to
follow. I don't really consist of the credits, it is more important to
mention what has changed. But it's not necessary to mention every single
change.
