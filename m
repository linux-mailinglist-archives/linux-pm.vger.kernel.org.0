Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974994196AF
	for <lists+linux-pm@lfdr.de>; Mon, 27 Sep 2021 16:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbhI0OuJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Sep 2021 10:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234841AbhI0OuJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 27 Sep 2021 10:50:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9534FC061575;
        Mon, 27 Sep 2021 07:48:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 6B9E11F4217C
Received: by earth.universe (Postfix, from userid 1000)
        id 7486F3C0CA8; Mon, 27 Sep 2021 16:48:21 +0200 (CEST)
Date:   Mon, 27 Sep 2021 16:48:21 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: core: Add psy_has_property()
Message-ID: <20210927144821.c6rzox4xyqkanzgz@earth.universe>
References: <20210901165911.1.I61edd8453dd683a125623b4173988b438033c0af@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zyyrfqid4cwaocss"
Content-Disposition: inline
In-Reply-To: <20210901165911.1.I61edd8453dd683a125623b4173988b438033c0af@changeid>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--zyyrfqid4cwaocss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 01, 2021 at 04:59:36PM -0700, Matthias Kaehlcke wrote:
> Add the helper psy_has_property() to check whether a power supply
> has a given property and use it instead of ad hoc iterations over
> the property list in multiple locations.
>=20
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Thanks, queued.

-- Sebastian

>=20
>  drivers/power/supply/power_supply_core.c | 65 ++++++++++++++----------
>  1 file changed, 37 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index d99e2f11c183..9309b33ed3ec 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -956,26 +956,41 @@ static struct thermal_zone_device_ops psy_tzd_ops =
=3D {
>  	.get_temp =3D power_supply_read_temp,
>  };
> =20
> +static bool psy_has_property(const struct power_supply_desc *psy_desc,
> +			     enum power_supply_property psp)
> +{
> +	bool found =3D false;
> +	int i;
> +
> +	for (i =3D 0; i < psy_desc->num_properties; i++) {
> +		if (psy_desc->properties[i] =3D=3D psp) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	return found;
> +}
> +
>  static int psy_register_thermal(struct power_supply *psy)
>  {
> -	int i, ret;
> +	int ret;
> =20
>  	if (psy->desc->no_thermal)
>  		return 0;
> =20
>  	/* Register battery zone device psy reports temperature */
> -	for (i =3D 0; i < psy->desc->num_properties; i++) {
> -		if (psy->desc->properties[i] =3D=3D POWER_SUPPLY_PROP_TEMP) {
> -			psy->tzd =3D thermal_zone_device_register(psy->desc->name,
> -					0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
> -			if (IS_ERR(psy->tzd))
> -				return PTR_ERR(psy->tzd);
> -			ret =3D thermal_zone_device_enable(psy->tzd);
> -			if (ret)
> -				thermal_zone_device_unregister(psy->tzd);
> -			return ret;
> -		}
> +	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> +		psy->tzd =3D thermal_zone_device_register(psy->desc->name,
> +				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
> +		if (IS_ERR(psy->tzd))
> +			return PTR_ERR(psy->tzd);
> +		ret =3D thermal_zone_device_enable(psy->tzd);
> +		if (ret)
> +			thermal_zone_device_unregister(psy->tzd);
> +		return ret;
>  	}
> +
>  	return 0;
>  }
> =20
> @@ -1046,18 +1061,14 @@ static const struct thermal_cooling_device_ops ps=
y_tcd_ops =3D {
> =20
>  static int psy_register_cooler(struct power_supply *psy)
>  {
> -	int i;
> -
>  	/* Register for cooling device if psy can control charging */
> -	for (i =3D 0; i < psy->desc->num_properties; i++) {
> -		if (psy->desc->properties[i] =3D=3D
> -				POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT) {
> -			psy->tcd =3D thermal_cooling_device_register(
> -							(char *)psy->desc->name,
> -							psy, &psy_tcd_ops);
> -			return PTR_ERR_OR_ZERO(psy->tcd);
> -		}
> +	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_CHARGE_CONTROL_LIMIT)=
) {
> +		psy->tcd =3D thermal_cooling_device_register(
> +			(char *)psy->desc->name,
> +			psy, &psy_tcd_ops);
> +		return PTR_ERR_OR_ZERO(psy->tcd);
>  	}
> +
>  	return 0;
>  }
> =20
> @@ -1095,7 +1106,7 @@ __power_supply_register(struct device *parent,
>  {
>  	struct device *dev;
>  	struct power_supply *psy;
> -	int i, rc;
> +	int rc;
> =20
>  	if (!parent)
>  		pr_warn("%s: Expected proper parent device for '%s'\n",
> @@ -1104,11 +1115,9 @@ __power_supply_register(struct device *parent,
>  	if (!desc || !desc->name || !desc->properties || !desc->num_properties)
>  		return ERR_PTR(-EINVAL);
> =20
> -	for (i =3D 0; i < desc->num_properties; ++i) {
> -		if ((desc->properties[i] =3D=3D POWER_SUPPLY_PROP_USB_TYPE) &&
> -		    (!desc->usb_types || !desc->num_usb_types))
> -			return ERR_PTR(-EINVAL);
> -	}
> +	if (psy_has_property(desc, POWER_SUPPLY_PROP_USB_TYPE) &&
> +	    (!desc->usb_types || !desc->num_usb_types))
> +		return ERR_PTR(-EINVAL);
> =20
>  	psy =3D kzalloc(sizeof(*psy), GFP_KERNEL);
>  	if (!psy)
> --=20
> 2.33.0.153.gba50c8fa24-goog
>=20

--zyyrfqid4cwaocss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFR2aoACgkQ2O7X88g7
+ponLA/+JXJ4PqLNhqnhntei5N/CLciDWDkzpPZqzpEaGGSgXQYSs1NGHV37LhN+
I0NJzGyQXaSFyLYpVCvhNaf1PYcivM25Qr9rhzp2LlvppdlAij33vaJjna/NmI3c
9QBoLIqXCx7MgIFjsGLB/mozQoJ0z3UbREiioMvtqRiPB8sdCHEFF4yOTjalF4G1
anFEtwfxaO2iAzFxvquLFCjvMSvVRZ6dqqoN+6xdPkd7nSPcSu8EmYEH5kn9AbvT
6gKZaOI7LSEuKp+5eNkc8Ogq+xFA7dzVr+TG8GhGb1hvQxyto3YUKYfJG9REhM2M
4JL150rhpI6TWTZX/EqvypX94nlz6raVx/lifwc7daKLUC6hb9fg324D85cfsWj6
fCH6IsUyA6lcuIg4VklfHEPEBrcE1DiBlSWA3kisV2cwsEiPjVOnS9W46z56TvAg
IkZsPedg4uGRN66oY9WUXsIt5sQFfk2IARd+/siwnuCXVW2wF+SJXDppB9fSEKc7
+CLCvN0lUd29B19fVuuTahQkM8SivoZQqBXPqremXiPFlbGoZk8t2QUDyVPWnDGd
jB+6JkvIVxzgKWnqrrTHwEVxO7GTFjvtUnDX7rw5DbIL+sPHOk+4bzBB2jp9q6xW
iaVXD1PxjHlV94VHfH56hMiJBe8Bx9XPOB9MIG/u3wAdMMub9fk=
=Qt/f
-----END PGP SIGNATURE-----

--zyyrfqid4cwaocss--
