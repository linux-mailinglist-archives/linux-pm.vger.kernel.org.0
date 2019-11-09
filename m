Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9DEF5DB2
	for <lists+linux-pm@lfdr.de>; Sat,  9 Nov 2019 07:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfKIGYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 9 Nov 2019 01:24:32 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:23569 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIGYb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 9 Nov 2019 01:24:31 -0500
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Nov 2019 01:24:28 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573280667;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WMmQ4+DDSXPayYeZHO1v0pTuWaWEXdBQOD1L/vQ0wYA=;
        b=pNWI8VFLfQLSO/0cXszM3IwAKkfStabkkXe1bxIeuzTjodElRJ/LB2CqJ8alMkYONZ
        xpf8wOn/s4LRLdCxRczYXwEosgccLsh4J1UDmBaQskq4ccXx4t119QBGGEBdN1xT1WeD
        aO1RvX/fboKuWCWVzO+N4/MkJPev02sxmjmxnwSxzoXBX8JKVJX0aDN+7DtMGS2cxHGe
        B8x0mgLJP24wxTXc6peg7j3UOVj4LoaXPz3TQdzoEuvUDWAKAitktm1T+E0NgXio98Tu
        IgXIWl6Bc0ABw2rEh4WdQmvKe/jx/z98968NOaMEwsy2dXJSgQ2/FihaEkb7YLk0Ztv6
        qyuA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PrwDOi71s="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id L09db3vA96CMnPU
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sat, 9 Nov 2019 07:12:22 +0100 (CET)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 0/8] OMAP3: convert opp-v1 to opp-v2 and read speed binned / 720MHz grade bits
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CAHCN7xLvuj_LkvOV3YG5=0MZYsohbQArE0UCZx6pcRPwM5pkYg@mail.gmail.com>
Date:   Sat, 9 Nov 2019 07:12:22 +0100
Cc:     =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?Q?Andr=C3=A9_Roth?= <neolynx@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Roger Quadros <rogerq@ti.com>,
        Teresa Remmet <t.remmet@phytec.de>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        arm-soc <linux-arm-kernel@lists.infradead.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4F6078BD-0759-4B47-933E-E29EE1D8AD18@goldelico.com>
References: <cover.1568224032.git.hns@goldelico.com> <CAHCN7xLvuj_LkvOV3YG5=0MZYsohbQArE0UCZx6pcRPwM5pkYg@mail.gmail.com>
To:     Adam Ford <aford173@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Adam,

> Am 08.11.2019 um 21:08 schrieb Adam Ford <aford173@gmail.com>:
>=20
>=20
> Nikolaus,
>=20
> I am getting some notices sent to me when I apply your series.  It
> works, but I want to clean up the notice.  Can you suggest what might
> cause this:
>=20
>     debugfs: Directory 'cpu0-cpu0' with parent
> '48070000.i2c:twl@48:regulator-vdd1-VDD1' already present!
>=20
> It wasn't present before your series.  It's not a big deal, but I'd
> like to quiet down the messages if I can.
> Thanks.

I have checked and can also see this message - and it should be removed.

There is a debugfs node at:

=
/sys/kernel/debug/regulator/48070000.i2c:twl@48:regulator-vdd1-VDD1/cpu0-c=
pu0

OMAP5 also has a similar node but no such debugfs warning:

/sys/kernel/debug/regulator/smps123/cpu0-cpu0

So what I suspect is some bug in the twl4030 regulator driver which is
just revealed by my patch series for the first time.

Could it be that the debugfs node is created and not cleaned up by =
deferred
probing?

But this is not explicitly done in drivers/regulator/twl-regulator.c

BTW: twl6030 and palmas (twl6037) have separate driver, so that =
mentioning
twl6030 in the comments in drivers/regulator/twl-regulator.c may be =
wrong.
It also mentions some "TW5030" which I have never heard of.

To find out the call sequence I added a dump_stack to start_creating()
after the error message is printed:


