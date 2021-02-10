Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFE03167BB
	for <lists+linux-pm@lfdr.de>; Wed, 10 Feb 2021 14:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbhBJNQq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Feb 2021 08:16:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:34192 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231626AbhBJNQb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 08:16:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 927AFAE3F;
        Wed, 10 Feb 2021 13:15:47 +0000 (UTC)
Message-ID: <6d9ca41b4ad2225db102da654d38bc61f6c1c111.camel@suse.de>
Subject: Re: bcm2711_thermal: Kernel panic - not syncing: Asynchronous
 SError Interrupt
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        stefan.wahren@i2se.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.con>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:15:46 +0100
In-Reply-To: <20210210114829.2915de78@gollum>
References: <20210210114829.2915de78@gollum>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-J1qDyUNdxU+kCVLbFS3S"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--=-J1qDyUNdxU+kCVLbFS3S
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[ Add Robin, Catalin and Florian in case they want to chime in ]

Hi Juerg, thanks for the report!

On Wed, 2021-02-10 at 11:48 +0100, Juerg Haefliger wrote:
> Trying to dump the BCM2711 registers kills the kernel:
>=20
> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/range
> 0-efc
> # cat /sys/kernel/debug/regmap/dummy-avs-monitor\@fd5d2000/registers=20
>=20
> [   62.857661] SError Interrupt on CPU1, code 0xbf000002 -- SError

So ESR's IDS (bit 24) is set, which means it's an 'Implementation Defined
SError,' hence IIUC the rest of the error code is meaningless to anyone out=
side
of Broadcom/RPi.

The regmap is created through the following syscon device:

	avs_monitor: avs-monitor@7d5d2000 {
		compatible =3D "brcm,bcm2711-avs-monitor",
			     "syscon", "simple-mfd";
		reg =3D <0x7d5d2000 0xf00>;

		thermal: thermal {
			compatible =3D "brcm,bcm2711-thermal";
			#thermal-sensor-cells =3D <0>;
		};
	};

I've done some tests with devmem, and the whole <0x7d5d2000 0xf00> range is
full of addresses that trigger this same error. Also note that as per Flori=
an's
comments[1]: "AVS_RO_REGISTERS_0: 0x7d5d2200 - 0x7d5d22e3." But from what I=
 can
tell, at least 0x7d5d22b0 seems to be faulty too.

