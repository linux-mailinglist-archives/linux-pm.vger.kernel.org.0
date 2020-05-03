Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3431C294F
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 03:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgECB1a (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 21:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726634AbgECB1a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 21:27:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA817C061A0C;
        Sat,  2 May 2020 18:27:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 855BD270E41
Received: by earth.universe (Postfix, from userid 1000)
        id A30E93C08C7; Sun,  3 May 2020 03:27:26 +0200 (CEST)
Date:   Sun, 3 May 2020 03:27:26 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Mathew King <mathewk@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/4] power_supply: Add power supply type property to
 uevent env
Message-ID: <20200503012726.yasulfcxbpb4pi6p@earth.universe>
References: <20200424173533.48572-1-mathewk@chromium.org>
 <20200424173533.48572-5-mathewk@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34bhwtylvcw7pcmv"
Content-Disposition: inline
In-Reply-To: <20200424173533.48572-5-mathewk@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--34bhwtylvcw7pcmv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 24, 2020 at 11:35:33AM -0600, Mathew King wrote:
> Add POWER_SUPPLY_TYPE to the uevent env for power supply. Type is a
> property of all power supplies and there is a sysfs entry for it but it
> is not included in the properties array of the power supply so
> explicitly add it to the udev env.
>=20
> Signed-off-by: Mathew King <mathewk@chromium.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/power/supply/power_supply_sysfs.c | 61 ++++++++++++++---------
>  1 file changed, 37 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/su=
pply/power_supply_sysfs.c
> index fbb05466b9a5..c7087cd7ffe3 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -448,6 +448,37 @@ void power_supply_destroy_attrs(void)
>  	}
>  }
> =20
> +static int add_prop_uevent(struct device *dev, struct kobj_uevent_env *e=
nv,
> +			   enum power_supply_property prop, char *prop_buf)
> +{
> +	int ret =3D 0;
> +	struct power_supply_attr *pwr_attr;
> +	struct device_attribute *dev_attr;
> +	char *line;
> +
> +	pwr_attr =3D &power_supply_attrs[prop];
> +	dev_attr =3D &pwr_attr->dev_attr;
> +
> +	ret =3D power_supply_show_property(dev, dev_attr, prop_buf);
> +	if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
> +		/*
> +		 * When a battery is absent, we expect -ENODEV. Don't abort;
> +		 * send the uevent with at least the the PRESENT=3D0 property
> +		 */
> +		return 0;
> +	}
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	line =3D strchr(prop_buf, '\n');
> +	if (line)
> +		*line =3D 0;
> +
> +	return add_uevent_var(env, "POWER_SUPPLY_%s=3D%s",
> +			      pwr_attr->upper_name, prop_buf);
> +}
> +
>  int power_supply_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct power_supply *psy =3D dev_get_drvdata(dev);
> @@ -467,31 +498,13 @@ int power_supply_uevent(struct device *dev, struct =
kobj_uevent_env *env)
>  	if (!prop_buf)
>  		return -ENOMEM;
> =20
> -	for (j =3D 0; j < psy->desc->num_properties; j++) {
> -		struct power_supply_attr *pwr_attr;
> -		struct device_attribute *dev_attr;
> -		char *line;
> -
> -		pwr_attr =3D &power_supply_attrs[psy->desc->properties[j]];
> -		dev_attr =3D &pwr_attr->dev_attr;
> -
> -		ret =3D power_supply_show_property(dev, dev_attr, prop_buf);
> -		if (ret =3D=3D -ENODEV || ret =3D=3D -ENODATA) {
> -			/* When a battery is absent, we expect -ENODEV. Don't abort;
> -			   send the uevent with at least the the PRESENT=3D0 property */
> -			ret =3D 0;
> -			continue;
> -		}
> -
> -		if (ret < 0)
> -			goto out;
> -
> -		line =3D strchr(prop_buf, '\n');
> -		if (line)
> -			*line =3D 0;
> +	ret =3D add_prop_uevent(dev, env, POWER_SUPPLY_PROP_TYPE, prop_buf);
> +	if (ret)
> +		goto out;
> =20
> -		ret =3D add_uevent_var(env, "POWER_SUPPLY_%s=3D%s",
> -				     pwr_attr->upper_name, prop_buf);
> +	for (j =3D 0; j < psy->desc->num_properties; j++) {
> +		ret =3D add_prop_uevent(dev, env, psy->desc->properties[j],
> +				      prop_buf);
>  		if (ret)
>  			goto out;
>  	}
> --=20
> 2.26.2.303.gf8c07b1a785-goog
>=20

--34bhwtylvcw7pcmv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6uHf4ACgkQ2O7X88g7
+pr3SRAAi4jcjj04wKsgplHkSGMsvzJP2flNguUVxdyvmPlS+azvWh38QRH+kkEX
BYVux0xEtNhtuMD62n6O+tiRo+7P91ptz6nYsmZDrGP0fk2SvKl6xOM6fqSib1QD
6hyXl85gy8pSGl0fOPxE2qZ1yWrdQ7r1U3CQGPOaCobWH5bBUPeQ1T6tXYVE6A0c
CIwncG6ra6no9HHCjZ1PMF3N3K5le2DInEkPWg5hwci49ICatdVkgQaFLTqT/G8w
kwaPM3CgNSZABGaOy4OLwK/NdyvK4LfxG+LYsNVRrtejx2a27caEkFoR/F2/vZxz
zN752BnnIVKc4nulyEOobjDYzk0jFXbJvUEl+NuQbCjGt4IgolF6rxLGRZA+LDOx
R91irYwtqD6m5KvDWF6BWGvbSpzbtdAPvf0OxSm+XT1yndpdly6pPyMYSouo0Gh4
LG+QXNgMllSFiFj00691dOD1vamNzZu6qJ/bDEnMGdfbxYTGmePz+gUM9HY4DWjd
ZEB+NKSbbkv584CVOelmJqf/YKdLOnInkr9N4Jbeie7CWNtOXL5Z0HmtrXe3OlHH
SERb/3hZZazt/7itN86/A914dzOi+11CWOwtospJ/5ojdRyM2yUA9BgKCE7uQuE5
A9L234P6BKv8wiUc1n5mtrpRysZFnp3K89SSgdjQz9MveH1TBzs=
=XI25
-----END PGP SIGNATURE-----

--34bhwtylvcw7pcmv--
