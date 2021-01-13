Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DA42F57FB
	for <lists+linux-pm@lfdr.de>; Thu, 14 Jan 2021 04:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbhANCMH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Jan 2021 21:12:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38960 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729213AbhAMWIz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jan 2021 17:08:55 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E34831F4574F
Received: by earth.universe (Postfix, from userid 1000)
        id 7B8203C0C94; Wed, 13 Jan 2021 23:07:44 +0100 (CET)
Date:   Wed, 13 Jan 2021 23:07:44 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>, linux-pm@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] power: supply: wm97xx_battery: Convert to GPIO descriptor
Message-ID: <20210113220744.rcozqfaupjjwzsgc@earth.universe>
References: <20210110234508.218768-1-linus.walleij@linaro.org>
 <6a7f256c-d9ec-4c5f-6024-0ec8296a9f95@zonque.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="stcxeqb4e42jxihr"
Content-Disposition: inline
In-Reply-To: <6a7f256c-d9ec-4c5f-6024-0ec8296a9f95@zonque.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--stcxeqb4e42jxihr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 11, 2021 at 08:24:30AM +0100, Daniel Mack wrote:
> On 11/1/2021 12:45 am, Linus Walleij wrote:
> > This converts the WM97xx driver to use a GPIO descriptor
> > instead of passing a GPIO number thru platform data.
> >=20
> > Like everything else in the driver, use a simple local
> > variable for the descriptor, it can only ever appear in
> > one instance anyway so it should not hurt.
> >=20
> > After converting the driver I noticed that none of the
> > boardfiles actually define a meaningful GPIO line for
> > this, but hey, it is converted.
> >=20
> > Cc: Daniel Mack <daniel@zonque.org>
> > Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> > Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Reviewed-by: Daniel Mack <daniel@zonque.org>
>=20
> Can we probably merge this through Sebastian's tree? The chance for
> conflicts in this area is virtually non-existent.

Thanks, queued to power-supply's for-next branch via the following
immutable branch (which also contains the z2_battery change):

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

--stcxeqb4e42jxihr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl//bywACgkQ2O7X88g7
+ppiJQ/7BGXJlkRZJIFusujDkGeO61GyE6FAE0d9tag6dd6UkdhfAsXkAUP+5I2s
xTqLd9xtGta0Qmgq4Z2OV3PxGUm+p+sDZbSR0OPUbO2lpXIa37h1oZZXAi449iYC
mXSvV/XXzC4Tv3Gjgkd1+X20gFKqNbWvL397APqOJ0r610E/4cADECyWx4oIzEI8
DRFIlY5Ivj5y4x/+lEb0v7TxXiG94tt/cWAx8cXe/t9wUKs9+Zjb7RWFBxUIHWSU
CUIhU0Yw+F9oVeFI3Husrri7wj5IGOjhuPobhaCpwYrSsyWhx/jqsNZ3rt++pbHz
QTEdGH7RFpOHx0w5oVWBb6CB68obd601sR1n5EqBnmfolmcBCj3vNSyjCL6GbEpo
XEvUdSGuSar0DHuEcDy/SsIDX4cGoLwTLXT67YtrIYc+/EYSj56SbbnS2VKAiV32
ktDPokZRsVZSnDPQC/s/EGY7jH8TYNQVQHHwXDloFl5GZZWIEQ2IMGPYPtT6SVB/
70XHYY4FNjOBKCTvzzKPCKxTc6VV44CmsN7SU87k6HAh1bChywLjZ97ML61mjny9
Zty8AOkbw8pl6CNNlacCVyQvEckbcgYhPgrYAAfhz1X/jFVJUHiRPAXD/UjOMScC
3FbgdXEwCMbMQO/uGh2Yt9xf6l3aUGKY15OZmhKGeBotTUg9WSQ=
=/P1W
-----END PGP SIGNATURE-----

--stcxeqb4e42jxihr--
