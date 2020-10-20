Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18DF2944A6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 23:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389009AbgJTVla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 17:41:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389000AbgJTVla (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 20 Oct 2020 17:41:30 -0400
Received: from earth.universe (unknown [185.213.155.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C875922244;
        Tue, 20 Oct 2020 21:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603230089;
        bh=zqAyBxlfTH5OJ46Fj5/5aSmxDXUxtipF1Wj9/DwXGDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gj7/HM2tMpB49uofdDJ5P2EfZsNf2c4mTxMIxwokrIiivJf2pUGBilC19RlHUI5Ly
         q81VhY4HyrhUJ4yfE8+QXsKDDEpXyN6lqKgbT+4Ckvmkey1dZS8DFFssk/t9BAnsEH
         +I0csOt2Mi043PMYkGNRRuNkRRrJSqBcjwqaOprY=
Received: by earth.universe (Postfix, from userid 1000)
        id 27EDE3C0C8E; Tue, 20 Oct 2020 23:41:26 +0200 (CEST)
Date:   Tue, 20 Oct 2020 23:41:26 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Dev Null <devnull@uvos.xyz>
Cc:     linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] power: supply: cpcap-battery: improve handling of
 3rd party and XT875 batteries.
Message-ID: <20201020214126.tkf37xpehnpxli4a@earth.universe>
References: <20201020225312.b4ea29c9dc3ae00f23e39280@uvos.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="njjchyxappkr4c24"
Content-Disposition: inline
In-Reply-To: <20201020225312.b4ea29c9dc3ae00f23e39280@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--njjchyxappkr4c24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please do one change per patch:

On Tue, Oct 20, 2020 at 10:53:12PM +0200, Dev Null wrote:
> Adds a module option to ignore a missing temerature sensor.

first patch

> Invalidates empty->counter_uah and charge_full when charge_now indicates =
that they are grossly wrong

second patch

> Makes charge_full_design writeable, so that different/custom batteries ca=
n be used.

third patch

> This is especially usfull on XTT875 where both HW4X and BW8X exsist.

missing Signed-off-by.

> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/=
cpcap-battery.c
> index 3be76cd7584a..ffa70c31c1cb 100644
> --- a/drivers/power/supply/cpcap-battery.c
> +++ b/drivers/power/supply/cpcap-battery.c
> @@ -28,6 +28,7 @@
>  #include <linux/power_supply.h>
>  #include <linux/reboot.h>
>  #include <linux/regmap.h>
> +#include <linux/moduleparam.h>
> =20
>  #include <linux/iio/consumer.h>
>  #include <linux/iio/types.h>
> @@ -162,6 +163,9 @@ static const struct cpcap_battery_capacity cpcap_batt=
ery_cap[] =3D {
> =20
>  #define CPCAP_NO_BATTERY	-400
> =20
> +static bool ignore_temperature_probe;
> +module_param(ignore_temperature_probe, bool, 0660);

Can this be deferred from DT (i.e. always disable temperature probe
on XT875)? Having to specify a module parameter to get a working
system is not very user friendly.

>  static struct cpcap_battery_state_data *
>  cpcap_battery_get_state(struct cpcap_battery_ddata *ddata,
>  			enum cpcap_battery_state state)
> @@ -205,7 +209,8 @@ static int cpcap_charger_battery_temperature(struct c=
pcap_battery_ddata *ddata,
>  	channel =3D ddata->channels[CPCAP_BATTERY_IIO_BATTDET];
>  	error =3D iio_read_channel_processed(channel, value);
>  	if (error < 0) {
> -		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
> +		if (!ignore_temperature_probe)
> +			dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
>  		*value =3D CPCAP_NO_BATTERY;
> =20
>  		return error;
> @@ -558,7 +563,7 @@ static int cpcap_battery_get_property(struct power_su=
pply *psy,
> =20
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_PRESENT:
> -		if (latest->temperature > CPCAP_NO_BATTERY)
> +		if (latest->temperature > CPCAP_NO_BATTERY || ignore_temperature_probe)
>  			val->intval =3D 1;
>  		else
>  			val->intval =3D 0;
> @@ -641,10 +646,22 @@ static int cpcap_battery_get_property(struct power_=
supply *psy,
>  		if (!empty->voltage)
>  			return -ENODATA;
>  		val->intval =3D empty->counter_uah - latest->counter_uah;
> -		if (val->intval < 0)
> +		if (val->intval < 0) {
> +			if (ddata->charge_full && abs(val->intval) > ddata->charge_full/5) {
> +				empty->voltage =3D 0;
> +				ddata->charge_full =3D 0;
> +				return -ENODATA;
> +			}
>  			val->intval =3D 0;
> -		else if (ddata->charge_full && ddata->charge_full < val->intval)
> +		}
> +		else if (ddata->charge_full && ddata->charge_full < val->intval) {
> +			if (val->intval > (6*ddata->charge_full)/5) {
> +				empty->voltage =3D 0;
> +				ddata->charge_full =3D 0;
> +				return -ENODATA;
> +			}
>  			val->intval =3D ddata->charge_full;
> +		}

The context of this patch is not available in cpcap-battery driver
=66rom mainline. So this has dependencies on other patches, which
need to be submitted first. I currently do not have any pending
cpcap patches, but IIRC there was a big patchset which had to be
resubmitted.

>  		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		if (!ddata->charge_full)
> @@ -658,6 +675,8 @@ static int cpcap_battery_get_property(struct power_su=
pply *psy,
>  		val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP:
> +		if (ignore_temperature_probe)
> +			return -ENODATA;
>  		val->intval =3D latest->temperature;
>  		break;
>  	default:
> @@ -715,11 +734,18 @@ static int cpcap_battery_set_property(struct power_=
supply *psy,
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		if (val->intval < 0)
>  			return -EINVAL;
> -		if (val->intval > ddata->config.info.charge_full_design)
> +		if (val->intval > (6*ddata->config.info.charge_full_design)/5)

This deserves a comment. Why do we allow to set charge full to be
above full design capacity?

>  			return -EINVAL;
> =20
>  		ddata->charge_full =3D val->intval;
> =20
> +		return 0;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		if (val->intval < 0)
> +			return -EINVAL;
> +
> +		ddata->config.info.charge_full_design =3D val->intval;
> +
>  		return 0;
>  	default:
>  		return -EINVAL;
> @@ -734,6 +760,7 @@ static int cpcap_battery_property_is_writeable(struct=
 power_supply *psy,
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>  		return 1;
>  	default:
>  		return 0;
>=20
> --=20
> Dev Null <devnull@uvos.xyz>

-- Sebastian

--njjchyxappkr4c24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl+PWYIACgkQ2O7X88g7
+pqJWg/+Jv/6JZqOnzWodsZkbcobXRp5jkn+MI2WmaBgfZEe8vM6oM+uHUk2MbRe
3WUwrmxj9ShIVu/lX19nl9PCp2YeRCqltadqY2pJgOYdnANHVBfqzoLeChmC6NMw
WSlThRyxB1vLjjcVemJoeqxOfQJi1EGfGhmr/C1Y7B9GetTL8+SYe79shdoQVj+J
SDw+OaRCH+36V+TkUhwas/P8lv1nUyybctz4q8nThFAoq6tom05bXnhMw+NXxzUi
K/JCJ5UehR8UNBYTv5zRbfveKpKZs/zTkfh83aP+YDaN8IeVUHDX39FKDr9wxXE1
+HeuEx2MyQ09L/LP8h5gznV45mPKNWHTE5kC3vJ38HbWMM81txaqAnZ9gh1PHQhU
HiMosixVIogatusEQ4VEi5MxHgWESm3r4wRE0fvi+yBIiMFSv1exj9+gW5yrYUGj
AB+zlw7+QmXhYYPBP8E+lllpBhfYFqUnf9pU/OYYbCZhvqb51YtM1eZeGL4plEs/
6sY9QLu8603Xus/r3RZj6HxWhqZk0VZMmNPNbSIK2YGXUpajSCISG7oBSbYafv65
fXbdTea/i3uicwxzMwIzh3YNUyXsVq4aOwZHpgmOV/y1LP6YyK19lsZyvS4Zp9Zm
NVRGXXtuWsb6tfD96yLNbsMyT8KUdo2CVGvbALVYn2dRjEtDBcc=
=8pV7
-----END PGP SIGNATURE-----

--njjchyxappkr4c24--
