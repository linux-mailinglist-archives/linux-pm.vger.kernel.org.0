Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56EC235B58
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfFELeo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 07:34:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:38223 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727172AbfFELeo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 07:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559734464;
        bh=YtrPRJJdOt7g8qGileKAovxfdwNdk1ce8xpr0l/hw/E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=j/OVMxNJouP6jWCPyKqboH7eYIoelO/fWBzDpodon3VTFsdFPXnseVHLh9nE2OWtI
         e4FWH8CjnoVNh+BJFuDniW8n2XKwrC/b4sxdws/YF10Rx/Q/37X8NVkuPzhxO+bmtl
         argOQ0/F9HvdWsrBUy4leUffYA75c1wyuELWrZlY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.162] ([37.4.249.160]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPGW7-1hDOYU3O0L-00Pi1I; Wed, 05
 Jun 2019 13:34:23 +0200
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
 <2ece3f20-ef8c-c39e-941c-76635ddbe185@gmx.net>
 <1a86637dad1d2f33450950143a82016beb91bdb6.camel@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <1c9708c9-a3c9-8a8f-4693-8f29d3e60634@gmx.net>
Date:   Wed, 5 Jun 2019 13:34:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1a86637dad1d2f33450950143a82016beb91bdb6.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:FakAsdkO1HDzHNbeqrNpOS9RRmEFnr44OX4rGnBrJxegfSKCsf/
 V2yYhddYsshZ0Vwe54SDWFEjeEKj4xNjXx5GatAUxSRxu4pB1SCgeY2oe3UHjCr2bwP4XOO
 LI8Jp4oNLdNXUogw71S+a5nP+LDMUCXEU7g4rRFYvObwcYrl2C0cbUJTwClkuAAMM5tG66g
 dC9rni2kCiI7b/zvxhojA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EOwQkfOtI8E=:WR0jS6GFq4xSnAebZ7lKNP
 C/YlNhy3nO1i+gVxc6HrUJoqP0s7H1Nl+41AhlTeEGJ53D6qjUA8H4Ogb4rqahhjeE/GI1fUJ
 C4dCw9+lVFaaqxR/Lkc+CQv2bDCKrqtLxm8bQi9ZMNiF+6edzC2VABYreSj6GwoY0q994a5GL
 lUdaIhn3uvhAgnaCvV/o/Qr/KgA0LgV6ctvIjRT4WKOXriWSrYH3wq+VXAgIZGP0QQnAcq7+y
 VbsT8e3oOAnRUA1FHQ2M/05z86tsLVtS0stRBqc3kNk9M2xtR+S14Yn/QUCdFYlPrBwscYcUk
 ezppzT/0fAG42eKemmyAx0dPPQY6hS2HhxXtRDOFZ0xY4D3fMaiKWKemj1M/umNN37z7mu4ee
 bMMGHr6NQzMUN1d1UY4K3dZuBT5Yii7lg9nZf4JIw52UiY5wC30mYkFGd0ib+qhltyeWrtog6
 /pqDRy+y7Tp936sz8em7h3ZfeRu37tyUwjGojZNjk/yZ4sdOGEf5NCc9eu7RpmgsqLF9kfY1l
 dSQuu5n6HPF/GrxJWX7wAAGwMDJoAf4U40ZuC11iGF1zG5pgqgBhIV7r477n5Yl8gZ3EeFgtp
 wNr6KZ1otAvdFqCaVg+wdGxkvqgMrUEmV1bFhja7ZJXyl1nFWUCtuJR0jtEwrTNCFgkSmKUE8
 JbBlfFtmSJuTiYRGOFzJGiSO14w7sqxyLtuQCrkwO5Dy9FJl6aPj6GXlfwvXG9IlpYSI1Smm+
 sDPTQky4pVqJyY7DtpDgyIRq/pwVwlfgyx0/tbr8tyvc3JCx3grJjSNLHiviCV9KgUBq1cchm
 q0pb8we7p1Sq5SyWl7SeyKFGFowQW2E6U+2ajeM4Jky63YXdcNpitColZg6uSwhTLih7hvVS7
 SRfX59g6HXMr5TG0VE9zvN6Qaztum0ojdP8oP0z1KJIcdrut2CbvUKMDQq1AYmrUuNWLDA+Cu
 CzKdHRt5biAHN56XgMp7T89urwwzPX6UJ6BFFZKHb6gUckE521hTM
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

Am 05.06.19 um 13:00 schrieb Nicolas Saenz Julienne:
> Hi Stefan,
> thanks for the review, I took note of your code comments.
>
> On Wed, 2019-06-05 at 11:46 +0200, Stefan Wahren wrote:
>> Hi Nicolas,
>>
>> Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
>>> Hi all,
>>> this series aims at adding cpufreq support to the Raspberry Pi family =
of
>>> boards.
>>>
>>> The previous revision can be found at: https://lkml.org/lkml/2019/5/20=
/431
>>>
>>> The series first factors out 'pllb' from clk-bcm2385 and creates a new
>>> clk driver that operates it over RPi's firmware interface[1]. We are
>>> forced to do so as the firmware 'owns' the pll and we're not allowed t=
o
>>> change through the register interface directly as we might race with t=
he
>>> over-temperature and under-voltage protections provided by the firmwar=
e.
>> it would be nice to preserve such design decision in the driver as a
>> comment, because the cover letter usually get lost.
>>> Next it creates a minimal cpufreq driver that populates the CPU's opp
>>> table, and registers cpufreq-dt. Which is needed as the firmware
>>> controls the max and min frequencies available.
>> I tested your series on top of Linux 5.2-rc1 with multi_v7_defconfig an=
d
>> manually enable this drivers. During boot with Raspbian rootfs i'm
>> getting the following:
>>
>> [    1.177009] cpu cpu0: failed to get clock: -2
>> [    1.183643] cpufreq-dt: probe of cpufreq-dt failed with error -2
> This is surprising, who could be creating a platform_device for cpufreq-=
dt
> apart from raspberrypi-cpufreq? Just to make things clear, you're using =
the
> device tree from v5.2-rc1 (as opposed to the Raspbian one)?

sorry my fault, i thought it already has been replaced. The behavior in
this unexpected case is fine, since it doesn't crash.

I replaced the the DTB with the mainline one, but now i'm getting this:

[=C2=A0=C2=A0=C2=A0 4.566068] cpufreq: cpufreq_online: CPU0: Running at un=
listed freq:
600000 KHz
[=C2=A0=C2=A0=C2=A0 4.580690] cpu cpu0: dev_pm_opp_set_rate: Invalid targe=
t frequency 0
[=C2=A0=C2=A0=C2=A0 4.594391] cpufreq: __target_index: Failed to change cp=
u frequency: -22
[=C2=A0=C2=A0=C2=A0 4.608413] ------------[ cut here ]------------
[=C2=A0=C2=A0=C2=A0 4.620203] kernel BUG at drivers/cpufreq/cpufreq.c:1348=
!
[=C2=A0=C2=A0=C2=A0 4.632787] Internal error: Oops - BUG: 0 [#1] SMP ARM
[=C2=A0=C2=A0=C2=A0 4.645062] Modules linked in:
[=C2=A0=C2=A0=C2=A0 4.655147] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0
5.2.0-rc1-00004-g5aa6d98-dirty #2
[=C2=A0=C2=A0=C2=A0 4.671891] Hardware name: BCM2835
[=C2=A0=C2=A0=C2=A0 4.682549] PC is at cpufreq_online+0x690/0x6b0
[=C2=A0=C2=A0=C2=A0 4.694409] LR is at __wake_up_common_lock+0xa0/0xc8
[=C2=A0=C2=A0=C2=A0 4.706744] pc : [<c0c696c0>]=C2=A0=C2=A0=C2=A0 lr : [<c=
03860d4>]=C2=A0=C2=A0=C2=A0 psr: a0000013
[=C2=A0=C2=A0=C2=A0 4.720518] sp : ea89dce8=C2=A0 ip : eaa1ace0=C2=A0 fp :=
 c1704d54
[=C2=A0=C2=A0=C2=A0 4.733288] r10: eaa1acb4=C2=A0 r9 : c1673440=C2=A0 r8 :=
 c1705038
[=C2=A0=C2=A0=C2=A0 4.746085] r7 : c18e6728=C2=A0 r6 : 000927c0=C2=A0 r5 :=
 00000000=C2=A0 r4 : eaa1ac00
[=C2=A0=C2=A0=C2=A0 4.760288] r3 : d89db0bd=C2=A0 r2 : d89db0bd=C2=A0 r1 :=
 60000013=C2=A0 r0 : ffffffea
[=C2=A0=C2=A0=C2=A0 4.774541] Flags: NzCv=C2=A0 IRQs on=C2=A0 FIQs on=C2=
=A0 Mode SVC_32=C2=A0 ISA ARM=C2=A0
Segment none
[=C2=A0=C2=A0=C2=A0 4.789431] Control: 10c5383d=C2=A0 Table: 0020406a=C2=
=A0 DAC: 00000051
[=C2=A0=C2=A0=C2=A0 4.802897] Process swapper/0 (pid: 1, stack limit =3D 0=
x(ptrval))
[=C2=A0=C2=A0=C2=A0 4.816661] Stack: (0xea89dce8 to 0xea89e000)
[=C2=A0=C2=A0=C2=A0 4.828744] dce0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0000=
0000 d89db0bd eaa1ac04
00000001 ea89dd28 00000000
[=C2=A0=C2=A0=C2=A0 4.844876] dd00: c184539c c1704c48 00000000 c186de1c 00=
00000f
00000000 c15dc83c c0c6975c
[=C2=A0=C2=A0=C2=A0 4.861033] dd20: c186d9e4 c096dbbc ea891358 ea9a5db4 00=
000000
d89db0bd c186de68 c18e6728
[=C2=A0=C2=A0=C2=A0 4.877227] dd40: c186d99c c0c66ffc eaff1800 c0c6bda0 00=
000000
eb80c050 eaff1800 c0c6c148
[=C2=A0=C2=A0=C2=A0 4.893461] dd60: eaff1810 00000000 c186de1c c097126c c1=
8e16a4
eaff1810 c18e16a8 c096f314
[=C2=A0=C2=A0=C2=A0 4.909769] dd80: eaff1810 c186de1c c096f800 c1704c48 00=
000001
00000000 c1667b7c c096f64c
[=C2=A0=C2=A0=C2=A0 4.926077] dda0: c186de1c ea89ddfc eaff1810 00000000 ea=
89ddfc
c096f800 c1704c48 00000001
[=C2=A0=C2=A0=C2=A0 4.942410] ddc0: 00000000 c1667b7c c15dc83c c096d864 00=
000000
ea89126c eaf85138 d89db0bd
[=C2=A0=C2=A0=C2=A0 4.958798] dde0: eaff1810 eaff1810 c1704c48 eaff1854 c1=
704c48
c096f1b0 c1667b7c eaff1810
[=C2=A0=C2=A0=C2=A0 4.975236] de00: 00000001 d89db0bd eaff1810 eaff1810 c1=
845308
c1704c48 00000000 c096e574
[=C2=A0=C2=A0=C2=A0 4.991705] de20: eaff1810 c1845138 00000000 c096b490 00=
000000
c0e822d8 c1704c48 ea89dea0
[=C2=A0=C2=A0=C2=A0 5.008233] de40: eaff1800 d89db0bd ea89de60 eaff1800 00=
000000
eaff1800 eb80c050 00000000
[=C2=A0=C2=A0=C2=A0 5.024770] de60: eaff1810 c0971098 eaff1800 ea89dea0 c1=
704c48
eb80c050 00000000 05f5e100
[=C2=A0=C2=A0=C2=A0 5.041302] de80: c1667b7c c0971ae4 00000000 23c34600 c1=
704c48
eb80c050 00000000 c15a7a30
[=C2=A0=C2=A0=C2=A0 5.057796] dea0: 00000000 00000000 00000000 c1361770 ff=
ffffff
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 5.074269] dec0: 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000 d89db0bd
[=C2=A0=C2=A0=C2=A0 5.090693] dee0: 00000167 c1704c48 c188d420 ffffe000 00=
000000
c15a7908 00000167 c0302eec
[=C2=A0=C2=A0=C2=A0 5.107119] df00: 00000167 c0365a5c c13ff448 c130e700 00=
000000
00000007 00000007 c124057c
[=C2=A0=C2=A0=C2=A0 5.123539] df20: 00000000 c1704c48 c1251c04 c12405f0 00=
000000
ebfffc7d 00000000 d89db0bd
[=C2=A0=C2=A0=C2=A0 5.139941] df40: 00000000 c188d420 00000008 d89db0bd c1=
88d420
00000008 c1899800 c1899800
[=C2=A0=C2=A0=C2=A0 5.156355] df60: c15dc838 c15010f8 00000007 00000007 00=
000000
c150067c c0e949cc 00000000
[=C2=A0=C2=A0=C2=A0 5.172779] df80: 00000000 00000000 c0e949cc 00000000 00=
000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 5.189192] dfa0: 00000000 c0e949d4 00000000 c03010e8 00=
000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 5.205577] dfc0: 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 5.221915] dfe0: 00000000 00000000 00000000 00000000 00=
000013
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 5.238205] [<c0c696c0>] (cpufreq_online) from [<c0c6975=
c>]
(cpufreq_add_dev+0x6c/0x78)
[=C2=A0=C2=A0=C2=A0 5.254372] [<c0c6975c>] (cpufreq_add_dev) from [<c096db=
bc>]
(subsys_interface_register+0xa0/0xec)
[=C2=A0=C2=A0=C2=A0 5.271557] [<c096dbbc>] (subsys_interface_register) fro=
m
[<c0c66ffc>] (cpufreq_register_driver+0x14c/0x20c)
[=C2=A0=C2=A0=C2=A0 5.289700] [<c0c66ffc>] (cpufreq_register_driver) from =
[<c0c6c148>]
(dt_cpufreq_probe+0x94/0x114)
[=C2=A0=C2=A0=C2=A0 5.307002] [<c0c6c148>] (dt_cpufreq_probe) from [<c0971=
26c>]
(platform_drv_probe+0x48/0x98)
[=C2=A0=C2=A0=C2=A0 5.323802] [<c097126c>] (platform_drv_probe) from [<c09=
6f314>]
(really_probe+0xf0/0x2c8)
[=C2=A0=C2=A0=C2=A0 5.340390] [<c096f314>] (really_probe) from [<c096f64c>=
]
(driver_probe_device+0x60/0x164)
[=C2=A0=C2=A0=C2=A0 5.357113] [<c096f64c>] (driver_probe_device) from [<c0=
96d864>]
(bus_for_each_drv+0x58/0xb8)
[=C2=A0=C2=A0=C2=A0 5.374142] [<c096d864>] (bus_for_each_drv) from [<c096f=
1b0>]
(__device_attach+0xd0/0x13c)
[=C2=A0=C2=A0=C2=A0 5.390937] [<c096f1b0>] (__device_attach) from [<c096e5=
74>]
(bus_probe_device+0x84/0x8c)
[=C2=A0=C2=A0=C2=A0 5.407684] [<c096e574>] (bus_probe_device) from [<c096b=
490>]
(device_add+0x3bc/0x608)
[=C2=A0=C2=A0=C2=A0 5.424208] [<c096b490>] (device_add) from [<c0971098>]
(platform_device_add+0x110/0x214)
[=C2=A0=C2=A0=C2=A0 5.440983] [<c0971098>] (platform_device_add) from [<c0=
971ae4>]
(platform_device_register_full+0x130/0x148)
[=C2=A0=C2=A0=C2=A0 5.459471] [<c0971ae4>] (platform_device_register_full)=
 from
