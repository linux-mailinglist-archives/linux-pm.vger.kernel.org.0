Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2F61C1251
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 14:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbgEAMjZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 08:39:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60040 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgEAMjZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 08:39:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 007712A2E1D
Received: by earth.universe (Postfix, from userid 1000)
        id D91B73C08C7; Fri,  1 May 2020 14:39:21 +0200 (CEST)
Date:   Fri, 1 May 2020 14:39:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] power: supply: core: fix HWMON temperature
 labels
Message-ID: <20200501123921.k4vgng7ggcjoe6ux@earth.universe>
References: <cover.1585944770.git.mirq-linux@rere.qmqm.pl>
 <4c33741ba56d3c7830827c140bccf13621e59232.1585944770.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wm5ps46dek33h7p"
Content-Disposition: inline
In-Reply-To: <4c33741ba56d3c7830827c140bccf13621e59232.1585944770.git.mirq-linux@rere.qmqm.pl>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5wm5ps46dek33h7p
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 03, 2020 at 10:20:33PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> tempX_label files are swapped compared to what
> power_supply_hwmon_temp_to_property() uses. Make them match.
>=20
> Cc: stable@vger.kernel.org
> Fixes: e67d4dfc9ff1 ("power: supply: Add HWMON compatibility layer")
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
> v2: split parameter checking to separate patch
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/power_supply_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/su=
pply/power_supply_hwmon.c
> index 75cf861ba492..67b6ee60085e 100644
> --- a/drivers/power/supply/power_supply_hwmon.c
> +++ b/drivers/power/supply/power_supply_hwmon.c
> @@ -144,7 +144,7 @@ static int power_supply_hwmon_read_string(struct devi=
ce *dev,
>  					  u32 attr, int channel,
>  					  const char **str)
>  {
> -	*str =3D channel ? "temp" : "temp ambient";
> +	*str =3D channel ? "temp ambient" : "temp";
>  	return 0;
>  }
> =20
> --=20
> 2.20.1
>=20

--5wm5ps46dek33h7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6sGHkACgkQ2O7X88g7
+pofYg/8CYre6kxA2y2v+h3U9Em6zL/Y3RQ0ulhetV5MBKzguQjQJ6hMPl/gB+pF
/NeyPJ5ba3NDaUumtiQBfhGZ/3w3GEh0JTjd9ddOIFymYhKlh//zTHfWprxwnkmc
bcikO700CUG9YepsMODt19onA7WDjYVfzTcKprpQi9QN1+zWNZF2vh6KhJ8nysg8
tv1ctbPK3k5fm0YGDyEJnv/JVzvcRacA/LhG18RbE15HyFsUyMoXpGSChBK5bH6e
1rnao3RBzDKeV/W0JG2OKqMU+KPHPerSBHs8j0+k5+JGvF79ZVmBWaxTfYdyn956
a/3bu0ugd/FbbB6pgJcRqSuPY8rbb9pmhycyvlhJdyuijlqIcUUvyD0IXXAsEqyK
+HCPxAQp1dVfhs3mA2Q2aZIpM2M29aj4gMjv2fvo0dRwWXe7fH5EBdsxRiuAoF19
51Gek3OgD2vIWqcyrEc47L5jclPzsR9IpnZJN8N14B1FfiVq++W7TZeN91KuPm9b
9dIUnfoEoWAi1IIROsdwFECQ50d01Ql5WSF46l/x2YGNPmayY+DjCcJ8O4YzpYS2
8E5gdSxqGDvxaTz3aECmDuXkaqVdeyeKWJJL2hbyIB45trw9bkdDqTStNoxetHCZ
opBGn5DoOHP0YIT/avfHGsKxxArh9vFQso1c0k8wiZXEDlEpGvs=
=kCn8
-----END PGP SIGNATURE-----

--5wm5ps46dek33h7p--
