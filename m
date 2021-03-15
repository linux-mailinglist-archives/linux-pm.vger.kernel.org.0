Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF233A971
	for <lists+linux-pm@lfdr.de>; Mon, 15 Mar 2021 02:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCOBys (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Mar 2021 21:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhCOByj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 14 Mar 2021 21:54:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 694E564E67;
        Mon, 15 Mar 2021 01:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615773279;
        bh=lXgcnPBVlamraWadB2YrJuA6DQw0vte++gFVcURPXbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjncW2uXz+eD1QSf5uKz3F3PKHK1WxWjMPMfVVBCBYVES0F7dbXs45BrEBCbEVaDm
         X7z1NupuUm0x5CjZDcs3llPElLrGUfHwYdpCrMusXgr4NAUmScgK92Aj+7sccLFFCU
         chnEyLM1ekNe1Ccuh5Szh0VhtkjZTKfLy/O0Bc3gV4ttGw+jN7CbWGlwaTK1EEDkvO
         hzHZ1l1cn0s0zytltGpGEY3eKYFb8JRmxfpj1aT7puQ3FwqQEaOnkPT5zo2Q2jaOo3
         iGyUrlYsMm08DTMxzjK/RlyFQzK3OQT0lFjWxh+D21z8YJSV6GS5FzZg2IvNXnEk7L
         ZJV9Qak4UHFRA==
Received: by earth.universe (Postfix, from userid 1000)
        id BC96A3C0C96; Mon, 15 Mar 2021 02:54:37 +0100 (CET)
Date:   Mon, 15 Mar 2021 02:54:37 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] power: supply: bq27xxx: fix sign of current_now
 for newer ICs
Message-ID: <20210315015437.auc4smemdbxb4qlm@earth.universe>
References: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iknjunzcwyyvba4y"
Content-Disposition: inline
In-Reply-To: <20210303095420.29054-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--iknjunzcwyyvba4y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 03, 2021 at 10:54:18AM +0100, Matthias Schiffer wrote:
> Commit cd060b4d0868 ("power: supply: bq27xxx: fix polarity of current_now=
")
> changed the sign of current_now for all bq27xxx variants, but on BQ28Z610
> I'm now seeing negated values *with* that patch.
>=20
> The GTA04/Openmoko device that was used for testing uses a BQ27000 or
> BQ27010 IC, so I assume only the BQ27XXX_O_ZERO code path was incorrect.
> Revert the behaviour for newer ICs.
>=20
> Fixes: cd060b4d0868 "power: supply: bq27xxx: fix polarity of current_now"
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---

Thanks, queued.

-- Sebastian

>=20
> v2: no changes
>=20
>  drivers/power/supply/bq27xxx_battery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 4c4a7b1c64c5..cb6ebd2f905e 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1827,7 +1827,7 @@ static int bq27xxx_battery_current(struct bq27xxx_d=
evice_info *di,
>  		val->intval =3D curr * BQ27XXX_CURRENT_CONSTANT / BQ27XXX_RS;
>  	} else {
>  		/* Other gauges return signed value */
> -		val->intval =3D -(int)((s16)curr) * 1000;
> +		val->intval =3D (int)((s16)curr) * 1000;
>  	}
> =20
>  	return 0;
> --=20
> 2.17.1
>=20

--iknjunzcwyyvba4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBOvlcACgkQ2O7X88g7
+pqqhA//RZ/DeLWE2E9PSJs0pMdGLDhMyVlsj06Pya2mJslVVS9+vZD4gEDcojww
7TAEbtsCOiDnEmnLkDy74wtSSAhS2DqHaR3wNXd8eRTT7pqG/7bfeZyaQsJIf27/
1E2QMpgZHtRXObtqFa1aa7JJtgwYSJ2OmKj9jXVL9NjtxPGMxsh3MeJaddQOF2BI
xw+jlxBhxwBvaWfZXbRGS03ZivzYKoYGRaqn/xYDrjxC961z7RPduKw6W4Wqs0Rl
LGx1t17NTL7o1W1OnVSENCi4z6KAoTfPO3ivSR87QW68K8eKNt6g66mPoz7a7BT8
yqYEPF0xdVaV7YASJzvfrEX5wNmX0bmsbNIy5azu1wpgi1TJGvNMhSdFnas6L9GA
KXGyYstfuVnzlKKDkFIurqZB4/tsRoN3bvqU80Is0uIEhgEV0451ZzHkCxVyYLfy
IYr1vbsCyxpPuHlfvpfOBfsNyCDFpmDEGqe9SKpqxz4cfRJf8B254zKwx+U6sUO9
zu3X58qpUVZHxNEUuvyFJliS+3LFggg5CqOrGFjnWqg2a9hHqJF+PLW1fbRktvva
5WPan1gsX7Hd0JBKkbB4ga/ulyp/au3arJMUaJ3Ma/dlLCyoVydOWt7aQcBainqW
4b8GvfJOBAIIkf1uibTfS+2HNbvmNyT11AQJ16K8KqPGp+ahwkg=
=IFpg
-----END PGP SIGNATURE-----

--iknjunzcwyyvba4y--
