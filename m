Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FED1C2931
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 02:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgECAVG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 20:21:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44438 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgECAVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 20:21:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 583D52A0BBA
Received: by earth.universe (Postfix, from userid 1000)
        id B6DCE3C08C7; Sun,  3 May 2020 02:21:02 +0200 (CEST)
Date:   Sun, 3 May 2020 02:21:02 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     wu000273@umn.edu
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu
Subject: Re: [PATCH] power: supply: fix memory leaks (v2)
Message-ID: <20200503002102.jteq7y6rmef75qkb@earth.universe>
References: <20200502233338.9188-1-wu000273@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cswde2y6pcl7zblq"
Content-Disposition: inline
In-Reply-To: <20200502233338.9188-1-wu000273@umn.edu>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--cswde2y6pcl7zblq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 02, 2020 at 06:33:38PM -0500, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
>=20
> In function power_supply_add_hwmon_sysfs(), psyhw->props is
> allocated by bitmap_zalloc(). But this pointer is not deallocated
> when devm_add_action fail,  which lead to a memory leak bug. To fix
> this, we replace devm_add_action with devm_add_action_or_reset.
>=20
> v2:
>   - Prevent introducing double-free.
>   - Added fixes tag
>=20
> Fixes: e67d4dfc9ff19 ("power: supply: Add HWMON compatibility layer")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---

Thanks, queued to power-supply's for-next branch.
Notes for next time:

* I fixed up the subject, please read how to properly send a v2
* I removed the changelog, it should be below the ---

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index 75cf861ba492..7c8296ea0c34 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -304,7 +304,7 @@ int power_supply_add_hwmon_sysfs(struct power_supply =
*psy)
>  		goto error;
>  	}
> =20
> -	ret =3D devm_add_action(dev, power_supply_hwmon_bitmap_free,
> +	ret =3D devm_add_action_or_reset(dev, power_supply_hwmon_bitmap_free,
>  			      psyhw->props);
>  	if (ret)
>  		goto error;
> --=20
> 2.17.1
>=20

--cswde2y6pcl7zblq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6uDmkACgkQ2O7X88g7
+ppkHA//YWfS/dcQxDTdeLSxzvmfeQKZ8m2eQILk6sO2I9+KKiBsKC1qzPC3p+Mv
1CfKX6sxy8AxzuRVzl3znW/GV7NLXAliOTT9c8v7P5PEiVE6QXlbvzbkZeyvJoHx
fkwI3bV0P9dMp5IBYIijYt8TwR84+E6XKyFGhhsW2MbK6vPgseRO6VY20P6UffdI
R0U5iVu30rrXhAL98D1W4sttJ97of0woXqskXw2vLx6I4qLUA5AC2ojJ+zMjFiYh
N1QzP94p27/C6KC5DzJLW0/5jn9kyG4c61Tvcn0PMt8Eb0KaRZv33fasB7p6At3G
JHgDcqgdVhqz8RImlrEHqrsCLxrv+bRD7JaC+P/nZdHSIPPSi/5axBCga+CGM4Fy
oEZddy/naU8IziCWAmPsjVun69j9zkkpJvyG+GIY4H4j1P7P7vjJq6n20cyj3rxA
vba4DrebfrJMScAN2ErA90k6GagAuA48IUkCMurp2hVx/Sgx0SqW6IUcGi55iqVj
kHnvjr2+3B58Gp34z1udqle2rqjCFQfbwGDJ3UR44n3OVihcaPE6OFMsVWlRoluW
DDlpcLPDJ1yXqSrdSA1A/7FoFciAqFX6Z3AbcWqt1ifwqwsbjYJlUrTLLzb3Enua
zd34nWOJaCipUKrEnjfJqw0Riy7IZ3ySiuzptirkkQAjFrQENpE=
=EINy
-----END PGP SIGNATURE-----

--cswde2y6pcl7zblq--
