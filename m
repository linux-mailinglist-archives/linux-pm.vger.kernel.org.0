Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1987E455C8A
	for <lists+linux-pm@lfdr.de>; Thu, 18 Nov 2021 14:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhKRNZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Nov 2021 08:25:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhKRNZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Nov 2021 08:25:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 047751F465FC
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1637241726; bh=uK5bx7gv4nDW8o35sRTgpc7tPSSKeN8auDN0+JaR20M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M51xD3DvhQgATx0lacmXOMXSKZ/Sz0tCKw9u6rIcca2bAW9KF6mAVMdRiM1iLOY6q
         Yw08ZviKjm3NakcL5mf/AFqGk4D7DFp0LeD6e0cFOZs3mi+dwjJTIRjpToMc5LSCxJ
         WExZVw5dIR26bV6hiGc5idPAr/3L2CLIdlMjkXyc+oGm1EXEgCiaPMknfxDO0ZYfbJ
         xpDSqgDNznT3Ipgh6ejMnpQdQ8W+CcU0wutZ12OWiQORW+gbYiBPdwFgcCmuT8v4Qi
         IR0hY9zLrLrGyrXwYxQ81WQ/ZGLOBIEpUJ3IMVpDK/0SBuZhuqoKBD96UBTuLQ+/xP
         PTnIQjGtPFHpg==
Received: by earth.universe (Postfix, from userid 1000)
        id 70C833C0F9E; Thu, 18 Nov 2021 14:22:03 +0100 (CET)
Date:   Thu, 18 Nov 2021 14:22:03 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 01/16] power: supply: ab8500: Use core battery parser
Message-ID: <20211118132203.jkg65a53ya5oi6we@earth.universe>
References: <20211118021752.2262818-1-linus.walleij@linaro.org>
 <20211118021752.2262818-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="itu5z35x47vfnoiy"
