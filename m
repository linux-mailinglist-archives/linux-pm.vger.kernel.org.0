Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6C17B761E
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2019 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbfISJT7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Sep 2019 05:19:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43437 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfISJT6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Sep 2019 05:19:58 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 357B181895; Thu, 19 Sep 2019 11:19:42 +0200 (CEST)
Date:   Thu, 19 Sep 2019 11:19:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>
Subject: Re: [PATCH 3/3] power: supply: cpcap-charger: Improve battery
 detection
Message-ID: <20190919091955.GC9644@amd>
References: <20190917213501.16907-1-tony@atomide.com>
 <20190917213501.16907-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4jXrM3lyYWu4nBt5"
Content-Disposition: inline
In-Reply-To: <20190917213501.16907-4-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--4jXrM3lyYWu4nBt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We are currently using a wrong ADC range for the battery detection.
> The ADC returns the battery temperature if connected.

This one looks good.

> Cc: Merlijn Wajer <merlijn@wizzup.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

Would it also make sense to publish battery temperature somewhere? It
is somehow important for checking "what is going on" and it should
also be used to control charging. (Normal charging should only be
allowed in normal temperatures, like >10C and <30C or so..)

Thanks and best regards,
								Pavel


> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/power/supply/cpcap-charger.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -166,20 +166,21 @@ static enum power_supply_property cpcap_charger_pro=
ps[] =3D {
>  	POWER_SUPPLY_PROP_CURRENT_NOW,
>  };
> =20
> +/* No battery always shows temperature of -40000 */
>  static bool cpcap_charger_battery_found(struct cpcap_charger_ddata *ddat=
a)
>  {
>  	struct iio_channel *channel;
> -	int error, value;
> +	int error, temperature;
> =20
>  	channel =3D ddata->channels[CPCAP_CHARGER_IIO_BATTDET];
> -	error =3D iio_read_channel_raw(channel, &value);
> +	error =3D iio_read_channel_processed(channel, &temperature);
>  	if (error < 0) {
>  		dev_warn(ddata->dev, "%s failed: %i\n", __func__, error);
> =20
>  		return false;
>  	}
> =20
> -	return value =3D=3D 1;
> +	return temperature > -20000 && temperature < 60000;
>  }
> =20
>  static int cpcap_charger_get_charge_voltage(struct cpcap_charger_ddata *=
ddata)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4jXrM3lyYWu4nBt5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2DSDsACgkQMOfwapXb+vKgowCbBP2eQe/F7WR1obNTH/1NqJ3b
RXUAn0fqlpo7pgSOf0QCoOpF2Dh5Qg2d
=byaD
-----END PGP SIGNATURE-----

--4jXrM3lyYWu4nBt5--
