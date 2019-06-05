Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFDA35AC3
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 13:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfFELAQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 07:00:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:51198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727154AbfFELAP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 07:00:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA6AEB048;
        Wed,  5 Jun 2019 11:00:13 +0000 (UTC)
Message-ID: <1a86637dad1d2f33450950143a82016beb91bdb6.camel@suse.de>
Subject: Re: [PATCH 0/4] cpufreq support for the Raspberry Pi
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stefan Wahren <wahrenst@gmx.net>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     f.fainelli@gmail.com, ptesarik@suse.com, sboyd@kernel.org,
        viresh.kumar@linaro.org, mturquette@baylibre.com,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org, eric@anholt.net,
        bcm-kernel-feedback-list@broadcom.com, linux-clk@vger.kernel.org,
        mbrugger@suse.de, ssuloev@orpaltech.com
Date:   Wed, 05 Jun 2019 13:00:10 +0200
In-Reply-To: <2ece3f20-ef8c-c39e-941c-76635ddbe185@gmx.net>
References: <20190604173223.4229-1-nsaenzjulienne@suse.de>
         <2ece3f20-ef8c-c39e-941c-76635ddbe185@gmx.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-wVmio/A9DEF+oH+PeAtt"
User-Agent: Evolution 3.32.2 
MIME-Version: 1.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-wVmio/A9DEF+oH+PeAtt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,
thanks for the review, I took note of your code comments.

On Wed, 2019-06-05 at 11:46 +0200, Stefan Wahren wrote:
> Hi Nicolas,
>=20
> Am 04.06.19 um 19:32 schrieb Nicolas Saenz Julienne:
> > Hi all,
> > this series aims at adding cpufreq support to the Raspberry Pi family o=
f
> > boards.
> >=20
> > The previous revision can be found at: https://lkml.org/lkml/2019/5/20/=
431
> >=20
> > The series first factors out 'pllb' from clk-bcm2385 and creates a new
> > clk driver that operates it over RPi's firmware interface[1]. We are
> > forced to do so as the firmware 'owns' the pll and we're not allowed to
> > change through the register interface directly as we might race with th=
e
> > over-temperature and under-voltage protections provided by the firmware=
.
> it would be nice to preserve such design decision in the driver as a
> comment, because the cover letter usually get lost.
> > Next it creates a minimal cpufreq driver that populates the CPU's opp
> > table, and registers cpufreq-dt. Which is needed as the firmware
> > controls the max and min frequencies available.
>=20
> I tested your series on top of Linux 5.2-rc1 with multi_v7_defconfig and
> manually enable this drivers. During boot with Raspbian rootfs i'm
> getting the following:
>=20
> [    1.177009] cpu cpu0: failed to get clock: -2
> [    1.183643] cpufreq-dt: probe of cpufreq-dt failed with error -2

This is surprising, who could be creating a platform_device for cpufreq-dt
apart from raspberrypi-cpufreq? Just to make things clear, you're using the
device tree from v5.2-rc1 (as opposed to the Raspbian one)?

> [    1.192117] sdhci: Secure Digital Host Controller Interface driver
> [    1.198725] sdhci: Copyright(c) Pierre Ossman
> [    1.207005] Synopsys Designware Multimedia Card Interface Driver
> [    1.319936] sdhost-bcm2835 3f202000.mmc: loaded - DMA enabled (>1)
> [    1.326641] sdhci-pltfm: SDHCI platform and OF driver helper
> [    1.336568] ledtrig-cpu: registered to indicate activity on CPUs
> [    1.343713] usbcore: registered new interface driver usbhid
> [    1.350275] usbhid: USB HID core driver
> [    1.357639] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
> [    1.367490] NET: Registered protocol family 10
> [    1.375013] Segment Routing with IPv6
> [    1.381696] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    1.388980] NET: Registered protocol family 17
> [    1.395624] can: controller area network core (rev 20170425 abi 9)
> [    1.402358] NET: Registered protocol family 29
> [    1.408997] can: raw protocol (rev 20170425)
> [    1.415599] can: broadcast manager protocol (rev 20170425 t)
> [    1.422219] can: netlink gateway (rev 20170425) max_hops=3D1
> [    1.429369] Key type dns_resolver registered
> [    1.437190] Registering SWP/SWPB emulation handler
> [    1.444443] Loading compiled-in X.509 certificates
> [    1.455693] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq =3D 81,
> base_baud =3D 0) is a PL011 rev2
> [    1.462768] serial serial0: tty port ttyAMA0 registered
> [    1.478755] mmc0: host does not support reading read-only switch,
> assuming write-enable
> [    1.488792] mmc0: new high speed SDHC card at address 0007
> [    1.495766] raspberrypi-firmware soc:firmware: Attached to firmware
> from 2019-03-27 15:45
> [    1.496862] mmcblk0: mmc0:0007 SDCIT 14.6 GiB
> [    1.512768] raspberrypi-clk raspberrypi-clk: CPU frequency range: min
> 600000000, max 1400000000
> [    1.513012]  mmcblk0: p1 p2
> [    1.558085] dwc2 3f980000.usb: 3f980000.usb supply vusb_d not found,
> using dummy regulator
> [    1.565355] dwc2 3f980000.usb: 3f980000.usb supply vusb_a not found,
> using dummy regulator
> [    1.623246] dwc2 3f980000.usb: DWC OTG Controller
> [    1.630318] dwc2 3f980000.usb: new USB bus registered, assigned bus
> number 1
> [    1.637439] dwc2 3f980000.usb: irq 33, io mem 0x3f980000
> [    1.645268] hub 1-0:1.0: USB hub found
> [    1.652317] hub 1-0:1.0: 1 port detected
> [    1.665867] sdhci-iproc 3f300000.sdhci: allocated mmc-pwrseq
> [    1.704788] mmc1: SDHCI controller on 3f300000.sdhci [3f300000.sdhci]
> using PIO
> [    1.717694] hctosys: unable to open rtc device (rtc0)
> [    1.724967] sysfs: cannot create duplicate filename
> '/devices/platform/cpufreq-dt'

