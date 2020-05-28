Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE7C1E6803
	for <lists+linux-pm@lfdr.de>; Thu, 28 May 2020 19:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405306AbgE1RCk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 May 2020 13:02:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56354 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405222AbgE1RCf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 May 2020 13:02:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9CD2E2A06B2
Received: by earth.universe (Postfix, from userid 1000)
        id 060CD3C08C7; Thu, 28 May 2020 19:02:31 +0200 (CEST)
Date:   Thu, 28 May 2020 19:02:30 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] power: supply: max17040: Set rcomp value
Message-ID: <20200528170230.62c7jvmyjkhpoykj@earth.universe>
References: <20200504221300.3153-1-xc-racer2@live.ca>
 <BN6PR04MB066057B881DEFC0C48208589A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nqhtmfaqtt3aelfj"
Content-Disposition: inline
In-Reply-To: <BN6PR04MB066057B881DEFC0C48208589A3A60@BN6PR04MB0660.namprd04.prod.outlook.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--nqhtmfaqtt3aelfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

This patch does not even compile, how did you test it?

-- Sebastian

On Mon, May 04, 2020 at 03:13:00PM -0700, Jonathan Bakker wrote:
> According to the datasheet (1), the rcomp parameter can
> vary based on the typical operating temperature and the
> battery chemistry.  If provided, make sure we set it after
> we reset the chip on boot.
>=20
> 1) https://datasheets.maximintegrated.com/en/ds/MAX17040-MAX17041.pdf
>=20
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> ---
>  drivers/power/supply/max17040_battery.c | 33 +++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 48aa44665e2f..f66e2fdc0a8a 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -10,6 +10,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/mutex.h>
> +#include <linux/property.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> @@ -31,6 +32,8 @@
> =20
>  #define MAX17040_ATHD_MASK		0xFFC0
>  #define MAX17040_ATHD_DEFAULT_POWER_UP	4
> +#define MAX17040_RCOMP_MASK		0xFF
> +#define MAX17040_RCOMP_DEFAULT_POWER_UP	0x97
> =20
>  struct max17040_chip {
>  	struct i2c_client		*client;
> @@ -48,6 +51,8 @@ struct max17040_chip {
>  	int status;
>  	/* Low alert threshold from 32% to 1% of the State of Charge */
>  	u32 low_soc_alert;
> +	/* Optimization for specific chemistries */
> +	u8 rcomp_value;
>  };
> =20
>  static int max17040_get_property(struct power_supply *psy,
> @@ -119,6 +124,20 @@ static int max17040_set_low_soc_alert(struct i2c_cli=
ent *client, u32 level)
>  	return ret;
>  }
> =20
> +static int max17040_set_rcomp(struct i2c_client *client, u32 val)
> +{
> +	int ret;
> +	u16 data;
> +
> +	data =3D max17040_read_reg(client, MAX17040_RCOMP);
> +	/* clear the rcomp val and set MSb 8 bits */
> +	data &=3D MAX17040_RCOMP_MASK;
> +	data |=3D val << 8;
> +	ret =3D max17040_write_reg(client, MAX17040_RCOMP, data);
> +
> +	return ret;
> +}
> +
>  static void max17040_get_vcell(struct i2c_client *client)
>  {
>  	struct max17040_chip *chip =3D i2c_get_clientdata(client);
> @@ -190,8 +209,14 @@ static int max17040_get_of_data(struct max17040_chip=
 *chip)
>  				 "maxim,alert-low-soc-level",
>  				 &chip->low_soc_alert);
> =20
> -	if (chip->low_soc_alert <=3D 0 || chip->low_soc_alert >=3D 33)
> +	if (chip->low_soc_alert <=3D 0 || chip->low_soc_alert >=3D 33) {
> +		dev_err(&client->dev,
> +			"failed: low SOC alert OF data out of bounds\n");
>  		return -EINVAL;
> +	}
> +
> +	chip->rcomp_value =3D MAX17040_RCOMP_DEFAULT_POWER_UP;
> +	device_property_read_u8(dev, "maxim,rcomp-value", &chip->rcomp_value);
> =20
>  	return 0;
>  }
> @@ -289,11 +314,8 @@ static int max17040_probe(struct i2c_client *client,
>  	chip->client =3D client;
>  	chip->pdata =3D client->dev.platform_data;
>  	ret =3D max17040_get_of_data(chip);
> -	if (ret) {
> -		dev_err(&client->dev,
> -			"failed: low SOC alert OF data out of bounds\n");
> +	if (ret)
>  		return ret;
> -	}
> =20
>  	i2c_set_clientdata(client, chip);
>  	psy_cfg.drv_data =3D chip;
> @@ -307,6 +329,7 @@ static int max17040_probe(struct i2c_client *client,
> =20
>  	max17040_reset(client);
>  	max17040_get_version(client);
> +	max17040_set_rcomp(client, chip->rcomp_value);
> =20
>  	/* check interrupt */
>  	if (client->irq && of_device_is_compatible(client->dev.of_node,
> --=20
> 2.20.1
>=20

--nqhtmfaqtt3aelfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl7P7p0ACgkQ2O7X88g7
+polOw//TbWDyeYt0SVYsvSufjbPELbiro/Mh8PC1zxE5Tr8iAWeqHvmaDk9O1/C
Hs5NsP7aWv52eE3nq+NlJPyQfpWMEtkBAC14hk8SEYMpgpvKY3pJb4/Q8tu17em9
hvk26fCX3mYpUgjLcKHwGN36gIdevpDBOgjDtNFKxKepspRWYVHqu4DRWavjeatA
sYtxO6xtG+aHmwnxSLTfvSjrvFpEZvfWJHQbPJNiMoFo9EuUcOyC8B6gliAbvMOa
bNh6NyyMoHZbnrhCAq0JbMj4hLop4Mn7CuXMToVHQvz3vrSOx5AEkfGFOitn50S1
ZudrRBqokCwp2wn6NRkqQ6IIE08uAF5zCIAyldWIC5zDfYnoU5K+i2aWk/4IbSUo
uP8ur9MTZlT3lDaOPvE253givUmEWtM80LjY9ZPkhggDS1EXwlLdjbCFofI1zKIh
HPKm+6wGAvyhJ4OrsHbNnacGhbz7nZKi+RGTVh6ncFBq2rqttRK0b5r3BWIIncEO
VZnlNUpMFg5htTMo2nHx3jitNtjVMYp81ZQsJVU107BOwxc2FpGCOsImtI3VNL4w
rlWWKgF0rocDC2BuQ+aMTkxDM+HBYsHPp5DIdVo1TPgOvfrFeDTXsIUL8WtBZfUT
5chE6+Pufz/MP16YOfMA5YKdCEObvtEmpwDBN2aDtSy09qSSsk0=
=kop8
-----END PGP SIGNATURE-----

--nqhtmfaqtt3aelfj--
