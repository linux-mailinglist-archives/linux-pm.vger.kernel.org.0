Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5C45613B
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 18:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhKRRRc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 12:17:32 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36608 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhKRRR2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 12:17:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E7E5C1F46E66
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637255666; bh=GV4js5wvz93JaAd0Spnw6nGkjNzbg2gH5Cu1CDxYO7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTk8u8mlJe/t1F0oNNhbK19WN6Lbil0tf3F3FxtdTXfSbDxo4QWiqok7Elk8OyNWF
         BnHeOHJnQtQKVPHrDFM7G/m2hiBtfMZExYlkUrPowYNLpsL7xznKB1nN1q8K5TuynQ
         Mvzy+gLvCgiVuyyC97UFxNbrdLa3ad96WVAA+Veb8mTudkExieADLHBvPVzVj8eJ7N
         +UpNfKy+z82jyMGyQChIBTmoJgcUBpnScpZanMpF5sSM1IcA7zViK9zzihzJJNA0ud
         d0UjDUD04ZZa3D1T7QlCb0zjENyToZ+YKpWAAjbL8N4R72sPET06yomSp/tLl6EuUN
         6acb3xZEV8VJg==
Received: by earth.universe (Postfix, from userid 1000)
        id A21A93C0F9E; Thu, 18 Nov 2021 18:14:23 +0100 (CET)
Date:   Thu, 18 Nov 2021 18:14:23 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/16] AB8500 charger to use power_supply_battery_info
Message-ID: <20211118171423.no4ou32k2cnnj55a@earth.universe>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qg3ns7sd5qfx252i"
Content-Disposition: inline
In-Reply-To: <20211118021752.2262818-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qg3ns7sd5qfx252i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 18, 2021 at 03:17:36AM +0100, Linus Walleij wrote:
> This is the first set of patches starting to migrate the
> AB8500 charging code to use the struct power_supply_battery_info.
> We drop some cruft along the road.
>=20
> This series does not add anything to the struct, just reuse
> what is already there. Adding new stuff comes in the next
> patch series.
>=20
> The AB8500 charging code has not been in working condition for
> some time, but it is slowly getting there. Some of this is
> just regular maintenance.
>=20
> Linus Walleij (16):
>   power: supply: ab8500: Use core battery parser
>   power: supply: ab8500: Sink current tables into charger code
>   power: supply: ab8500: Standardize operating temperature
>   power: supply: ab8500: Drop unused battery types
>   power: supply: ab8500: Use only one battery type
>   power: supply: ab8500: Standardize design capacity
>   power: supply: ab8500: Standardize technology
>   power: supply: ab8500: Standardize voltages
>   power: supply: ab8500_fg: Init battery data in bind()
>   power: supply: ab8500: Standardize internal resistance
>   power: supply: ab8500: Standardize termination current
>   power: supply: ab8500: Make recharge capacity a constant
>   power: supply: ab8500: Standardize CC current
>   power: supply: ab8500: Standardize CV voltage
>   power: supply: ab8500: Standardize temp res lookup
>   power: supply: ab8500: Standardize capacity lookup
>=20
>  drivers/power/supply/ab8500-bm.h       | 121 +-----
>  drivers/power/supply/ab8500-chargalg.h |   8 +-
>  drivers/power/supply/ab8500_bmdata.c   | 566 ++++++-------------------
>  drivers/power/supply/ab8500_btemp.c    |  61 ++-
>  drivers/power/supply/ab8500_chargalg.c | 315 +++++++-------
>  drivers/power/supply/ab8500_charger.c  | 536 ++++++++++++-----------
>  drivers/power/supply/ab8500_fg.c       | 371 ++++++++--------
>  7 files changed, 796 insertions(+), 1182 deletions(-)

Apart from my comments to patch 1 (which also affects patch 3 due to
the moved scope of the battery info data) the series looks good to me.

-- Sebastian

--qg3ns7sd5qfx252i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGWiekACgkQ2O7X88g7
+pp8Zg/+OsS/+x+Myno8fdkFstUvgKC2chkt5p1KZhHFmuZvNKjm+LeISiI9I5DS
NMIWtSGRhShMwmY/i5mGJExPalde3bkLwkdupXCFsAU0XawSbdDTgkY52wEjS3IA
WV95nBVWwoNUHIOmrYgHAo0UKFskpE+drOXIvT3vvq2asmEaJRqGr0S3LyLL3Frs
BnZg4j/OaMfkDoCXc2ZMTd0rROJA9wT/D1LVFb6NKXS73pHH9AJugjTvXP+iIjM8
/S/xGQyd3ef6e7oUveVIY3NdKvVnr0s3kXZ/gMWY/864ftxrORZeGBkdWv4RaHn5
daY9bPaKTHkB7aXsNz8TSqSKWoZ7S/08bALaRHOOPimWV0YgG/J0LixAusl4z+Ol
bv3Ijp+5ENM0uvtg2U9kgIFwzIq9pKnORIuhD19ogmNigPL5l5pjyhNs7+ax6zpv
WJR+MSYN42xnQUMF9NxU+DQ77pPF88qLkRuB25mv2rU+gTE0srXPHL2Sthtn2Mg+
yZKX+E6gusETjuyDOz6X9BcuigGRXs+Lxrk8+AX7flKU550Ppy0XTXedQPkFUPty
/0R4kLaBKYz14mKWaYebiXlX3htwO6TTmLQ0i+Bg++qVAlHTXqevkWLPKmlVZAZk
4eXksunN+qhn8Xu4utDzbH8Q4FVJ5MByEOFoLfNXeYl5NXaES5Q=
=yvDo
-----END PGP SIGNATURE-----

--qg3ns7sd5qfx252i--