[    2.289947] debugfs: Directory 'cpu0-cpu0' with parent =
'48070000.i2c:twl@48:regulator-vdd1-VDD1' already present!
[    2.301727] CPU: 0 PID: 1 Comm: swapper/0 Not tainted =
5.4.0-rc6-letux+ #1329
[    2.309112] Hardware name: Generic OMAP36xx (Flattened Device Tree)
[    2.315734] [<c0110028>] (unwind_backtrace) from [<c010b60c>] =
(show_stack+0x10/0x14)
[    2.323852] [<c010b60c>] (show_stack) from [<c07b9b60>] =
(dump_stack+0x7c/0x9c)
[    2.331420] [<c07b9b60>] (dump_stack) from [<c0373588>] =
(start_creating+0xa8/0x104)
[    2.339477] [<c0373588>] (start_creating) from [<c0373fb0>] =
(debugfs_create_dir+0xc/0xc0)
[    2.348052] [<c0373fb0>] (debugfs_create_dir) from [<c04e96e0>] =
(create_regulator+0xd0/0x1c8)
[    2.356994] [<c04e96e0>] (create_regulator) from [<c04ec608>] =
(_regulator_get+0x190/0x224)
[    2.365661] [<c04ec608>] (_regulator_get) from [<c06653d0>] =
(dt_cpufreq_probe+0x80/0x108)
[    2.374237] [<c06653d0>] (dt_cpufreq_probe) from [<c053e018>] =
(platform_drv_probe+0x48/0x98)
[    2.383087] [<c053e018>] (platform_drv_probe) from [<c053c3a8>] =
(really_probe+0x164/0x324)
[    2.391754] [<c053c3a8>] (really_probe) from [<c053c7b8>] =
(driver_probe_device+0x10c/0x154)
[    2.400512] [<c053c7b8>] (driver_probe_device) from [<c053a9f4>] =
(bus_for_each_drv+0x90/0xb8)
[    2.409423] [<c053a9f4>] (bus_for_each_drv) from [<c053c5f8>] =
(__device_attach+0x90/0x120)
[    2.418090] [<c053c5f8>] (__device_attach) from [<c053b628>] =
(bus_probe_device+0x28/0x80)
[    2.426666] [<c053b628>] (bus_probe_device) from [<c05393ec>] =
(device_add+0x2f0/0x55c)
[    2.434967] [<c05393ec>] (device_add) from [<c053decc>] =
(platform_device_add+0x12c/0x1b8)
[    2.443542] [<c053decc>] (platform_device_add) from [<c053e954>] =
(platform_device_register_full+0xec/0x13c)
[    2.453765] [<c053e954>] (platform_device_register_full) from =
[<c0665ff4>] (ti_cpufreq_probe+0x298/0x2fc)
[    2.463775] [<c0665ff4>] (ti_cpufreq_probe) from [<c053e018>] =
(platform_drv_probe+0x48/0x98)
[    2.472625] [<c053e018>] (platform_drv_probe) from [<c053c3a8>] =
(really_probe+0x164/0x324)
[    2.481292] [<c053c3a8>] (really_probe) from [<c053c7b8>] =
(driver_probe_device+0x10c/0x154)
[    2.490051] [<c053c7b8>] (driver_probe_device) from [<c053a9f4>] =
(bus_for_each_drv+0x90/0xb8)
[    2.498992] [<c053a9f4>] (bus_for_each_drv) from [<c053c5f8>] =
(__device_attach+0x90/0x120)
[    2.507629] [<c053c5f8>] (__device_attach) from [<c053b628>] =
(bus_probe_device+0x28/0x80)
[    2.516204] [<c053b628>] (bus_probe_device) from [<c05393ec>] =
(device_add+0x2f0/0x55c)
[    2.524505] [<c05393ec>] (device_add) from [<c053decc>] =
(platform_device_add+0x12c/0x1b8)
[    2.533081] [<c053decc>] (platform_device_add) from [<c053e954>] =
(platform_device_register_full+0xec/0x13c)
[    2.543304] [<c053e954>] (platform_device_register_full) from =
[<c0665d2c>] (ti_cpufreq_init+0x78/0xa8)
[    2.553039] [<c0665d2c>] (ti_cpufreq_init) from [<c0102ed8>] =
(do_one_initcall+0xb4/0x268)
[    2.561645] [<c0102ed8>] (do_one_initcall) from [<c0b00fe4>] =
(kernel_init_freeable+0x11c/0x1ec)
[    2.570770] [<c0b00fe4>] (kernel_init_freeable) from [<c07cf1c8>] =
(kernel_init+0x8/0x110)
[    2.579345] [<c07cf1c8>] (kernel_init) from [<c01010e8>] =
(ret_from_fork+0x14/0x2c)
[    2.587249] Exception stack(0xde0b1fb0 to 0xde0b1ff8)
[    2.592559] 1fa0:                                     00000000 =
00000000 00000000 00000000
[    2.601135] 1fc0: 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000 00000000
[    2.609680] 1fe0: 00000000 00000000 00000000 00000000 00000013 =
00000000


So the problem seems to be that ti_cpufreq_probe() tries to register the =
regulators
"vdd" and "vbb" without properly checking if they have been registered =
elsewhere.

The second attempt to create the debugfs directory seems to come from =
resources_available()
which thinks that it has to create the regulator (again) [around line =
1935 in drivers/regulator/core.c].

Hope this helps, although I have no idea why the vdd regulator already =
exists at that point.

BR,
Nikolaus



