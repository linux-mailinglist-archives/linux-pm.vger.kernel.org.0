Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CF42F57FC
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 04:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbhANCMI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 21:12:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbhAMWIx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 17:08:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6B2C061794
        for <linux-pm@vger.kernel.org>; Wed, 13 Jan 2021 14:07:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 317001F45752
Received: by earth.universe (Postfix, from userid 1000)
        id CB3EC3C0C96; Wed, 13 Jan 2021 23:07:45 +0100 (CET)
Date:   Wed, 13 Jan 2021 23:07:45 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] power: supply: z2_battery: Convert to GPIO descriptors
Message-ID: <20210113220745.ptujoqgfglof6e2q@earth.universe>
References: <20210110144906.168877-1-linus.walleij@linaro.org>
 <21aaf9d8-1cc3-a647-df5c-cc3777ced0f9@zonque.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7jfhhtqs4lrim2km"
Content-Disposition: inline
In-Reply-To: <21aaf9d8-1cc3-a647-df5c-cc3777ced0f9@zonque.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--7jfhhtqs4lrim2km
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 11, 2021 at 08:25:05AM +0100, Daniel Mack wrote:
> On 10/1/2021 3:49 pm, Linus Walleij wrote:
> > This converts the Palm Z2 battery driver to use GPIO descriptors.
> >=20
> > Cc: Daniel Mack <daniel@zonque.org>
> > Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> > Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Reviewed-by: Daniel Mack <daniel@zonque.org>

Thanks, queued to power-supply's for-next branch via the following
immutable branch (which also contains the wm97xx_battery change):

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-su=
pply.git tags/ib-psy-pxa-for-5.12-signed

for you to fetch changes up to cb6d6918c56ffd98e88164d5471f692d33dabf2b:

  power: supply: wm97xx_battery: Convert to GPIO descriptor (2021-01-13 22:=
25:07 +0100)

----------------------------------------------------------------
Immutable branch between mach-pxa and power-supply for for 5.12

This immutable branch replaces legacy gpio API in wm97xx_battery and
z2_battery with new gpiod API, which involves the drivers in
power-supply and some mach-pxa board files.

Signed-off-by: Sebastian Reichel <sre@kernel.org>

----------------------------------------------------------------
Linus Walleij (2):
      power: supply: z2_battery: Convert to GPIO descriptors
      power: supply: wm97xx_battery: Convert to GPIO descriptor

 arch/arm/mach-pxa/mioa701.c           |  1 -
 arch/arm/mach-pxa/palm27x.c           |  1 -
 arch/arm/mach-pxa/palmte2.c           |  1 -
 arch/arm/mach-pxa/z2.c                | 12 ++++++++-
 drivers/power/supply/wm97xx_battery.c | 45 +++++++++++++++----------------=
---
 drivers/power/supply/z2_battery.c     | 46 ++++++++++++++++---------------=
----
 include/linux/wm97xx.h                |  1 -
 include/linux/z2_battery.h            |  1 -
 8 files changed, 51 insertions(+), 57 deletions(-)

-- Sebastian

--7jfhhtqs4lrim2km
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl//bzEACgkQ2O7X88g7
+po0Zg/+OKYbpa88F8OjUWi+JzCftzQxUiiEsfNy5J8C6wfZVZYkZJ7u574Dsi3w
h7ifKDHwAeAjBV0nA7FPWljXLlzBhFiqBU1rgEUp8m/wSPFNmnJKhJS8+AOMwBig
GmErBw6uJUjhiHYr42MKjios1j0FdYwOPIt9Npr4tqbGINx5J80uk9JDYb//kkQe
jxMbDDY22/tx9xE3tcMlDcO4cG3wy/MHcyJTm34bomgmd/XfEBbKtdJ/pmec8O1z
JSNfHIfFxl/a1k2BiWM77H1vh3eQ+6pSTWFDRZJKQv7hl6kS2bcITT5Kiq077FjM
Q3MkVB4je5H/er0fXrdzF31IBq5qsa9kcsiuQ32b/1yDhr4af76Fe0JHc7GR+smI
nVAnlUiUlSjMZmuTHb7QR2DocVOjI89dG1cmt7nfFqaT0wrQl3OBvFF9MEVBIyeO
fsPIzm2eF3Cn2XD/FXg4pEG6HQ+9G9KAfn0MBS3FgS+KtuVPEzZbPyFH6Uji2KuB
2p96l9Mj+eiGPm9N9ZBNvTU+wgxKFIrA2MsS3a6QVUdgHIrmd7NUI4M0UW71aJ1l
pgISoP16rimWTPrHeifQIvM3APEh0490YnIXRveg42DDEN0qCeg+5MGDFNWl1COE
i3VphGKZ505/sJogJi8DM0DN/tLotyg/6WfdG/LcbZPps6bYC4g=
=Yq5c
-----END PGP SIGNATURE-----

--7jfhhtqs4lrim2km--
