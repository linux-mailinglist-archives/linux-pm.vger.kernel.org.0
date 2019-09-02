Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B17A5081
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 09:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfIBH7r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 03:59:47 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58033 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfIBH7r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Sep 2019 03:59:47 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 61D2C8219A; Mon,  2 Sep 2019 09:59:30 +0200 (CEST)
Date:   Mon, 2 Sep 2019 09:59:43 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, Jacopo Mondi <jacopo@jmondi.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>
Subject: Re: [PATCH] power: supply: cpcap-charger: Enable vbus boost voltage
Message-ID: <20190902075943.GB15850@amd>
References: <20190830232316.53750-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
In-Reply-To: <20190830232316.53750-1-tony@atomide.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> We are currently not enabling VBUS boost for cpcap when in host mode.
> This means the VBUS is fed at the battery voltage level, which can cause
> flakeyness enumerating devices.
>=20
> Looks like the boost control for VBUS is CPCAP_BIT_VBUS_SWITCH that we
> must enable in the charger for nice 4.92 V VBUS output. And looks like
> we must not use the STBY pin enabling but must instead use manual VBUS
> control in phy-cpcap-usb.
>=20
> We want to do this in cpcap_charger_vbus_work() and also set a flag for
> feeding_vbus to avoid races between USB detection and charger detection,
> and disable charging if feeding_vbus is set.

I did not know phone is supposed to provide voltage on USB. USB mouse
works for me.. in stock android, provided I conect USB hub and
external power.

This does not seem to work for me.. and it does not even work on stock
kernel. What is going on here?

Is there some kind of debug ineterface where I could test just the
vbus switch? I do have voltmeter for the usb port...

Best regards,
								Pavel

> diff --git a/drivers/phy/motorola/phy-cpcap-usb.c b/drivers/phy/motorola/=
phy-cpcap-usb.c
> --- a/drivers/phy/motorola/phy-cpcap-usb.c
> +++ b/drivers/phy/motorola/phy-cpcap-usb.c
> @@ -231,8 +231,9 @@ static void cpcap_usb_detect(struct work_struct *work)
>  			goto out_err;
> =20
>  		error =3D regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
> -					   CPCAP_BIT_VBUSSTBY_EN,
> -					   CPCAP_BIT_VBUSSTBY_EN);
> +					   CPCAP_BIT_VBUSSTBY_EN |
> +					   CPCAP_BIT_VBUSEN_SPI,
> +					   CPCAP_BIT_VBUSEN_SPI);
>  		if (error)
>  			goto out_err;
> =20
> @@ -240,7 +241,8 @@ static void cpcap_usb_detect(struct work_struct *work)
>  	}
> =20
>  	error =3D regmap_update_bits(ddata->reg, CPCAP_REG_USBC3,
> -				   CPCAP_BIT_VBUSSTBY_EN, 0);
> +				   CPCAP_BIT_VBUSSTBY_EN |
> +				   CPCAP_BIT_VBUSEN_SPI, 0);
>  	if (error)
>  		goto out_err;
> =20
> diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/=
cpcap-charger.c
> --- a/drivers/power/supply/cpcap-charger.c
> +++ b/drivers/power/supply/cpcap-charger.c
> @@ -108,6 +108,9 @@
>  #define CPCAP_REG_CRM_ICHRG_1A596	CPCAP_REG_CRM_ICHRG(0xe)
>  #define CPCAP_REG_CRM_ICHRG_NO_LIMIT	CPCAP_REG_CRM_ICHRG(0xf)
> =20
> +/* CPCAP_REG_VUSBC register bits needed for VBUS */
> +#define CPCAP_BIT_VBUS_SWITCH		BIT(0)	/* VBUS boost to 5V */
> +
>  enum {
>  	CPCAP_CHARGER_IIO_BATTDET,
>  	CPCAP_CHARGER_IIO_VOLTAGE,
> @@ -130,7 +133,8 @@ struct cpcap_charger_ddata {
>  	struct power_supply *usb;
> =20
>  	struct phy_companion comparator;	/* For USB VBUS */
> -	bool vbus_enabled;
> +	unsigned int vbus_enabled:1;
> +	unsigned int feeding_vbus:1;
>  	atomic_t active;
> =20
>  	int status;
> @@ -325,7 +329,6 @@ static bool cpcap_charger_vbus_valid(struct cpcap_cha=
rger_ddata *ddata)
>  }
> =20
>  /* VBUS control functions for the USB PHY companion */
> -
>  static void cpcap_charger_vbus_work(struct work_struct *work)
>  {
>  	struct cpcap_charger_ddata *ddata;
> @@ -343,6 +346,7 @@ static void cpcap_charger_vbus_work(struct work_struc=
t *work)
>  			return;
>  		}
> =20
> +		ddata->feeding_vbus =3D true;
>  		cpcap_charger_set_cable_path(ddata, false);
>  		cpcap_charger_set_inductive_path(ddata, false);
> =20
> @@ -350,12 +354,23 @@ static void cpcap_charger_vbus_work(struct work_str=
uct *work)
>  		if (error)
>  			goto out_err;
> =20
> +		error =3D regmap_update_bits(ddata->reg, CPCAP_REG_VUSBC,
> +					   CPCAP_BIT_VBUS_SWITCH,
> +					   CPCAP_BIT_VBUS_SWITCH);
> +		if (error)
> +			goto out_err;
> +
>  		error =3D regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
>  					   CPCAP_REG_CRM_RVRSMODE,
>  					   CPCAP_REG_CRM_RVRSMODE);
>  		if (error)
>  			goto out_err;
>  	} else {
> +		error =3D regmap_update_bits(ddata->reg, CPCAP_REG_VUSBC,
> +					   CPCAP_BIT_VBUS_SWITCH, 0);
> +		if (error)
> +			goto out_err;
> +
>  		error =3D regmap_update_bits(ddata->reg, CPCAP_REG_CRM,
>  					   CPCAP_REG_CRM_RVRSMODE, 0);
>  		if (error)
> @@ -363,6 +378,7 @@ static void cpcap_charger_vbus_work(struct work_struc=
t *work)
> =20
>  		cpcap_charger_set_cable_path(ddata, true);
>  		cpcap_charger_set_inductive_path(ddata, true);
> +		ddata->feeding_vbus =3D false;
>  	}
> =20
>  	return;
> @@ -431,7 +447,8 @@ static void cpcap_usb_detect(struct work_struct *work)
>  	if (error)
>  		return;
> =20
> -	if (cpcap_charger_vbus_valid(ddata) && s.chrgcurr1) {
> +	if (!ddata->feeding_vbus && cpcap_charger_vbus_valid(ddata) &&
> +	    s.chrgcurr1) {
>  		int max_current;
> =20
>  		if (cpcap_charger_battery_found(ddata))

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1sy+8ACgkQMOfwapXb+vKc5wCdGy4C48hGf4R2WehOQzOw6AAy
2+YAnj5B2/Lli8iBqDDqG1t5zSctNmxi
=tuya
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
