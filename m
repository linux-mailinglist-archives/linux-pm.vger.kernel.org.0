Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A14306883
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 01:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbhA1ASY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 27 Jan 2021 19:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhA1ARo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2021 19:17:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10439C061574
        for <linux-pm@vger.kernel.org>; Wed, 27 Jan 2021 16:17:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id CFC3A1F4560D
Received: by earth.universe (Postfix, from userid 1000)
        id 4FBFE3C0C97; Thu, 28 Jan 2021 01:17:00 +0100 (CET)
Date:   Thu, 28 Jan 2021 01:17:00 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Marcus Cooper <codekipper@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/10] power: supply: ab8500: refactor and isolate
Message-ID: <20210128001700.pkuyfpq6uzcjb5ud@earth.universe>
References: <20210123221908.2993388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mspejcb5fu33ajvu"
Content-Disposition: inline
In-Reply-To: <20210123221908.2993388-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--mspejcb5fu33ajvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jan 23, 2021 at 11:18:58PM +0100, Linus Walleij wrote:
> The AB8500 code was merged in 2012 and hasn't seen
> much love in the years since that, but the code is
> needed by the PostmarketOS community.
> commit a1149ae975547142f78e96745a994cb9b0e98fd2
> ("ARM: ux500: Disable Power Supply and Battery Management by default")
> disabled the use of the code in 2013 mentioning that
> "drivers are more than a little bit broken".
>=20
> Charging is nice. The platform is not unused. Let's
> begin to fix this.
>=20
> This patch set does a bunch of things to the AB8500
> charger code:
>=20
> - Cleans out non-devicetree code as we are now always
>   probing Ux500 and AB8500 from the device tree.
>=20
> - Breaks the ties to the MFD subsystem and pushes the
>   charging-related headers down to power/supply/*
>   these headers were shared in include/linux/mfd in
>   order to support board files, and with device tree
>   that is unnecessary.
>=20
> - Bind all subdrivers using the driver component
>   model which is common in the DRM subsystem, and as
>   a consequence we know the order the subdrivers are
>   initialized and we can cut the code that is just
>   there to satisfy the case where the drivers probe
>   in different order.
>=20
> - Add some minor code that makes the drivers actually
>   work (it was very close).
>=20
> Right now it has dependencies on the MFD tree (this
> series is based on thefor-mfd-next branch) due to a
> renaming of the cell macro so the best would be if Lee
> could merge it, at least partly. I am also fine if
> we only merge patches 1 thru 4 into MFD this merge
> window to isolate the charger code into drivers/power
> so we can continue next merge window with the rest
> of the code.

Patches 1-4 and 6-9 are

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

I think best solution would be to merge patches 1-4 using
an immutable branch based on v5.11-rc1 and Lee fixing the
trivial conflict when merging the immutable branch into
his tree. That way I can also merge it into the power-supply
tree and take the remaining patches (but I actually have
feedback/questions for patch 5 and 10).

-- Sebastian

> Linus Walleij (10):
>   power: supply: ab8500: Require device tree
>   power: supply: ab8500: Push data to power supply code
>   power: supply: ab8500: Push algorithm to power supply code
>   power: supply: ab8500: Push data to power supply code
>   power: supply: ab8500: Move to componentized binding
>   power: supply: ab8500: Call battery population once
>   power: supply: ab8500: Avoid NULL pointers
>   power: supply: ab8500: Enable USB and AC
>   power: supply: ab8500: Drop unused member
>   power: supply: ab8500_bmdata: Use standard phandle
>=20
>  drivers/mfd/ab8500-core.c                     |  17 +-
>  drivers/power/supply/Kconfig                  |   2 +-
>  .../power/supply}/ab8500-bm.h                 | 298 ++++++++++++-
>  .../power/supply/ab8500-chargalg.h            |   6 +-
>  drivers/power/supply/ab8500_bmdata.c          |   6 +-
>  drivers/power/supply/ab8500_btemp.c           | 162 +++----
>  drivers/power/supply/ab8500_charger.c         | 406 ++++++++++--------
>  drivers/power/supply/ab8500_fg.c              | 154 +++----
>  drivers/power/supply/abx500_chargalg.c        | 129 +++---
>  drivers/power/supply/pm2301_charger.c         |   4 +-
>  include/linux/mfd/abx500.h                    | 276 ------------
>  11 files changed, 720 insertions(+), 740 deletions(-)
>  rename {include/linux/mfd/abx500 =3D> drivers/power/supply}/ab8500-bm.h =
(58%)
>  rename include/linux/mfd/abx500/ux500_chargalg.h =3D> drivers/power/supp=
ly/ab8500-chargalg.h (93%)
>=20
> --=20
> 2.29.2
>=20

--mspejcb5fu33ajvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmASAnwACgkQ2O7X88g7
+pqqEg//Vc6lnORuzOVt0i63m9+CPZHT/uSRqsrZqKknHJmiFgBZTBiXXGT89uA+
XGWieq8b52srA+wj9Gmj12drEIQj0kn2IUE4HCv3irIHyFFR5O2BfFpZo6optW85
dDz2KeW/LNHulIHmNnfOZKj6Ib5CwMQqXqgUGAP+aSApIqJd+APAXcV1f7FNMEjw
xVby3GsDgreuOFV9ELAgeS3Z6eUNQ4gaHEumuwMLAoNml0Z1DPbJ+YGqIWtohdW1
A8N5WlZmda+Ram5MPruu7MCDbYX2d+TcqRAWpZbeMGWedni1u1gVrEwNEL9Bomi6
t9jZGuVopvvFkzkKPiIQkhXfwGiiKvapvHQI2LtJC3ww2UYRMuO+Q6Lo8yGCrmAZ
f7JE2BoWbc2QsE/UDWosf5ppqS1bS7QROZ4LKBs/LH7aCNasBFQmcBi5H2bzB+Zv
dATllV2yOTc13II9MuG8BQIq9ycUC0hz2Y2SLFePH9MsIkM7/8h/0kPve6idu0Yl
K0OOcaqrZQw5AhvJ91OXL+BIbsKclCF0xdJOmt7jwbQjzVQIKTuFWGbyCeUfHMrG
HHoYIaUTaGy6KWAvWVFJAy+P9dGGiZUaqBHAByVYnC9KnOK92/v1Ezw8aH7pSz0M
4bm9UGdXyuRrbH945zfwTsuz7bxjiu27k+K5UejMCDOVkYg6aC4=
=y147
-----END PGP SIGNATURE-----

--mspejcb5fu33ajvu--
