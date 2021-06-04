Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EB39B91D
	for <lists+linux-pm@lfdr.de>; Fri,  4 Jun 2021 14:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFDMjd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Jun 2021 08:39:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34952 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDMjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 08:39:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 8287A1F439B4
Received: by earth.universe (Postfix, from userid 1000)
        id 006A43C0C95; Fri,  4 Jun 2021 14:37:43 +0200 (CEST)
Date:   Fri, 4 Jun 2021 14:37:43 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Carl Philipp Klemm <philipp@uvos.xyz>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Arthur Demchenkov <spinal.by@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Merlijn Wajer <merlijn@wizzup.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2] power: supply: cpcap-charger: get the battery
 inserted infomation from cpcap-battery
Message-ID: <20210604123743.ydkxnyspueapxn7p@earth.universe>
References: <20210423150057.97e0a2b43f20fdc3513f4fea@uvos.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xm763r5io7nkaxrr"
Content-Disposition: inline
In-Reply-To: <20210423150057.97e0a2b43f20fdc3513f4fea@uvos.xyz>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xm763r5io7nkaxrr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 23, 2021 at 03:00:57PM +0200, Carl Philipp Klemm wrote:
> This avoids reimplementing the detection logic twice and removes the
> possibility of activating charging with 500mA even if a battery is not
> detected.
>=20
> Signed-off-by: Carl Philipp Klemm <philipp@uvos.xyz>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/cpcap-charger.c | 39 ++++++++++++++--------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> index 641dcad1133f..a5983365b81a 100644
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
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
> @@ -697,11 +680,29 @@ static void cpcap_usb_detect(struct work_struct *wo=
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
> +		battery =3D power_supply_get_by_name("battery");
> +		if (IS_ERR_OR_NULL(battery)) {
> +			dev_err(ddata->dev, "battery power_supply not available %li\n",
> +					PTR_ERR(battery));
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
> --=20
> 2.31.0
>=20
>=20

--xm763r5io7nkaxrr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC6HpcACgkQ2O7X88g7
+pp4qQ/+I25LgDytDAta6rpCQC1BfbkQ/eQnvlFsYjur77VRTznAWPCzO3Istxcl
LnzKFRfzMvyA5Z/KXJDvUaX8ZJ9q2X6q6lcBvxv/Kmn0tS1n16PJ4dkEaA4grW0z
p2AuBwWCVrTXrbG4Wq6WUwARMWRAzBm2Gpk/xLaDm4X3cKigeetD9bu+flbq0iQS
82Af9cNnJ3nk7INrwL/c6eLZdC/fYbNDLczXKH3kNOO+2rO9Wour4oGaz4Qaat5M
AoFOgSA2BpMrZBrMgh7fBvbtKMVwjFE0yonj7qDqtMLHhryBQticvzc9FoGGOfSa
bkhpjzsN/7LDsDH94QdtBu1cjbx0jsIVctEB5FT5hQfJRe2szCQgEJGH1aNVj4+k
xWYoMU0TSiuch+FEEo0fxzeWAGgTfbeL+v8wPqSrBzYL3bUv43m0o+hLb3ggfnI2
g1YKtlcvPFhLrcuNIMF5p3yTM6h1QH9EvWna/95l92DSHJKenRliMco92/Pi4YRR
YZ4pcaPF4d4QPiCh5LF8Bel0cGY8ZhXwNrH9bOdxDUEyHYOkm23pvdDf06WOZ+Jl
QhNTdztPTotR8/5JcI8zRqrIvXwGftQpqGFkSnEubyDsippVslnFI+zak+5EO1y/
wfhGhZhdBUXt5XfI1XX1SQqNQwlquxrrQJShii49pUL/tYVhVzs=
=XB1b
-----END PGP SIGNATURE-----

--xm763r5io7nkaxrr--
