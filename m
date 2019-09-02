Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0212EA5D5F
	for <lists+linux-pm@lfdr.de>; Mon,  2 Sep 2019 23:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfIBVMQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Sep 2019 17:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfIBVMQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Sep 2019 17:12:16 -0400
Received: from earth.universe (unknown [185.62.205.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC11F20870;
        Mon,  2 Sep 2019 21:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567458735;
        bh=mX7gHKFdkkKmwnAY9uA8jEQBHqjawX7YsmSaLwFJcIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iITFSwHyzBKVlPfuCJOh8b/ttM2LKSVWSD3YTEEUkRx+Nqmrz5Z3yZ9/OdsJRR80V
         Uh6a1WZCS/fzYUpiEg6v0NwnOml9ZIMjfF0dO6TAbY/9QViBigKBbKaLLkyq1x0r4o
         aCgvBrksy5phsR1XB5v8yx28jl6YqH0zkG/dwV3U=
Received: by earth.universe (Postfix, from userid 1000)
        id 4120F3C0CFA; Mon,  2 Sep 2019 23:12:12 +0200 (CEST)
Date:   Mon, 2 Sep 2019 23:12:12 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        Jacopo Mondi <jacopo@jmondi.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Scott <hashcode0f@gmail.com>,
        NeKit <nekit1000@gmail.com>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] power: supply: cpcap-charger: Enable vbus boost voltage
Message-ID: <20190902211212.qvkgbyr6q7vwver2@earth.universe>
References: <20190830232316.53750-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="enxknyhvckayhj26"
Content-Disposition: inline
In-Reply-To: <20190830232316.53750-1-tony@atomide.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--enxknyhvckayhj26
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 30, 2019 at 04:23:16PM -0700, Tony Lindgren wrote:
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
>=20
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

Thanks, queued.

-- Sebastian

>  drivers/phy/motorola/phy-cpcap-usb.c |  8 +++++---
>  drivers/power/supply/cpcap-charger.c | 23 ++++++++++++++++++++---
>  2 files changed, 25 insertions(+), 6 deletions(-)
>=20
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
> --=20
> 2.23.0

--enxknyhvckayhj26
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl1thawACgkQ2O7X88g7
+pqrxg//b6vRjyNw2Ha/J6i3s4DO7wy3mQRBFk2KROmrvZNFzLeUWS5IQhkaQRdw
6CYU5Xw7X3a3B3nclYqp7qsdhWu3j6dJSmy+7AqDSX6rWhDnSl5Nko7sqpCy/b+t
QUVnO0JVLjQHqKYuT5CF4ilaR3IKbrk0ysJxoF2QuxvZMQnji09mHFVwtLy6DDqP
RBXKg49+DpwZhpMSH9VCBwVO/q0UOYXmTeUgb+jpyOuDxXTevGpVELzEJd56HYXf
/paJuy6/hObFgHTQPXMFYWklNVNd0U/NXV/rvLF28J3mif5Yi2JUni5ks/49R3ca
c1umtBTU18kIPcNLrvTzojzEZ2bcP9+o7rXSnLefcBGrib1UhSix+Ctu2EBWqtpG
j63L9Gn++AadVfuE6fNU+mbxpbhLtHL0dU0DwRxLzci26nn8QrdEnb+A15xDAyFV
wdjQCtQkMOlB0KM2FDWvAvl0ogzRocxgdN1ZRACw5kgm42MVYg7WSD808jb0o4/x
tlK00QxcBak3mevMvK8Y8bSlcYFPGqY4HiK2PAn3djLMoKSZIubsE1Op6tN4vob0
wQhDVDuxWE7IBHv3MZVHct26TpNQp6HRWMvFOS+3vp76UMsrc9Ya5Jo6OxCITJAg
EFVRYbLXSvo118OUE2CqDR0CTAln30/2VoJexMdBKBp7CvAXblE=
=uz36
-----END PGP SIGNATURE-----

--enxknyhvckayhj26--
