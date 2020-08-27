Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B02550CD
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 23:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0V6m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 17:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgH0V6m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 27 Aug 2020 17:58:42 -0400
Received: from earth.universe (dyndsl-037-138-189-082.ewe-ip-backbone.de [37.138.189.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2A82080C;
        Thu, 27 Aug 2020 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598565521;
        bh=dhU5+KRtYh+a5k+/REfVQzkT3EoL5CBlQqPjEzmK8vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AWzopYJsuBqRRNlhXp1YkZR1rK6zPQ6vps0MtKpSLD8FTUUId+bsgN2ySqZxZKRAa
         nmgJC4OSEINjjCv1TEx4lTZABoftCRlMbyTeJfrSWULV8lOamX00BmTNbonmm2TRlK
         dx+Dr14qU+bQoO6oQ2yqPlBPvNQGUZXVUL6IpReI=
Received: by earth.universe (Postfix, from userid 1000)
        id 5F4EA3C0C82; Thu, 27 Aug 2020 23:58:39 +0200 (CEST)
Date:   Thu, 27 Aug 2020 23:58:39 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        drinkcat@chromium.org
Subject: Re: [PATCH v3 1/2] power: supply: sbs-battery: combine
 get_presence_and_health
Message-ID: <20200827215839.5pjkgyjhgs3joz6g@earth.universe>
References: <0200811065307.2094930-1-ikjn@chromium.org>
 <20200813051008.3461515-1-ikjn@chromium.org>
 <20200813051008.3461515-2-ikjn@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5eohnnclgbpgfzvy"
Content-Disposition: inline
In-Reply-To: <20200813051008.3461515-2-ikjn@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--5eohnnclgbpgfzvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 13, 2020 at 01:10:07PM +0800, Ikjoon Jang wrote:
> This patch enables calling sbs_get_battery_presence_and_health()
> without checking its chip type. No functional changes.
>=20
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/sbs-battery.c | 73 +++++++++++++++---------------
>  1 file changed, 36 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sb=
s-battery.c
> index 83b9924033bd..6acb4ea25d2a 100644
> --- a/drivers/power/supply/sbs-battery.c
> +++ b/drivers/power/supply/sbs-battery.c
> @@ -389,37 +389,6 @@ static bool sbs_bat_needs_calibration(struct i2c_cli=
ent *client)
>  	return !!(ret & BIT(7));
>  }
> =20
> -static int sbs_get_battery_presence_and_health(
> -	struct i2c_client *client, enum power_supply_property psp,
> -	union power_supply_propval *val)
> -{
> -	int ret;
> -
> -	/* Dummy command; if it succeeds, battery is present. */
> -	ret =3D sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> -
> -	if (ret < 0) { /* battery not present*/
> -		if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT) {
> -			val->intval =3D 0;
> -			return 0;
> -		}
> -		return ret;
> -	}
> -
> -	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT)
> -		val->intval =3D 1; /* battery present */
> -	else { /* POWER_SUPPLY_PROP_HEALTH */
> -		if (sbs_bat_needs_calibration(client)) {
> -			val->intval =3D POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
> -		} else {
> -			/* SBS spec doesn't have a general health command. */
> -			val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  static int sbs_get_ti_battery_presence_and_health(
>  	struct i2c_client *client, enum power_supply_property psp,
>  	union power_supply_propval *val)
> @@ -478,6 +447,41 @@ static int sbs_get_ti_battery_presence_and_health(
>  	return 0;
>  }
> =20
> +static int sbs_get_battery_presence_and_health(
> +	struct i2c_client *client, enum power_supply_property psp,
> +	union power_supply_propval *val)
> +{
> +	struct sbs_info *chip =3D i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (chip->flags & SBS_FLAGS_TI_BQ20ZX5)
> +		return sbs_get_ti_battery_presence_and_health(client, psp, val);
> +
> +	/* Dummy command; if it succeeds, battery is present. */
> +	ret =3D sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> +
> +	if (ret < 0) { /* battery not present*/
> +		if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT) {
> +			val->intval =3D 0;
> +			return 0;
> +		}
> +		return ret;
> +	}
> +
> +	if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT)
> +		val->intval =3D 1; /* battery present */
> +	else { /* POWER_SUPPLY_PROP_HEALTH */
> +		if (sbs_bat_needs_calibration(client)) {
> +			val->intval =3D POWER_SUPPLY_HEALTH_CALIBRATION_REQUIRED;
> +		} else {
> +			/* SBS spec doesn't have a general health command. */
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int sbs_get_battery_property(struct i2c_client *client,
>  	int reg_offset, enum power_supply_property psp,
>  	union power_supply_propval *val)
> @@ -780,12 +784,7 @@ static int sbs_get_property(struct power_supply *psy,
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_PRESENT:
>  	case POWER_SUPPLY_PROP_HEALTH:
> -		if (chip->flags & SBS_FLAGS_TI_BQ20ZX5)
> -			ret =3D sbs_get_ti_battery_presence_and_health(client,
> -								     psp, val);
> -		else
> -			ret =3D sbs_get_battery_presence_and_health(client, psp,
> -								  val);
> +		ret =3D sbs_get_battery_presence_and_health(client, psp, val);
> =20
>  		/* this can only be true if no gpio is used */
>  		if (psp =3D=3D POWER_SUPPLY_PROP_PRESENT)
> --=20
> 2.28.0.236.gb10cc79966-goog
>=20

--5eohnnclgbpgfzvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl9ILI8ACgkQ2O7X88g7
+ppYJg/8CL8Srzt6wPeuZ1PUHU8p4stgOkEcFnkiT1BUoTJvAoFCtWL/dLc+jeIa
q8rP0BBMS6nduAZN/dPyskCrRlz1z+Mq0cyHbBYxc2XHbLJLjXpEvW9KqAwqucrh
GQWgDWFOVPMUebCWRUuaIVhJJKhVDGYMyk7QqUFbHcE1IKPdHo0ukvZbBiS3B2n4
wZl5XJEfRQIRtOjQ3OVPFlR49tbc/lOp5TrZnaHsk+AOHjA8uF9Eswo3FvaBtRxF
EfhvU1oi2eIy+XSp9aTBxBjeD3dc3pjA7Hmx3i7gf+8wdD6vNeWTtjsrbBGmDi98
xKv3S9JhUe9nlkdQaRCw5bV+9KgsXT3OSjSXEAeR1ffV/3Qf5t9va6I3/3K588KK
QrDl86vMpKAJmtc4E+2RNEUtKHW0NnKpZjTFQ8XNQ8BHubCbXJCEV0+Wjh6aFEZ5
iL0jj/57mcIyM72AzJ2KgEOMkot2n/tdKxxpxnK1+yczg6YVrasPMYWZUM9juVCl
SNy2jOrxx1XHtNIoZJyir8IfM/jHKsKten4J67v1kyHqvWDvkNLSvhBrdhoS9W2y
YC4aK63NmvcNDDh6XD0xBYIx1FU5nUp+XNDUXNbI+gGvcTdd9YG/faOYnsGJMkGe
RgamLh8kTlSmb8bA/r30/08ROyvaXDpgE6FjAdE/Eo9SQmRbnE8=
=qWBP
-----END PGP SIGNATURE-----

--5eohnnclgbpgfzvy--
