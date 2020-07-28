Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABD122FE6A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jul 2020 02:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgG1ASL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 27 Jul 2020 20:18:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:49342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgG1ASK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 27 Jul 2020 20:18:10 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4189020786;
        Tue, 28 Jul 2020 00:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595895489;
        bh=wWr2t+myCz/OZLXxwsQOJSX9Lblh8zNQcneKG8XmBR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rtGWh2cbv6sHXFH7lMi8Ke5ENZAG2MDClKJhz029nioffMK3RxaZj6CpDcNJOkUMe
         wBF0FR54wPfAnBYx34anG0/CNSO7x4VNbf74TG44Kr8AiNsprdNc6IL4WJAHa3dazh
         We6B8GwdI7WEuCRJLTpCJyueb61QSAKXknhBPw0A=
Received: by earth.universe (Postfix, from userid 1000)
        id 7CBFD3C0B87; Tue, 28 Jul 2020 02:18:07 +0200 (CEST)
Date:   Tue, 28 Jul 2020 02:18:07 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v1] power: supply: max17040: Add
 POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN
Message-ID: <20200728001807.zjyfgz2sphcysgx5@earth.universe>
References: <20200706001003.663763-1-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vnx7d7i7pnisscty"
Content-Disposition: inline
In-Reply-To: <20200706001003.663763-1-matheus@castello.eng.br>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--vnx7d7i7pnisscty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 05, 2020 at 09:10:03PM -0300, Matheus Castello wrote:
> Adds the property POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN to export the
> chip->low_soc_alert and add the property as writeable, implementing
> max17040_prop_writeable and max17040_set_property, so with that the
> user space can readjust the alerts.
>=20
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/max17040_battery.c | 51 ++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supp=
ly/max17040_battery.c
> index 48aa44665e2f..6cb31b9a958d 100644
> --- a/drivers/power/supply/max17040_battery.c
> +++ b/drivers/power/supply/max17040_battery.c
> @@ -69,6 +69,9 @@ static int max17040_get_property(struct power_supply *p=
sy,
>  	case POWER_SUPPLY_PROP_CAPACITY:
>  		val->intval =3D chip->soc;
>  		break;
> +	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
> +		val->intval =3D chip->low_soc_alert;
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -256,19 +259,57 @@ static int max17040_enable_alert_irq(struct max1704=
0_chip *chip)
>  	return ret;
>  }
>=20
> +static int max17040_prop_writeable(struct power_supply *psy,
> +				   enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
> +		return 1;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int max17040_set_property(struct power_supply *psy,
> +			    enum power_supply_property psp,
> +			    const union power_supply_propval *val)
> +{
> +	struct max17040_chip *chip =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN:
> +		/* alert threshold can be programmed from 1% up to 32% */
> +		if ((val->intval < 1) || (val->intval > 32)) {
> +			ret =3D -EINVAL;
> +			break;
> +		}
> +		ret =3D max17040_set_low_soc_alert(chip->client, val->intval);
> +		chip->low_soc_alert =3D val->intval;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
>  static enum power_supply_property max17040_battery_props[] =3D {
>  	POWER_SUPPLY_PROP_STATUS,
>  	POWER_SUPPLY_PROP_ONLINE,
>  	POWER_SUPPLY_PROP_VOLTAGE_NOW,
>  	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CAPACITY_ALERT_MIN,
>  };
>=20
>  static const struct power_supply_desc max17040_battery_desc =3D {
> -	.name		=3D "battery",
> -	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> -	.get_property	=3D max17040_get_property,
> -	.properties	=3D max17040_battery_props,
> -	.num_properties	=3D ARRAY_SIZE(max17040_battery_props),
> +	.name			=3D "battery",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property		=3D max17040_get_property,
> +	.set_property		=3D max17040_set_property,
> +	.property_is_writeable  =3D max17040_prop_writeable,
> +	.properties		=3D max17040_battery_props,
> +	.num_properties		=3D ARRAY_SIZE(max17040_battery_props),
>  };
>=20
>  static int max17040_probe(struct i2c_client *client,
> --
> 2.27.0
>=20

--vnx7d7i7pnisscty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl8fbr8ACgkQ2O7X88g7
+prB2w//XmjG/PbpXEnkEr9h9fHUQ3Str1QbxDFn+3JPh9W9G4RT+4caMAVS240t
NdIOpfZP7ZvpyPksHP5FHavBxTTgtz+jhly38PZajKSMH20kdIqSeRH2wOscn+dI
9LlXMX3Q417sC6+CvFprwrjZ4yWjMn8XBsnzvQtjzESuYhfHJrM8N0HpiaHrnWIl
lmQYfSWTQ0Z94ikPP5COG074Ahhc+Mw8az/kE+QnGT/ToXVlv4VG3mLYJggaNeSN
/BdywhelGennvrgwPWU6nzZ21HU+OBhYnKDxq6opXgbNhaCHA8dqSERIbl/AP4+R
+4g3ODrD4swvNY+/VzvcJjQ+Q8yRX/EbSeAqwK1sta1gAj4g+lLFXdtNaBopBJo3
DaRttGLxERvrIbJs2smIjrorTeO5ndn8W8a8iA39uAPqrJxr4zRqYGwdlCBh/hco
3O3Q8kDGvSQcqawrVtB3FZtJLyd916ltitoNVUaXuQxGBbKvoLIfaguTYU86rvZ6
hmTXfEiScuFbyB7WZ99ssGEtMOY4gD6v2gEEBskwZUC6ppVI7kz7SH/XN4RdQ9+E
CABVPBTX4jHNUeG/0gDc1yuwOZY/fWqF7HS7QK6vh5o4jPB9MVWD3flb6ppW+PVS
aT6c6JrSNEjWNQsV2ETm044Xcjl9OvpEk6goP3AfqoDKTjRLJKs=
=fqVI
-----END PGP SIGNATURE-----

--vnx7d7i7pnisscty--
