Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70741C2898
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 00:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgEBWjq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728550AbgEBWjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 18:39:46 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569CFC061A0C;
        Sat,  2 May 2020 15:39:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 14DEB2A05BC
Received: by earth.universe (Postfix, from userid 1000)
        id 771C93C08C7; Sun,  3 May 2020 00:39:42 +0200 (CEST)
Date:   Sun, 3 May 2020 00:39:42 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     wu000273@umn.edu
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] power: supply: fix memory leaks
Message-ID: <20200502223942.fksizdglrw5zdpw6@earth.universe>
References: <20200502211056.20975-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bfnyv6h55yl2uve7"
Content-Disposition: inline
In-Reply-To: <20200502211056.20975-1-wu000273@umn.edu>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--bfnyv6h55yl2uve7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 02, 2020 at 04:10:56PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
>=20
> In function power_supply_add_hwmon_sysfs(), psyhw->props is
> allocated by bitmap_zalloc(). But this pointer is not deallocated
> in several error paths, which lead to memory leak bugs. To fix
> this, we can call bitmap_free() to free this pointer.
>=20
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---

You are correct, that there is a problem in the first instance, but
the other changes are incorrect and introduce a new double free. Please
read documentation for devm_add_action(). The proper fix is to just
replace the call to devm_add_action() with devm_add_action_or_reset().
Please send a new version for this. Also please add the following
tag:

Fixes: e67d4dfc9ff19 ("power: supply: Add HWMON compatibility layer")

Thanks,

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index 75cf861ba492..7453390ab7a4 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -307,7 +307,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply =
*psy)
>  	ret =3D devm_add_action(dev, power_supply_hwmon_bitmap_free,
>  			      psyhw->props);
>  	if (ret)
> -		goto error;
> +		goto out_free;
> =20
>  	for (i =3D 0; i < desc->num_properties; i++) {
>  		const enum power_supply_property prop =3D desc->properties[i];
> @@ -342,7 +342,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply =
*psy)
>  		new_name =3D devm_kstrdup(dev, name, GFP_KERNEL);
>  		if (!new_name) {
>  			ret =3D -ENOMEM;
> -			goto error;
> +			goto out_free;
>  		}
>  		strreplace(new_name, '-', '_');
>  		name =3D new_name;
> @@ -353,10 +353,12 @@ int power_supply_add_hwmon_sysfs(struct power_suppl=
y *psy)
>  						NULL);
>  	ret =3D PTR_ERR_OR_ZERO(hwmon);
>  	if (ret)
> -		goto error;
> +		goto out_free;
> =20
>  	devres_close_group(dev, power_supply_add_hwmon_sysfs);
>  	return 0;
> +out_free:
> +	bitmap_free(psyhw->props);
>  error:
>  	devres_release_group(dev, NULL);
>  	return ret;
> --=20
> 2.17.1
>=20

--bfnyv6h55yl2uve7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6t9qYACgkQ2O7X88g7
+poW4Q/+MRp2UMwvH182vYfEZaPV4oUWAdkWo8EBzRsTvINvOBDvFx39aCip7JS+
xHj42Enw5U/JoZqLdJ7gFnXOfqHJAn5P74u2mY9ttGqS2uFKhVWdgtwOUIo14A/3
qywQuGep91TW+h8i3QoBDw9aBecbol/wOLR+6Mm3CfOlAn69yBxYB6FVmYqNbZMD
Tq2O/HK9gyaAnowz7vmmC09xRLoOufzeLlqxCH05VtjbRiawuYl+fpFIW/7VUsHj
molq0ltvvaU4fNonMcGeyQSqjcDx/Ri8O7IjblIq4lFRbewHoBaf1zSBtrPCCp2L
t4FSrXb85VAaDzF9mZz2ubBkSfpFffvz3M+4xkG7GJcaMU68MtPXjb2K2BkgSfOl
kDWqzGZkixNeKoaza3H6uf8QYWWDtOYzC1S+JaYGIcwusR/fiofKiBGRjshkWauH
3BYP2j8T3isIpfu0N4EQjkLMfx0gNlwccPz+TUJWAkOe3N/8tPL1usTPh9W/qHwb
Hs+2q4iv8JKiYb4MvATKtCAz8fDu5KlvYJjnHPLtkwSc/95PDDZBAw8yTp3Rp1uj
/B56K1HVa8Qx8j45G2hu2pZIjq60J2Qv0//qgWhFrZO4BY2h35HZNcfvuD4SszaE
I5FZgDREdbceGYGnWeh+NoAsUUYYayD4tISIpvFFO7sWWTrIamg=
=XGdH
-----END PGP SIGNATURE-----

--bfnyv6h55yl2uve7--