[<c15a7a30>] (raspberrypi_cpufreq_driver_init+0x128/0x178)
[=C2=A0=C2=A0=C2=A0 5.479053] [<c15a7a30>] (raspberrypi_cpufreq_driver_ini=
t) from
[<c0302eec>] (do_one_initcall+0x54/0x21c)
[=C2=A0=C2=A0=C2=A0 5.497336] [<c0302eec>] (do_one_initcall) from [<c15010=
f8>]
(kernel_init_freeable+0x244/0x2e0)
[=C2=A0=C2=A0=C2=A0 5.514735] [<c15010f8>] (kernel_init_freeable) from [<c=
0e949d4>]
(kernel_init+0x8/0x10c)
[=C2=A0=C2=A0=C2=A0 5.531590] [<c0e949d4>] (kernel_init) from [<c03010e8>]
(ret_from_fork+0x14/0x2c)
[=C2=A0=C2=A0=C2=A0 5.547768] Exception stack(0xea89dfb0 to 0xea89dff8)
[=C2=A0=C2=A0=C2=A0 5.561323] dfa0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 5.578116] dfc0: 00000000 00000000 00000000 00000000 00=
000000
00000000 00000000 00000000
[=C2=A0=C2=A0=C2=A0 5.594962] dfe0: 00000000 00000000 00000000 00000000 00=
000013 00000000
[=C2=A0=C2=A0=C2=A0 5.610133] Code: e59f1024 e34c0136 ebdcbce4 eaffff63 (e=
7f001f2)
[=C2=A0=C2=A0=C2=A0 5.624789] ---[ end trace 7aaf0f77e232247e ]---
[=C2=A0=C2=A0=C2=A0 5.637981] Kernel panic - not syncing: Attempted to kil=
l init!
exitcode=3D0x0000000b
[=C2=A0=C2=A0=C2=A0 5.654308] CPU3: stopping
[=C2=A0=C2=A0=C2=A0 5.665609] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 D W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
5.2.0-rc1-00004-g5aa6d98-dirty #2
[=C2=A0=C2=A0=C2=A0 5.683854] Hardware name: BCM2835
[=C2=A0=C2=A0=C2=A0 5.695927] [<c0312304>] (unwind_backtrace) from [<c030c=
c08>]
(show_stack+0x10/0x14)
[=C2=A0=C2=A0=C2=A0 5.712502] [<c030cc08>] (show_stack) from [<c0e7d358>]
(dump_stack+0xb4/0xc8)
[=C2=A0=C2=A0=C2=A0 5.728537] [<c0e7d358>] (dump_stack) from [<c03107c8>]
(handle_IPI+0x3bc/0x3dc)
[=C2=A0=C2=A0=C2=A0 5.744710] [<c03107c8>] (handle_IPI) from [<c0301a8c>]
(__irq_svc+0x6c/0x90)
[=C2=A0=C2=A0=C2=A0 5.760601] Exception stack(0xea8d7f60 to 0xea8d7fa8)
[=C2=A0=C2=A0=C2=A0 5.774348] 7f60: 00000000 000004e4 eb854ae0 c031d840 ff=
ffe000
c1704c6c c1704cac 00000008
[=C2=A0=C2=A0=C2=A0 5.791381] 7f80: 00000000 c1704c48 c1673568 00000000 00=
000002
ea8d7fb0 c0309164 c0309168
[=C2=A0=C2=A0=C2=A0 5.808421] 7fa0: 60000013 ffffffff
[=C2=A0=C2=A0=C2=A0 5.820668] [<c0301a8c>] (__irq_svc) from [<c0309168>]
(arch_cpu_idle+0x38/0x3c)
[=C2=A0=C2=A0=C2=A0 5.836950] [<c0309168>] (arch_cpu_idle) from [<c03747c4=
>]
(do_idle+0x1bc/0x298)
[=C2=A0=C2=A0=C2=A0 5.853198] [<c03747c4>] (do_idle) from [<c0374b3c>]
(cpu_startup_entry+0x18/0x1c)
[=C2=A0=C2=A0=C2=A0 5.869667] [<c0374b3c>] (cpu_startup_entry) from [<0030=
25cc>]
(0x3025cc)
[=C2=A0=C2=A0=C2=A0 5.885362] CPU1: stopping
[=C2=A0=C2=A0=C2=A0 5.896857] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 D W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
5.2.0-rc1-00004-g5aa6d98-dirty #2
[=C2=A0=C2=A0=C2=A0 5.915295] Hardware name: BCM2835
[=C2=A0=C2=A0=C2=A0 5.927623] [<c0312304>] (unwind_backtrace) from [<c030c=
c08>]
(show_stack+0x10/0x14)
[=C2=A0=C2=A0=C2=A0 5.944490] [<c030cc08>] (show_stack) from [<c0e7d358>]
(dump_stack+0xb4/0xc8)
[=C2=A0=C2=A0=C2=A0 5.960861] [<c0e7d358>] (dump_stack) from [<c03107c8>]
(handle_IPI+0x3bc/0x3dc)
[=C2=A0=C2=A0=C2=A0 5.977364] [<c03107c8>] (handle_IPI) from [<c0301a8c>]
(__irq_svc+0x6c/0x90)
[=C2=A0=C2=A0=C2=A0 5.993562] Exception stack(0xea8d3f60 to 0xea8d3fa8)
[=C2=A0=C2=A0=C2=A0 6.007632] 3f60: 00000000 00002930 eb82cae0 c031d840 ff=
ffe000
c1704c6c c1704cac 00000002
[=C2=A0=C2=A0=C2=A0 6.024974] 3f80: 00000000 c1704c48 c1673568 00000000 00=
000000
ea8d3fb0 c0309164 c0309168
[=C2=A0=C2=A0=C2=A0 6.042285] 3fa0: 60000013 ffffffff
[=C2=A0=C2=A0=C2=A0 6.054772] [<c0301a8c>] (__irq_svc) from [<c0309168>]
(arch_cpu_idle+0x38/0x3c)
[=C2=A0=C2=A0=C2=A0 6.071321] [<c0309168>] (arch_cpu_idle) from [<c03747c4=
>]
(do_idle+0x1bc/0x298)
[=C2=A0=C2=A0=C2=A0 6.087880] [<c03747c4>] (do_idle) from [<c0374b3c>]
(cpu_startup_entry+0x18/0x1c)
[=C2=A0=C2=A0=C2=A0 6.104610] [<c0374b3c>] (cpu_startup_entry) from [<0030=
25cc>]
(0x3025cc)
[=C2=A0=C2=A0=C2=A0 6.120535] CPU0: stopping
[=C2=A0=C2=A0=C2=A0 6.132240] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 D W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0
5.2.0-rc1-00004-g5aa6d98-dirty #2
[=C2=A0=C2=A0=C2=A0 6.150859] Hardware name: BCM2835
[=C2=A0=C2=A0=C2=A0 6.163308] [<c0312304>] (unwind_backtrace) from [<c030c=
c08>]
(show_stack+0x10/0x14)
[=C2=A0=C2=A0=C2=A0 6.180258] [<c030cc08>] (show_stack) from [<c0e7d358>]
(dump_stack+0xb4/0xc8)
[=C2=A0=C2=A0=C2=A0 6.196660] [<c0e7d358>] (dump_stack) from [<c03107c8>]
(handle_IPI+0x3bc/0x3dc)
[=C2=A0=C2=A0=C2=A0 6.213214] [<c03107c8>] (handle_IPI) from [<c0301a8c>]
(__irq_svc+0x6c/0x90)
[=C2=A0=C2=A0=C2=A0 6.229479] Exception stack(0xc1701f10 to 0xc1701f58)
[=C2=A0=C2=A0=C2=A0 6.243636] 1f00:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00000000
0000190c eb818ae0 c031d840
[=C2=A0=C2=A0=C2=A0 6.261073] 1f20: ffffe000 c1704c6c c1704cac 00000001 00=
000000
c1704c48 c1673568 00000000
[=C2=A0=C2=A0=C2=A0 6.278565] 1f40: 00000002 c1701f60 c0309164 c0309168 60=
000013 ffffffff
[=C2=A0=C2=A0=C2=A0 6.294466] [<c0301a8c>] (__irq_svc) from [<c0309168>]
(arch_cpu_idle+0x38/0x3c)
[=C2=A0=C2=A0=C2=A0 6.311211] [<c0309168>] (arch_cpu_idle) from [<c03747c4=
>]
(do_idle+0x1bc/0x298)
[=C2=A0=C2=A0=C2=A0 6.327979] [<c03747c4>] (do_idle) from [<c0374b3c>]
(cpu_startup_entry+0x18/0x1c)
[=C2=A0=C2=A0=C2=A0 6.344934] [<c0374b3c>] (cpu_startup_entry) from [<c150=
0e88>]
(start_kernel+0x460/0x48c)
[=C2=A0=C2=A0=C2=A0 6.362527] [<c1500e88>] (start_kernel) from [<00000000>=
] (0x0)
[=C2=A0=C2=A0=C2=A0 6.377824] ---[ end Kernel panic - not syncing: Attempt=
ed to kill
init! exitcode=3D0x0000000b ]---

