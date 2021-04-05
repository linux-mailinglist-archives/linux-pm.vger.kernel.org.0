Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2564A353C53
	for <lists+linux-pm@lfdr.de>; Mon,  5 Apr 2021 10:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhDEIUq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Apr 2021 04:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhDEIUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Apr 2021 04:20:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5162C061756;
        Mon,  5 Apr 2021 01:20:39 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F18441F44ABA
Received: by earth.universe (Postfix, from userid 1000)
        id AB2273C0C96; Mon,  5 Apr 2021 10:20:33 +0200 (CEST)
Date:   Mon, 5 Apr 2021 10:20:33 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/5] power: supply: cpcap-charger: get the battery
 inserted infomation from cpcap-battery
Message-ID: <20210405082033.m5r4uqlg6yto3iaq@earth.universe>
References: <20210117224158.f0ac792da5f480a660ff3c89@uvos.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r22dwce66ym5qk5i"
Content-Disposition: inline
In-Reply-To: <20210117224158.f0ac792da5f480a660ff3c89@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--r22dwce66ym5qk5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 17, 2021 at 10:41:58PM +0100, Carl Philipp Klemm wrote:
> This avoids reimplementing the detection logic twice and removes the
> possibility of activating charging with 500mA even if a battery is not
> detected.
>=20
> Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
> ---
>  drivers/power/supply/cpcap-charger.c | 41 ++++++++++++++--------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index 823d666f09e0..152090faf5b2 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -26,8 +26,8 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/usb/phy_companion.h>
>  #include <linux/phy/omap_usb.h>
> -#include <linux/usb/otg.h>
>  #include <linux/iio/consumer.h>
> +#include <linux/usb/otg.h>
>  #include <linux/mfd/motorola-cpcap.h>

why?

> =20
>  /*
> @@ -173,23 +173,6 @@ static enum power_supply_property cpcap_charger_prop=
s[] =3D {
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  };
> =20
> -/* No battery always shows temperature of -40000 */
> -static bool cpcap_charger_battery_found(struct cpcap_charger_ddata *ddat=
a)
> -{
> -	struct iio_channel *channel;
> -	int error, temperature;
> -
> -	channel =3D ddata->channels[CPCAP_CHARGER_IIO_BATTDET];
> -	error =3D iio_read_channel_processed(channel, &temperature);
> -	if (error < 0) {
> -		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
> -
> -		return false;
> -	}
> -
> -	return temperature > -20000 && temperature < 60000;
> -}
> -
>  static int cpcap_charger_get_charge_voltage(struct cpcap_charger_ddata *=
ddata)
>  {
>  	struct iio_channel *channel;
> @@ -696,11 +679,29 @@ static void cpcap_usb_detect(struct work_struct *wo=
rk)
> =20
>  	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
>  	    s.chrgcurr1) {
> -		int max_current =3D 532000;
> +		int max_current;
>  		int vchrg, ichrg;
> +		union power_supply_propval val;
> +		struct power_supply *battery;
> =20
> -		if (cpcap_charger_battery_found(ddata))
> +		battery =3D power_supply_get_by_phandle(ddata->dev->of_node, "battery"=
);

Let's not add DT properties, that are not really required. For now
you can just use power_supply_get_by_name("battery"), which should
always return the cpcap-battery on cpcap based systems. In the
future the power-supply core framework will hopefully provide a
function to get the devices supplied by a charger.

> +		if (IS_ERR_OR_NULL(battery)) {
> +			dev_err(ddata->dev, "battery described by phandle not available %li\n=
",
> +					PTR_ERR(battery));

Don't forget to update the error message.

> +			return;
> +		}
> +
> +		error =3D power_supply_get_property(battery, POWER_SUPPLY_PROP_PRESENT=
, &val);
> +		power_supply_put(battery);
> +		if (error)
> +			goto out_err;
> +
> +		if (val.intval) {
>  			max_current =3D 1596000;
> +		} else {
> +			dev_info(ddata->dev, "battery not inserted charging disabled\n");
> +			max_current =3D 0;
> +		}
> =20
>  		if (max_current > ddata->limit_current)
>  			max_current =3D ddata->limit_current;

Otherwise LGTM.

-- Sebastian

--r22dwce66ym5qk5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBqyFEACgkQ2O7X88g7
+pr2Ww//XZCOIHoPHdoaMNsIhOLcwzm7MmlvpVoup9/Mw2K2rhy/3uurTbkqvj9O
qgPvjFcln6qd3wcFpY6K9EhjtqszYPS4zWRPKwLtB9dbCBbX5YEf/Ywl+31r4n/B
cg/75RvI5tz4JXJkHWSXmVfMn4CkC0/enG+9nfczyRM9XToErGwM1esenBEqNGzV
04SdjRFJuTn7QnxZRTZgpda/Mk41XKNYhoHeNIE99bXX5vbDZViEcBhCAqfHFi2J
6HBzzpBOKciKRpjsY41+z7pttcINP/bLJ1AOues4PN/ReQDmdYcUVnkvUKPFE4OZ
BspksOKfz3KOVC5awqAUFFiTfzuxSfnnPpmejXJEJyp1DWAe71VOlFe3DFnwKHOQ
tw7FKgNdCdhtfqOerg6MNjcMDRrSgJ4p0dAPyfXZMpz2PfGizK8PMX8ouRyl1KLQ
9fBb1DM+C9IcLBp0BBZK7+0rMnJYXJ5AKfqfLzkC1Y+i+3X7at89vtcLlNgvrFha
K8W9IUU0hLt1vIUBls/QGxNFQd/xexZ980n2AF0+qUjJulrMRQixKAcl1QT0m9AW
QesGcPO38jM2Z0Mw0hkQ6Kyx9/e3y6McMrneCeQCCNv9J1vx5X72GJlzJbTTOy0M
4IbvMiJFrXRjCMdtWfwrP0QMSQU7bfpQPl2rPuRs1e4dqIG/Tg0=
=cPac
-----END PGP SIGNATURE-----

--r22dwce66ym5qk5i--