Any ideas/comments? My guess is that those addresses are marked somehow as
secure, and only for VC4 to access (VC4 is RPi4's co-processor). Ultimately=
,
the solution is to narrow the register range exposed by avs-monitor to what=
ever
bcm2711-thermal needs (which is ATM a single 32bit register).

Regards,
Nicolas

[1] https://lore.kernel.org/linux-pm/82125042-684a-b4e2-fbaa-45a393b2ce5e@g=
mx.net/

> [   62.857671] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
> [   62.857674] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> [   62.857676] pstate: 20000085 (nzCv daIf -PAN -UAO -TCO BTYPE=3D--)
> [   62.857679] pc : regmap_mmio_read32le+0x1c/0x34
> [   62.857681] lr : regmap_mmio_read+0x50/0x80
> [   62.857682] sp : ffff8000105c3c00
> [   62.857685] x29: ffff8000105c3c00 x28: 0000000000000014=20
> [   62.857694] x27: 0000000000000014 x26: ffffd2ea1c2060b0=20
> [   62.857699] x25: ffff4e34408ecc00 x24: 0000000000000efc=20
> [   62.857704] x23: ffff8000105c3e20 x22: ffff8000105c3d3c=20
> [   62.857710] x21: ffff8000105c3d3c x20: 0000000000000014=20
> [   62.857715] x19: ffff4e344037a900 x18: 0000000000000020=20
> [   62.857720] x17: 0000000000000000 x16: 0000000000000000=20
> [   62.857725] x15: ffff4e3447ac40f0 x14: 0000000000000003=20
> [   62.857730] x13: ffff4e34422c0000 x12: ffff4e34422a0046=20
> [   62.857735] x11: ffffd2ea1c8765e0 x10: 0000000000000000=20
> [   62.857741] x9 : ffffd2ea1b9495a0 x8 : ffff4e34429ef980=20
> [   62.857746] x7 : 000000000000000f x6 : ffff4e34422a004b=20
> [   62.857751] x5 : 00000000fffffff9 x4 : 0000000000000000=20
> [   62.857757] x3 : ffffd2ea1b949550 x2 : ffffd2ea1b949330=20
> [   62.857761] x1 : 0000000000000014 x0 : 0000000000000000=20
> [   62.857767] Kernel panic - not syncing: Asynchronous SError Interrupt
> [   62.857770] CPU: 1 PID: 478 Comm: cat Not tainted 5.11.0-rc7 #4
> [   62.857773] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
> [   62.857775] Call trace:
> [   62.857777]  dump_backtrace+0x0/0x1e0
> [   62.857778]  show_stack+0x24/0x70
> [   62.857780]  dump_stack+0xd0/0x12c
> [   62.857782]  panic+0x168/0x370
> [   62.857783]  nmi_panic+0x98/0xa0
> [   62.857786]  arm64_serror_panic+0x8c/0x98
> [   62.857787]  do_serror+0x3c/0x6c
> [   62.857789]  el1_error+0x78/0xf0
> [   62.857791]  regmap_mmio_read32le+0x1c/0x34
> [   62.857793]  _regmap_bus_reg_read+0x24/0x30
> [   62.857795]  _regmap_read+0x6c/0x17c
> [   62.857797]  regmap_read+0x58/0x84
> [   62.857799]  regmap_read_debugfs+0x138/0x3f4
> [   62.857801]  regmap_map_read_file+0x34/0x40
> [   62.857803]  full_proxy_read+0x6c/0xc0
> [   62.857805]  vfs_read+0xb8/0x1e4
> [   62.857807]  ksys_read+0x78/0x10c
> [   62.857809]  __arm64_sys_read+0x28/0x34
> [   62.857811]  el0_svc_common.constprop.0+0x7c/0x194
> [   62.857813]  do_el0_svc+0x30/0x9c
> [   62.857814]  el0_svc+0x20/0x30
> [   62.857816]  el0_sync_handler+0x1a4/0x1b0
> [   62.857818]  el0_sync+0x174/0x180
> [   62.857842] SMP: stopping secondary CPUs
> [   62.857845] Kernel Offset: 0x52ea0b080000 from 0xffff800010000000
> [   62.857847] PHYS_OFFSET: 0xffffb1cc00000000
> [   62.857849] CPU features: 0x00240022,61806000
> [   62.857851] Memory Limit: none
>=20
> Sprinkling printks around regmap_read [1] shows that reading from 0x14 (2=
0)
> seems to cause the issue:
>=20
>=20
> [   40.456230] map=3Dffff020a069c9c00, from=3D0, to=3D3836, count=3D13107=
2
> [   40.462520] map=3Dffff020a069c9c00, i=3D0
> [   40.466319] ret=3D0, val=3D0
> [   40.468922] map=3Dffff020a069c9c00, i=3D4
> [   40.472684] ret=3D0, val=3D0
> [   40.475292] map=3Dffff020a069c9c00, i=3D8
> [   40.479048] ret=3D0, val=3D0
> [   40.481649] map=3Dffff020a069c9c00, i=3D12
> [   40.485492] ret=3D0, val=3D0
> [   40.488080] map=3Dffff020a069c9c00, i=3D16
> [   40.491922] ret=3D0, val=3D0
> [   40.494523] map=3Dffff020a069c9c00, i=3D20
> [   40.498497] SError Interrupt on CPU0, code 0xbf000002 -- SError
> [   40.498499] CPU: 0 PID: 486 Comm: cat Not tainted 5.11.0-rc7+ #8
> [   40.498501] Hardware name: Raspberry Pi 4 Model B Rev 1.2 (DT)
>=20
>=20
> ...Juerg
>=20
> [1]
> diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/r=
egmap-debugfs.c
> index ff2ee87987c7..9465f5a2f3b8 100644
> --- a/drivers/base/regmap/regmap-debugfs.c
> +++ b/drivers/base/regmap/regmap-debugfs.c
> @@ -229,6 +229,7 @@ static ssize_t regmap_read_debugfs(struct regmap *map=
, unsigned int from,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (count > (PAGE_SIZE <<=
 (MAX_ORDER - 1)))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0count =3D PAGE_SIZE << (MAX_ORDER - 1);
> =C2=A0
>=20
> +       printk("map=3D%px, from=3D%d, to=3D%d, count=3D%ld\n", map, from,=
 to, count);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf =3D kmalloc(count, GF=
P_KERNEL);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!buf)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> @@ -253,7 +254,9 @@ static ssize_t regmap_read_debugfs(struct regmap *map=
, unsigned int from,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0buf=
_pos +=3D map->debugfs_reg_len + 2;
> =C2=A0
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* =
Format the value, write all X if we can't read */
> +                       printk("map=3D%px, i=3D%d\n", map, i);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
 =3D regmap_read(map, i, &val);
> +                       printk("ret=3D%ld, val=3D%x\n", ret, val);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if =
(ret =3D=3D 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0snprintf(buf + buf_pos, count =
- buf_pos,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0"%.*x", map->debugfs_val_len, val);
>=20




--=-J1qDyUNdxU+kCVLbFS3S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAj3IIACgkQlfZmHno8
x/4ASwgAllGRaK0Z5J8wKB1+Ig0TWi2yo/Kwb3TQpEC4Ap6D/geSUWfieuGUBzGb
pPbY27sVAmsYpKpvNJw7HVcieac9wx2wgtsNnOhZ0pI268Q+slWCzXLumS9LQNKl
lPIeanoqKp3AkvkMD8yaHSF6hXhs0a87qmivxK7JnGW6/MEcLu0hQO/Eghml13FU
v1VTuov/2Rp5xY0F8CZus+eufRvgvMtLtzPE9rezdnJu1Tph7lkJDDdHYzs+8MsP
//oIJ1sBi9PSqdbqpJQs7roGKxqhRA3pv3U9bcLwIq26xURLFrDfQlNmIejJ6+lf
5ac2g9vqCtSfJRZ/rjCd1JHbVl4Yfw==
=SLRR
-----END PGP SIGNATURE-----

--=-J1qDyUNdxU+kCVLbFS3S--