For the record, this is raspberrypi-cpufreq creating the platform device fo=
r
cpufreq-dt.

> [    1.732120] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
> 5.2.0-rc1-00004-g5aa6d98-dirty #2
> [    1.739288] Hardware name: BCM2835
> [    1.746421] [<c0312304>] (unwind_backtrace) from [<c030cc08>]
> (show_stack+0x10/0x14)
> [    1.753636] [<c030cc08>] (show_stack) from [<c0e7d358>]
> (dump_stack+0xb4/0xc8)
> [    1.760840] [<c0e7d358>] (dump_stack) from [<c0503b64>]
> (sysfs_warn_dup+0x58/0x64)
> [    1.768105] [<c0503b64>] (sysfs_warn_dup) from [<c0503c8c>]
> (sysfs_create_dir_ns+0xd8/0xe8)
> [    1.775481] [<c0503c8c>] (sysfs_create_dir_ns) from [<c0e82520>]
> (kobject_add_internal+0xb0/0x2fc)
> [    1.782958] [<c0e82520>] (kobject_add_internal) from [<c0e827c8>]
> (kobject_add+0x5c/0xc0)
> [    1.790534] [<c0e827c8>] (kobject_add) from [<c096b1cc>]
> (device_add+0xf8/0x608)
> [    1.798180] [<c096b1cc>] (device_add) from [<c0971098>]
> (platform_device_add+0x110/0x214)
> [    1.805945] [<c0971098>] (platform_device_add) from [<c0971ae4>]
> (platform_device_register_full+0x130/0x148)
> [    1.813866] [<c0971ae4>] (platform_device_register_full) from
> [<c15a7a30>] (raspberrypi_cpufreq_driver_init+0x128/0x178)
> [    1.821916] [<c15a7a30>] (raspberrypi_cpufreq_driver_init) from
> [<c0302eec>] (do_one_initcall+0x54/0x21c)
> [    1.830099] [<c0302eec>] (do_one_initcall) from [<c15010f8>]
> (kernel_init_freeable+0x244/0x2e0)
> [    1.838312] [<c15010f8>] (kernel_init_freeable) from [<c0e949d4>]
> (kernel_init+0x8/0x10c)
> [    1.846541] [<c0e949d4>] (kernel_init) from [<c03010e8>]
> (ret_from_fork+0x14/0x2c)
> [    1.854783] Exception stack(0xea89dfb0 to 0xea89dff8)
> [    1.863036] dfa0:                                     00000000
> 00000000 00000000 00000000
> [    1.871450] dfc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [    1.879860] dfe0: 00000000 00000000 00000000 00000000 00000013 0000000=
0
> [    1.888251] kobject_add_internal failed for cpufreq-dt with -EEXIST,
> don't try to register things with the same name in the same directory.
> [    1.896910] cpu cpu0: Failed to create platform device, -17

Regards,
Nicolas


--=-wVmio/A9DEF+oH+PeAtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlz3oLoACgkQlfZmHno8
x/7zvQf/V4c0fc8xTLQbkZXFwxALIDGeOBcKtsADEE4B2P4nvhQocKj3gRGMQnrr
uch5AaY0imgHh3GbWvJhJ6M9MmRkIFtzbLkI49Fk3q0Y6PNcvVJMxyw5W12+gKmS
f0I11JzHmdW92KUp4FmGqtwWqccv00HyrHv4Vzq2nR9F1ZxnPb919H104fvC3dGe
iXIWm0TT0/pV59nKzkcbwD3gGcel6CV4cTjCUtOZHSVdkwBWSDeJHt+rM9Z35om8
35MDL8axJmaxc/uXpYwP1PrI9pxHbNPbbXCdWx32O8aTnRgqd84tKFg2Od4xCrxl
pHC5UW7M+srr9ZiXTw6IkbA0bNWiWg==
=yFC9
-----END PGP SIGNATURE-----

--=-wVmio/A9DEF+oH+PeAtt--

