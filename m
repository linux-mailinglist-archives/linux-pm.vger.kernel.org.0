Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECB72D8AB3
	for <lists+linux-pm@lfdr.de>; Sun, 13 Dec 2020 01:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgLMAFV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 12 Dec 2020 19:05:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:38266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbgLMAFV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Dec 2020 19:05:21 -0500
Date:   Sun, 13 Dec 2020 01:04:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607817880;
        bh=XyYC08d8VreFz0iZIfxjdgW3Ja0+ozXIt8da6M+Ioas=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1BOWp9qYB2geORSiLGJF2aK7dDSADSCOkPMJa6vmR26ss8cw5pIoeC9tHlAaFqes
         vVVrUiJsNzKwTN1nNzgyoKDpeIn7eb/+DbY78gzGXTNsEGvKk9ja6sVG+IlM7NISIV
         t9Lj3xNobdUdEISP5R3+3OZzkFUQnMRmP6pFEBmwwIiGHtTL3qmxAybmecgQ7oFdXw
         xd2Bm6kO4M0jnq7sCDcxV1jT0lu5CV1/2xoEHzsGXrOscZYxfaI0i+Hi2ak4BREH/d
         BR2gYMSV0xucPvT/mUaY7nk1Bn83fa5KTpI3gbp07bDFOnwrtDBQ9WaODxpWs5N3Xr
         We5OfydqYKX9A==
From:   Sebastian Reichel <sre@kernel.org>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: supply: Fix a typo in warning message
Message-ID: <20201213000438.2gubioh2rqcxerei@earth.universe>
References: <20201205012532.1196962-1-standby24x7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j35co2bppgb3rqv2"
Content-Disposition: inline
In-Reply-To: <20201205012532.1196962-1-standby24x7@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--j35co2bppgb3rqv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Dec 05, 2020 at 10:25:32AM +0900, Masanari Iida wrote:
> This patch fix a warning messages in power_supply_sysfs.c
>=20
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index a616b9d8f43c..92dd63171193 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -402,7 +402,7 @@ void power_supply_init_attrs(struct device_type *dev_=
type)
>  		struct device_attribute *attr;
> =20
>  		if (!power_supply_attrs[i].prop_name) {
> -			pr_warn("%s: Property %d skipped because is is missing from power_sup=
ply_attrs\n",
> +			pr_warn("%s: Property %d skipped because it is missing from power_sup=
ply_attrs\n",
>  				__func__, i);
>  			sprintf(power_supply_attrs[i].attr_name, "_err_%d", i);
>  		} else {
> --=20
> 2.25.0
>=20

--j35co2bppgb3rqv2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/VWpEACgkQ2O7X88g7
+pqLuA//U9MSYJWLieSFnBiCVSMlhtZpH7QjeubbvwqUeOV5kmYbaMzwHVRUw7P0
qg2ALirxaEbStY0GFtWTSdQj2v+MEuCQLXHMLn/pJ32KU/8r+CJnWox7T5fGnHqZ
p64/lS5xrV1IdvMl4LPqgQrNOGGsiWm58XkAxbNpFirFVSc57vCNQKXC3gf14HPy
0RI0n2L5ZXMqljd3GhkYuUg0QuInWp1BRkpqaFQ+l+xT1Hu9QzQ/vN6XjLxb4r4K
0EjTm8+Rl4I6rcmdZtDOTFQs6qk88eaZ8jBqGSIx8lSF5Fjdma7frNxzEmY8lKPH
Py6Hadt/6pJ4wfakCunAH6zq1XS8sBaNxdzaQevWJXz3r306mWX6dzXWNEgC7AAF
sdAGvOtOvweAKwNQcSi8OB0yQwf4FNFedCiVj0GvgesbZ2dsk2asCylrVrQ6MWsh
pNjwCZBunkPeGqNhJnl/3i9FjybdLqk2EoTE/nJtZMPIsAJY+nCN6oOsEY4P6iEj
VAygV3exywcnctWZFwe717OXp9aGR+H3VIoQwO7U1LkPQUNh+1yiuzF1cEd9zTky
8DgLfmt98b/SsObyAoGpevbuO2FlafpV74uUn4N//P1HaTxL6VhcxV0JweCVEvl4
iUd68HPr2Or0eGetDVZbI2sb4XzW5kmqEynXUvavyVnboloMg0o=
=9700
-----END PGP SIGNATURE-----

--j35co2bppgb3rqv2--
