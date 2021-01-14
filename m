Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC22F6E50
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 23:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbhANWh6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 14 Jan 2021 17:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730472AbhANWh6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Jan 2021 17:37:58 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF79BC061757;
        Thu, 14 Jan 2021 14:37:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E1A441F4587E
Received: by earth.universe (Postfix, from userid 1000)
        id A1D773C0C94; Thu, 14 Jan 2021 23:37:14 +0100 (CET)
Date:   Thu, 14 Jan 2021 23:37:14 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Carl Philipp Klemm <philipp@uvos.xyz>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 00/15] Updates for cpcap charger and battery
Message-ID: <20210114223714.rwfk2nvaa2zvtrg7@earth.universe>
References: <20210110195403.13758-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kz56nm36lqmjvqpr"
Content-Disposition: inline
In-Reply-To: <20210110195403.13758-1-tony@atomide.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kz56nm36lqmjvqpr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 10, 2021 at 09:53:48PM +0200, Tony Lindgren wrote:
> Hi all,
>=20
> Here's a series of patches to update cpcap charger and battery support
> for showing capacity. I've reorganized and cleaned up the patches posted
> earlier and simplified few things in the process compared to the earlier
> patches. The first few patches contain minor fixes that can wait for the
> merge window no problem.
>=20
> The battery capacity is only available if charge_full is written via
> sysfs based on calibration, and then a battery low or high value is
> seen. This follows what we already have for n900.

Thanks, queued.

-- Sebastian

>=20
> Regards,
>=20
> Tony
>=20
>=20
> Arthur Demchenkov (4):
>   power: supply: cpcap-battery: Add charge_full property
>   power: supply: cpcap-battery: Keep track of state for capacity
>     reporting
>   power: supply: cpcap-battery: Implement capacity reporting
>   power: supply: cpcap-battery: Add charge_now property
>=20
> Pavel Machek (2):
>   power: supply: cpcap-charger: Limiting charge current on Droid 4
>   power: supply: cpcap-battery: Fix typo
>=20
> Tony Lindgren (9):
>   power: supply: cpcap-charger: Fix missing power_supply_put()
>   power: supply: cpcap-battery: Fix missing power_supply_put()
>   power: supply: cpcap-charger: Fix flakey reboot with charger connected
>   power: supply: cpcap-charger: Make VBUS already provided debug only
>   power: supply: cpcap-charger: Use standard enumeration
>   power: supply: cpcap-charger: Drop internal state and use generic
>     stats
>   power: supply: cpcap-charger: Simplify things with enable and disable
>   power: supply: cpcap-charger: Provide state updates for battery from
>     charger
>   power: supply: cpcap-battery: Use charger status for battery full
>     detection
>=20
>  drivers/power/supply/cpcap-battery.c | 178 ++++++++++++++++--
>  drivers/power/supply/cpcap-charger.c | 259 +++++++++++++++++----------
>  2 files changed, 329 insertions(+), 108 deletions(-)
>=20
> --=20
> 2.30.0

--kz56nm36lqmjvqpr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmAAx5AACgkQ2O7X88g7
+pp0TQ/+L4IEkSFY0+X6+ir/FauISZNm3/YtrYgeGA/5koiINwfM5Q8nDPqAyMji
FvpIxsW3XfHFz3C78o2pt+WQY4IKENT1TkgLQgh3SybmSqDFYolToiP8JvCKGZbd
Eq6HG/Z6jJs3dYnFXoRND4DX/dK+N0ZuclYCAzvB13IwUSih8VBfmvfURY8Y/fMT
2D38QMRcaRN8mLBd2HFMdoSNJBIkpKc76qr0T9lPNzRIRo04UaKgrkwKSvlMPSBP
dKnXxZt5gxRgXkAK/ikdSrJGz67HB03r+FGYuGUKhQenIy/4ngI4I53+7pe/OUrg
EAWknpFL+F1/HKDzZpTxUM5SjpID0/N2ojytxhtdLiz4oAuGQHsOot3jYAuhB4gd
XI5P19JxJaw1vXkQ8tggKNEgc3w7JrZuOHu7MAlzjiQ1WcIDvZ/roCbjVzhbMo8y
5Gg7uMilGzeh86f6UtZLc3YYV5uiieQyl3rvvU0t3zv6rt/UAmIlyXHs2oZqPZCA
gYfTOBVk21vvnyfdjFP+qkx6PyHKdQ+q1RbkH28Wsx4A0K9kXfzKarJdiq4/7JvA
ic/+97yWIL0r0vkKqmzNCIDo5nUHoR4ZO6i0k80+1KO/Z0UagF2xiSJlyyzLOOZ7
LeUTctcniSZbHWsleWWsfgUlQSHjDndQI+Zl7e3NUAS59V2JJvY=
=q1AZ
-----END PGP SIGNATURE-----

--kz56nm36lqmjvqpr--