Content-Disposition: inline
In-Reply-To: <20211118021752.2262818-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--itu5z35x47vfnoiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 18, 2021 at 03:17:37AM +0100, Linus Walleij wrote:
> This deploys the core battery DT parser to read the basic properties
> of the battery. We only use very little of it as we start out, but
> we will improve as we go along.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/power/supply/ab8500-bm.h      |  3 +--
>  drivers/power/supply/ab8500_bmdata.c  | 31 ++++++++++-----------------
>  drivers/power/supply/ab8500_charger.c | 17 ++++++++++-----
>  3 files changed, 24 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab85=
00-bm.h
> index d11405b7ee1a..33c7e15f5d96 100644
> --- a/drivers/power/supply/ab8500-bm.h
> +++ b/drivers/power/supply/ab8500-bm.h
> @@ -570,8 +570,7 @@ int ab8500_fg_inst_curr_start(struct ab8500_fg *di);
>  int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res);
>  int ab8500_fg_inst_curr_started(struct ab8500_fg *di);
>  int ab8500_fg_inst_curr_done(struct ab8500_fg *di);
> -int ab8500_bm_of_probe(struct device *dev,
> -		       struct device_node *np,
> +int ab8500_bm_of_probe(struct power_supply *psy,
>  		       struct ab8500_bm_data *bm);
> =20
>  extern struct platform_driver ab8500_fg_driver;
> diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/=
ab8500_bmdata.c
> index bfc1245d7912..d2a9e890c64c 100644
> --- a/drivers/power/supply/ab8500_bmdata.c
> +++ b/drivers/power/supply/ab8500_bmdata.c
> @@ -488,29 +488,22 @@ struct ab8500_bm_data ab8500_bm_data =3D {
>          .n_chg_in_curr          =3D ARRAY_SIZE(ab8500_charge_input_curr_=
map),
>  };
> =20
> -int ab8500_bm_of_probe(struct device *dev,
> -		       struct device_node *np,
> +int ab8500_bm_of_probe(struct power_supply *psy,
>  		       struct ab8500_bm_data *bm)
>  {
>  	const struct batres_vs_temp *tmp_batres_tbl;
> -	struct device_node *battery_node;
> -	const char *btech;
> +	struct power_supply_battery_info info;
> +	struct device *dev =3D &psy->dev;
> +	int ret;
>  	int i;
> =20
> -	battery_node =3D of_parse_phandle(np, "monitored-battery", 0);
> -	if (!battery_node) {
> -		dev_err(dev, "battery node or reference missing\n");
> -		return -EINVAL;
> +	ret =3D power_supply_get_battery_info(psy, &info);

The info struct potentially contains some HEAP allocated tables,
so you need to call power_supply_put_battery_info() once you no
longer need it.

> +	if (ret) {
> +		dev_err(dev, "cannot retrieve battery info\n");
> +		return ret;
>  	}
> =20
> -	btech =3D of_get_property(battery_node, "stericsson,battery-type", NULL=
);
> -	if (!btech) {
> -		dev_warn(dev, "missing property battery-name/type\n");
> -		of_node_put(battery_node);
> -		return -EINVAL;
> -	}
> -
> -	if (strncmp(btech, "LION", 4) =3D=3D 0) {
> +	if (info.technology =3D=3D POWER_SUPPLY_TECHNOLOGY_LION) {
>  		bm->no_maintenance  =3D true;
>  		bm->chg_unknown_bat =3D true;
>  		bm->bat_type[BATTERY_UNKNOWN].charge_full_design =3D 2600;
> @@ -520,8 +513,8 @@ int ab8500_bm_of_probe(struct device *dev,
>  		bm->bat_type[BATTERY_UNKNOWN].normal_vol_lvl     =3D 4200;
>  	}
> =20
> -	if (of_property_read_bool(battery_node, "thermistor-on-batctrl")) {
> -		if (strncmp(btech, "LION", 4) =3D=3D 0)
> +	if (of_property_read_bool(psy->of_node, "thermistor-on-batctrl")) {
> +		if (info.technology =3D=3D POWER_SUPPLY_TECHNOLOGY_LION)
>  			tmp_batres_tbl =3D temp_to_batres_tbl_9100;
>  		else
>  			tmp_batres_tbl =3D temp_to_batres_tbl_thermistor;
> @@ -536,7 +529,5 @@ int ab8500_bm_of_probe(struct device *dev,
>  	for (i =3D 0; i < bm->n_btypes; ++i)
>  		bm->bat_type[i].batres_tbl =3D tmp_batres_tbl;
> =20
> -	of_node_put(battery_node);
> -
>  	return 0;
>  }
> diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply=
/ab8500_charger.c
> index 15eadaf46f14..dd25bb5c498c 100644
> --- a/drivers/power/supply/ab8500_charger.c
> +++ b/drivers/power/supply/ab8500_charger.c
> @@ -3413,11 +3413,6 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
> =20
>  	di->bm =3D &ab8500_bm_data;
> =20
> -	ret =3D ab8500_bm_of_probe(dev, np, di->bm);
> -	if (ret) {
> -		dev_err(dev, "failed to get battery information\n");
> -		return ret;
> -	}
>  	di->autopower_cfg =3D of_property_read_bool(np, "autopower_cfg");
> =20
>  	/* get parent data */
> @@ -3490,9 +3485,11 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
>  	di->invalid_charger_detect_state =3D 0;
> =20
>  	/* AC and USB supply config */
> +	ac_psy_cfg.of_node =3D np;
>  	ac_psy_cfg.supplied_to =3D supply_interface;
>  	ac_psy_cfg.num_supplicants =3D ARRAY_SIZE(supply_interface);
>  	ac_psy_cfg.drv_data =3D &di->ac_chg;
> +	usb_psy_cfg.of_node =3D np;
>  	usb_psy_cfg.supplied_to =3D supply_interface;
>  	usb_psy_cfg.num_supplicants =3D ARRAY_SIZE(supply_interface);
>  	usb_psy_cfg.drv_data =3D &di->usb_chg;
> @@ -3610,6 +3607,16 @@ static int ab8500_charger_probe(struct platform_de=
vice *pdev)
>  		return PTR_ERR(di->usb_chg.psy);
>  	}
> =20
> +	/*
> +	 * Check what battery we have, since we always have the USB
> +	 * psy, use that as a handle.
> +	 */
> +	ret =3D ab8500_bm_of_probe(di->usb_chg.psy, di->bm);
> +	if (ret) {
> +		dev_err(dev, "failed to get battery information\n");

dev_err_probe()

-- Sebastian

> +		return ret;
> +	}
> +
>  	/* Identify the connected charger types during startup */
>  	charger_status =3D ab8500_charger_detect_chargers(di, true);
>  	if (charger_status & AC_PW_CONN) {
> --=20
> 2.31.1
>=20

--itu5z35x47vfnoiy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGWU3AACgkQ2O7X88g7
+prfXQ/3cRx9YEUA2+MAxKW+R0EqJqtaHdmo7C0lqLsS6EvuOm1Mc40sR4sZV7bJ
fdl1E/0whLF0RH/6Lx77+kBu/iOcrIvutEaHXxqo8jC4SfMM1rQrqnbaY4vX1g0J
WgIfR5lvxiRuBGU2AE05d9YmLdkF3jM/6JftfN2DlUgngR+vG3Heh1s3a6xblAb6
Mx6tijhR+/kDe65WBAwn6kKkglA+E0JXqtbSnlvPjft6cdOBj6ITe44SC0AbVBwE
H8Lj3YLZKIQQh3OxYjtWM13ltV5ihD2F9d3OHdM52MCwheEf7qyKBbGegf9c7Kcd
GCpCOnjLYGUVr9VnuIEG0TDAJm8YI/eBholAFr682Sg7iP60HIZQRTpZCABgJZ9G
J9evnBhnbzX+VFSmSMRHkpPsSLrgHd8fLy746xodKfZzRQWSi+fqDx0Nn0gUIaRb
Q6JsrZ/beXQQg3RPGqYHagnywuSOs5+57xyUvrGnLbiQrs+tnFE2D3AWUJVtXkIt
QDZGkOIzQ/RDeNCflB31zGvm3fe21/r7Zt+S7Cp2ESQA7X0j8S94pzTcrg54OtbN
/hy/zQ2kRfWGyY3XCYYC7PNpPACcFv2KouEEOScRTGEP6I3lTkWGBr7Z/DwLdfaF
eITD9+GVkhEiS+Ni+Xv/FNwK5tPQWxPSyGmoGEBrYV1wAfAvpA==
=yZol
-----END PGP SIGNATURE-----

--itu5z35x47vfnoiy--
