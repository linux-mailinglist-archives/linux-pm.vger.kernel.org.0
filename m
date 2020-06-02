Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775E1EC181
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgFBSBY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 14:01:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55618 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSBX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 14:01:23 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8B8B82A313C
Received: by earth.universe (Postfix, from userid 1000)
        id B1C343C08C7; Tue,  2 Jun 2020 20:01:19 +0200 (CEST)
Date:   Tue, 2 Jun 2020 20:01:19 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
Message-ID: <20200602180119.52izs7kd72u3kmr4@earth.universe>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <CGME20200601104027eucas1p2b076ee860520d709e8178c41550653f7@eucas1p2.samsung.com>
 <15933a91-dd89-1f94-c2f2-79be4395f4c1@samsung.com>
 <20200601170528.r5w3aeijny3v5yx3@earth.universe>
 <b3fd35de-1dd6-1ddc-7e57-2d9ab2860e81@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qlcnxi6fqxf4bmqp"
Content-Disposition: inline
In-Reply-To: <b3fd35de-1dd6-1ddc-7e57-2d9ab2860e81@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qlcnxi6fqxf4bmqp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 02, 2020 at 09:17:09AM +0200, Marek Szyprowski wrote:
> Hi Sebastian,
>=20
> On 01.06.2020 19:05, Sebastian Reichel wrote:
> > On Mon, Jun 01, 2020 at 12:40:27PM +0200, Marek Szyprowski wrote:
> >> On 13.05.2020 20:55, Sebastian Reichel wrote:
> >>> This patchset improves support for SBS compliant batteries. Due to
> >>> the changes, the battery now exposes 32 power supply properties and
> >>> (un)plugging it generates a backtrace containing the following message
> >>> without the first patch in this series:
> >>>
> >>> ---------------------------
> >>> WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0x=
d4/0x104
> >>> add_uevent_var: too many keys
> >>> ---------------------------
> >>>
> >>> For references this is what an SBS battery status looks like after
> >>> the patch series has been applied:
> >>>
> >>> cat /sys/class/power_supply/sbs-0-000b/uevent
> >>> POWER_SUPPLY_NAME=3Dsbs-0-000b
> >>> POWER_SUPPLY_TYPE=3DBattery
> >>> POWER_SUPPLY_STATUS=3DDischarging
> >>> POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> >>> POWER_SUPPLY_HEALTH=3DGood
> >>> POWER_SUPPLY_PRESENT=3D1
> >>> POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> >>> POWER_SUPPLY_CYCLE_COUNT=3D12
> >>> POWER_SUPPLY_VOLTAGE_NOW=3D11441000
> >>> POWER_SUPPLY_CURRENT_NOW=3D-26000
> >>> POWER_SUPPLY_CURRENT_AVG=3D-24000
> >>> POWER_SUPPLY_CAPACITY=3D76
> >>> POWER_SUPPLY_CAPACITY_ERROR_MARGIN=3D1
> >>> POWER_SUPPLY_TEMP=3D198
> >>> POWER_SUPPLY_TIME_TO_EMPTY_AVG=3D438600
> >>> POWER_SUPPLY_TIME_TO_FULL_AVG=3D3932100
> >>> POWER_SUPPLY_SERIAL_NUMBER=3D0000
> >>> POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D10800000
> >>> POWER_SUPPLY_VOLTAGE_MAX_DESIGN=3D10800000
> >>> POWER_SUPPLY_ENERGY_NOW=3D31090000
> >>> POWER_SUPPLY_ENERGY_FULL=3D42450000
> >>> POWER_SUPPLY_ENERGY_FULL_DESIGN=3D41040000
> >>> POWER_SUPPLY_CHARGE_NOW=3D2924000
> >>> POWER_SUPPLY_CHARGE_FULL=3D3898000
> >>> POWER_SUPPLY_CHARGE_FULL_DESIGN=3D3800000
> >>> POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=3D3000000
> >>> POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=3D12300000
> >>> POWER_SUPPLY_MANUFACTURE_YEAR=3D2017
> >>> POWER_SUPPLY_MANUFACTURE_MONTH=3D7
> >>> POWER_SUPPLY_MANUFACTURE_DAY=3D3
> >>> POWER_SUPPLY_MANUFACTURER=3DUR18650A
> >>> POWER_SUPPLY_MODEL_NAME=3DGEHC
> >> This patch landed in linux-next dated 20200529. Sadly it causes a
> >> regression on Samsung Exynos-based Chromebooks (Exynos5250 Snow,
> >> Exynos5420 Peach-Pi and Exynos5800 Peach-Pit). System boots to
> >> userspace, but then, when udev populates /dev, booting hangs:
> >>
> >> [=A0=A0=A0 4.435167] VFS: Mounted root (ext4 filesystem) readonly on d=
evice
> >> 179:51.
> >> [=A0=A0=A0 4.457477] devtmpfs: mounted
> >> [=A0=A0=A0 4.460235] Freeing unused kernel memory: 1024K
> >> [=A0=A0=A0 4.464022] Run /sbin/init as init process
> >> INIT: version 2.88 booting
> >> [info] Using makefile-style concurrent boot in runlevel S.
> >> [=A0=A0=A0 5.102096] random: crng init done
> >> [....] Starting the hotplug events dispatcher: systemd-udevdstarting
> >> version 236
> >> [ ok .
> >> [....] Synthesizing the initial hotplug events...[ ok done.
> >> [....] Waiting for /dev to be fully populated...[=A0=A0 34.409914]
> >> TPS65090_RAILSDCDC1: disabling
> >> [=A0=A0 34.412977] TPS65090_RAILSDCDC2: disabling
> >> [=A0=A0 34.417021] TPS65090_RAILSDCDC3: disabling
> >> [=A0=A0 34.423848] TPS65090_RAILSLDO1: disabling
> >> [=A0=A0 34.429068] TPS65090_RAILSLDO2: disabling
> > :(
> >
> > log does not look useful either.
> >
> >> Bisect between v5.7-rc1 and next-20200529 pointed me to the first bad
> >> commit: [c4b12a2f3f3de670f6be5e96092a2cab0b877f1a] power: supply:
> >> sbs-battery: simplify read_read_string_data.
> > ok. I tested this on an to-be-upstreamed i.MX6 based system
> > and arch/arm/boot/dts/imx53-ppd.dts. I think the difference
> > is, that i2c-exynos5 does not expose I2C_FUNC_SMBUS_READ_BLOCK_DATA.
> > I hoped all systems using SBS battery support this, but now
> > I see I2C_FUNC_SMBUS_EMUL only supports writing block data.
> > Looks like I need to add another patch implementing that
> > using the old code with added PEC support.
> >
> > In any case that should only return -ENODEV for the property
> > (and uevent), but not break boot. So something fishy is going
> > on.
> >
> >> However reverting it in linux-next doesn't fix the issue, so the
> >> next commits are also relevant to this issue.
> > The next patch, which adds PEC support depends on the simplification
> > of sbs_read_string_data. The old, open coded variant will result in
> > PEC failure for string properties (which should not stop boot either
> > of course). Can you try reverting both?
> Indeed, reverting both (and fixing the conflict) restores proper boot.

Ok, I pushed out a revert of those two patches. They should land in
tomorrows linux-next release. Please test it.

> > If that helps I will revert those two instead of dropping the whole
> > series for this merge window.
> >
> >> Let me know how can I help debugging it.
> > I suspect, that this is userspace endlessly retrying reading the
> > battery uevent when an error is returned. Could you check this?
> > Should be easy to see by adding some printfs.
> I've added some debug messages in sbs_get_property() and it read the=20
> same properties many times. However I've noticed that if I wait long=20
> enough booting finally continues.

So basically userspace slows down itself massively by trying to
re-read uevent over and over when an error occurs. Does not seem
like a sensible thing to do. I will have a look at this when I find
some time.

-- Sebastian

--qlcnxi6fqxf4bmqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7Wk+gACgkQ2O7X88g7
+pqfvhAAp3vLZAMmY0nQI+gSiUH60RC3gWVLX3NlbuoLZwpCmB+UAacJhEje1Jae
WxzoJZDMrk79M/LnJTwf2bUxFnOuGPVMh9agUNhpfx1gc6o97nBJhSISc9s46cDn
AskAmFojgm6G129GmcGG6FE1+H7uHgseGqHevr0Czth04cYsz/z3IrpN/M4cp9AJ
KqXw2ORkfXxZ8cbujffAsoW/SA0aBWMqRYpluNsukxwOAc4HZqIiaaSBsd9w94m7
SZgr6NFPEvfg2MsZIlFl5KvadL/zdMu7mM48Bo6KiZ4ALsWlntOQfW+AYX6VDk+C
Wzbd360Q8OyPVdZLQcUBjYvYRsFaFQh7iamGHHRzPIe2E0QEaJARyn4+db5pNptt
o0I1FcSE+s3hbBHBAPj6y4u91Safun8m2xMAccqVNR0mQUpdR4+UFMU2gs/dv9U9
0kzh5wB9c16g1BkQhy0u9aH604qXDRJ6EqDkjftsl8y7+7gxArUoSP+UgFUK3SuA
C8MfpFmnZNvZt7tAIUvldKbpfogisfTYhbbs8BNUYJosAqJAcIOCYR9GRR/26I7Z
POpxdn22sBpaKII78+ThvToqjx4A7IZ+P7La52HgUmsu1nWyYqeenAEIes4FJO3H
KG2hOpN9+SrhIRiE/GZ+Yk9RCgDgK4RTM+bjiMe9lymoFn2ozIQ=
=GTtY
-----END PGP SIGNATURE-----

--qlcnxi6fqxf4bmqp--
