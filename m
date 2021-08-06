Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986E13E311A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 23:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhHFV0O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 17:26:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52310 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240338AbhHFV0N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 6 Aug 2021 17:26:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 493D71F44DE2
Received: by earth.universe (Postfix, from userid 1000)
        id 5E3093C0C99; Fri,  6 Aug 2021 23:25:54 +0200 (CEST)
Date:   Fri, 6 Aug 2021 23:25:54 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: max17042_battery: Add support for
 MAX77849 Fuel-Gauge
Message-ID: <20210806212554.gpm7ozkn6nbc7oey@earth.universe>
References: <20210727170345.115004-1-nikita@trvn.ru>
 <20210727170345.115004-2-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zetbnkzlogb3f54i"
Content-Disposition: inline
In-Reply-To: <20210727170345.115004-2-nikita@trvn.ru>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zetbnkzlogb3f54i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 27, 2021 at 10:03:45PM +0500, Nikita Travkin wrote:
> MAX77849 is a combined fuel-gauge, charger and MUIC IC. Notably,
> fuel-gauge has dedicated i2c lines and seems to be fully compatible
> with max17047. Add new compatible for it reusing max17047 code paths.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17042_battery.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index ce2041b30a06..f28c90ea41b4 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1196,6 +1196,7 @@ static const struct of_device_id max17042_dt_match[=
] =3D {
>  	{ .compatible =3D "maxim,max17047" },
>  	{ .compatible =3D "maxim,max17050" },
>  	{ .compatible =3D "maxim,max17055" },
> +	{ .compatible =3D "maxim,max77849-battery" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, max17042_dt_match);
> @@ -1206,6 +1207,7 @@ static const struct i2c_device_id max17042_id[] =3D=
 {
>  	{ "max17047", MAXIM_DEVICE_TYPE_MAX17047 },
>  	{ "max17050", MAXIM_DEVICE_TYPE_MAX17050 },
>  	{ "max17055", MAXIM_DEVICE_TYPE_MAX17055 },
> +	{ "max77849-battery", MAXIM_DEVICE_TYPE_MAX17047 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, max17042_id);
> --=20
> 2.30.2
>=20

--zetbnkzlogb3f54i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmENqOIACgkQ2O7X88g7
+pp19BAApIkuniJkn4z8m+Uer5ajFKZ1FGTSwq3ymbDmYZf8HqiQB6+TQ4N1EPhx
0ol/TY9Q6JlYrkL6It7+ll+ir5Ca95nh151E7BxwcTMwZbsrmWF319Xaxu+pFjwK
ewdhbkhtFBtvQyX0lLJ/MN3PQVkI4BbQSGGnTV2AZ+9PrImWnPIYVoyYLtP7ACPL
Boy11+u8IeX+ULmLDxFXQfcYFb7hKq5k931OScJrsiE/+nDSu96YyrdxokWqxyux
AZtF+IK5Ax5b3FSYlhCFFQCbkY4Amt5LU+EglC1PHNxV6R/QFmsF1/3BgHLEzNv2
cQKuXYeTsds2JsZNfcqksB1HVazEVp7JxHXEB7k6u9VxhkM1/wZCla9tN/e1rgAp
g3P5pqEMm5lLtV9l2AHu7qSckqKJnd0heGK93VdUhxAWAxIBCrVZnZLEmaHSricm
UcYkeoWqlQ9sXrMln+hsCnB/AQNKeutRJN4/GtFlI1EpNXjlzCyfGVfW/E/M3+El
i6//93k6qrbW7ZFSqt/rgPxlawby2fEQlcg4nAKEWH0PbL/zYn++G0a+L25iOX/h
qVQs/bxVt8Neeh/QdW1H9kDNPwIPKs5qJUH7Cte7IP36VgW7HFLf7ViAIzQSkjxI
FtSzXMewryoiP6B9nwMIYveXSxwWEVxH41Jf29dSo1Ljk+wmQpQ=
=aATW
-----END PGP SIGNATURE-----

--zetbnkzlogb3f54i--
