Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6CE1EA820
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 19:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgFARFd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 13:05:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41044 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgFARFd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 13:05:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B61BB2A23F8
Received: by earth.universe (Postfix, from userid 1000)
        id 4E7143C08C7; Mon,  1 Jun 2020 19:05:28 +0200 (CEST)
Date:   Mon, 1 Jun 2020 19:05:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCHv1 00/19] Improve SBS battery support
Message-ID: <20200601170528.r5w3aeijny3v5yx3@earth.universe>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <CGME20200601104027eucas1p2b076ee860520d709e8178c41550653f7@eucas1p2.samsung.com>
 <15933a91-dd89-1f94-c2f2-79be4395f4c1@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pptq4mcmy2xywbfv"
Content-Disposition: inline
In-Reply-To: <15933a91-dd89-1f94-c2f2-79be4395f4c1@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--pptq4mcmy2xywbfv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

On Mon, Jun 01, 2020 at 12:40:27PM +0200, Marek Szyprowski wrote:
> On 13.05.2020 20:55, Sebastian Reichel wrote:
> > This patchset improves support for SBS compliant batteries. Due to
> > the changes, the battery now exposes 32 power supply properties and
> > (un)plugging it generates a backtrace containing the following message
> > without the first patch in this series:
> >
> > ---------------------------
> > WARNING: CPU: 0 PID: 20 at lib/kobject_uevent.c:659 add_uevent_var+0xd4=
/0x104
> > add_uevent_var: too many keys
> > ---------------------------
> >
> > For references this is what an SBS battery status looks like after
> > the patch series has been applied:
> >
> > cat /sys/class/power_supply/sbs-0-000b/uevent
> > POWER_SUPPLY_NAME=3Dsbs-0-000b
> > POWER_SUPPLY_TYPE=3DBattery
> > POWER_SUPPLY_STATUS=3DDischarging
> > POWER_SUPPLY_CAPACITY_LEVEL=3DNormal
> > POWER_SUPPLY_HEALTH=3DGood
> > POWER_SUPPLY_PRESENT=3D1
> > POWER_SUPPLY_TECHNOLOGY=3DLi-ion
> > POWER_SUPPLY_CYCLE_COUNT=3D12
> > POWER_SUPPLY_VOLTAGE_NOW=3D11441000
> > POWER_SUPPLY_CURRENT_NOW=3D-26000
> > POWER_SUPPLY_CURRENT_AVG=3D-24000
> > POWER_SUPPLY_CAPACITY=3D76
> > POWER_SUPPLY_CAPACITY_ERROR_MARGIN=3D1
> > POWER_SUPPLY_TEMP=3D198
> > POWER_SUPPLY_TIME_TO_EMPTY_AVG=3D438600
> > POWER_SUPPLY_TIME_TO_FULL_AVG=3D3932100
> > POWER_SUPPLY_SERIAL_NUMBER=3D0000
> > POWER_SUPPLY_VOLTAGE_MIN_DESIGN=3D10800000
> > POWER_SUPPLY_VOLTAGE_MAX_DESIGN=3D10800000
> > POWER_SUPPLY_ENERGY_NOW=3D31090000
> > POWER_SUPPLY_ENERGY_FULL=3D42450000
> > POWER_SUPPLY_ENERGY_FULL_DESIGN=3D41040000
> > POWER_SUPPLY_CHARGE_NOW=3D2924000
> > POWER_SUPPLY_CHARGE_FULL=3D3898000
> > POWER_SUPPLY_CHARGE_FULL_DESIGN=3D3800000
> > POWER_SUPPLY_CONSTANT_CHARGE_CURRENT_MAX=3D3000000
> > POWER_SUPPLY_CONSTANT_CHARGE_VOLTAGE_MAX=3D12300000
> > POWER_SUPPLY_MANUFACTURE_YEAR=3D2017
> > POWER_SUPPLY_MANUFACTURE_MONTH=3D7
> > POWER_SUPPLY_MANUFACTURE_DAY=3D3
> > POWER_SUPPLY_MANUFACTURER=3DUR18650A
> > POWER_SUPPLY_MODEL_NAME=3DGEHC
>=20
> This patch landed in linux-next dated 20200529. Sadly it causes a=20
> regression on Samsung Exynos-based Chromebooks (Exynos5250 Snow,=20
> Exynos5420 Peach-Pi and Exynos5800 Peach-Pit). System boots to=20
> userspace, but then, when udev populates /dev, booting hangs:
>=20
> [=A0=A0=A0 4.435167] VFS: Mounted root (ext4 filesystem) readonly on devi=
ce=20
> 179:51.
> [=A0=A0=A0 4.457477] devtmpfs: mounted
> [=A0=A0=A0 4.460235] Freeing unused kernel memory: 1024K
> [=A0=A0=A0 4.464022] Run /sbin/init as init process
> INIT: version 2.88 booting
> [info] Using makefile-style concurrent boot in runlevel S.
> [=A0=A0=A0 5.102096] random: crng init done
> [....] Starting the hotplug events dispatcher: systemd-udevdstarting=20
> version 236
> [ ok .
> [....] Synthesizing the initial hotplug events...[ ok done.
> [....] Waiting for /dev to be fully populated...[=A0=A0 34.409914]=20
> TPS65090_RAILSDCDC1: disabling
> [=A0=A0 34.412977] TPS65090_RAILSDCDC2: disabling
> [=A0=A0 34.417021] TPS65090_RAILSDCDC3: disabling
> [=A0=A0 34.423848] TPS65090_RAILSLDO1: disabling
> [=A0=A0 34.429068] TPS65090_RAILSLDO2: disabling

:(

log does not look useful either.

> Bisect between v5.7-rc1 and next-20200529 pointed me to the first bad=20
> commit: [c4b12a2f3f3de670f6be5e96092a2cab0b877f1a] power: supply:=20
> sbs-battery: simplify read_read_string_data.

ok. I tested this on an to-be-upstreamed i.MX6 based system
and arch/arm/boot/dts/imx53-ppd.dts. I think the difference
is, that i2c-exynos5 does not expose I2C_FUNC_SMBUS_READ_BLOCK_DATA.
I hoped all systems using SBS battery support this, but now
I see I2C_FUNC_SMBUS_EMUL only supports writing block data.
Looks like I need to add another patch implementing that
using the old code with added PEC support.

In any case that should only return -ENODEV for the property
(and uevent), but not break boot. So something fishy is going
on.

> However reverting it in linux-next doesn't fix the issue, so the
> next commits are also relevant to this issue.

The next patch, which adds PEC support depends on the simplification
of sbs_read_string_data. The old, open coded variant will result in
PEC failure for string properties (which should not stop boot either
of course). Can you try reverting both?

If that helps I will revert those two instead of dropping the whole
series for this merge window.

> Let me know how can I help debugging it.

I suspect, that this is userspace endlessly retrying reading the
battery uevent when an error is returned. Could you check this?
Should be easy to see by adding some printfs.

That would mean a faulty battery could stall complete boot without
a useful error message, which is bad and needs to be fixed.

Sorry for the inconvience and thanks for your report,

-- Sebastian

--pptq4mcmy2xywbfv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7VNVEACgkQ2O7X88g7
+prs4Q/+Oog/pqXDuQrwMX2D8/43npxQGz7VEb2GI/wiyim6Oq9Kw1XgTjJnUpfG
adWleKQhPYlj07KHSC7ZibvRre4k0y1SCvfsHE2U5Twkgr1N77oyarxshhNuhR2n
DqpLKb5iFq0k0uP6AIgUnBQBX597AY9OGzVDjTw7GuFMtjBtLLSl8p9sh1CfkL/s
yhsVNwptOTcYZsHS+VeKrT7vtzJjwF0h8X01eKfUPBeMd1usKZOsQbkHjilObQ4g
JQW04ozLEuEkMn8rqEJ127bHz8IPHYnXfxpPYMY5oA8XqZ3cRFsfTQKt7Yh/EzJH
hIYmqc2MMjcshv9jpAyCW1blyy9gXhjOEjIXQGkGC/yvZw8EFw0oE5ve44LC2+uQ
4t54P0Ae39O+ZO2l/z86EXDSuYzFWhGv48/Gn+xYUS4KPfs/SoqwVK6BP1XJCibA
EkW6V0n8Jd1ee5jTQlApBTqzWoGSntoqP7LnHQeWdq+54JDAGY3Pfydq8HxaIM4+
QvxfcGY6+Xc+SMuWFpMdBuVP+Z11Sq4rk8nA7LY546n/+E81eU7zFCOAnZfXewIH
4s9xyNV8pjCvqIhsyiw5mLTxx5/ZNmJa5aqcZeh/sSScaOUl4PsoZvXo7ahDHJz6
2PPUheRmlUz8fQXdlCrpDzcM/HH+wYMJiQTq13cQZ4WYY5XauZk=
=s38G
-----END PGP SIGNATURE-----

--pptq4mcmy2xywbfv--
