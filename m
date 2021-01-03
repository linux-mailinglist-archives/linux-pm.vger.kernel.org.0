Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38B42E89D2
	for <lists+linux-pm@lfdr.de>; Sun,  3 Jan 2021 02:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbhACB0z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 Jan 2021 20:26:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:54020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhACB0x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 2 Jan 2021 20:26:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 979E32078E;
        Sun,  3 Jan 2021 01:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609637172;
        bh=Bz8jQoVntb6d51Z+BpALkIUssMtnAukuyDITFqTtLIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H/cWgRmmz6VkdU49oww8gqmMzUnVmslKhklOIyLbmkx8ZsLFL0mDBdp31IawXZzCl
         coaRADY2GkKufP1rmueky8DWbmi0gXcCku4n89VuAMOeoS9V0YWPriszz8YiqobeKI
         1uDbtK8gB8gD5pLAp/A/bZB38S21nlCuXyM5lkF+nIOgkUp/Cg6dy7OJMp3DXeL56q
         rekRFIcCzGP7u16yq0TMsrtONhDj6gypl2DttA2KHWf/QN++r/Y3JmITOG3nxB65zt
         CLbCnZx7iiM4IcJIKViNb04GSKN5VWenqQlvWQWPpjOytXXSkycZO918zzIq0tFdq6
         7eI9JEr3pwQAA==
Received: by earth.universe (Postfix, from userid 1000)
        id 9E8D73C0C94; Sun,  3 Jan 2021 02:26:10 +0100 (CET)
Date:   Sun, 3 Jan 2021 02:26:10 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Cc:     robh+dt@kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmurphy@ti.com
Subject: Re: [PATCH v7 2/2] power: supply: bq256xx: Introduce the BQ256XX
 charger driver
Message-ID: <20210103012610.exkkwoqz3745bh2u@earth.universe>
References: <20201230230116.29697-1-r-rivera-matos@ti.com>
 <20201230230116.29697-3-r-rivera-matos@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kregzxwqskd3mmqq"
Content-Disposition: inline
In-Reply-To: <20201230230116.29697-3-r-rivera-matos@ti.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kregzxwqskd3mmqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Wed, Dec 30, 2020 at 05:01:16PM -0600, Ricardo Rivera-Matos wrote:
> The BQ256XX family of devices are highly integrated buck chargers
> for single cell batteries.
>=20
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>=20
> v5 - adds power_supply_put_battery_info() and devm_add_action_or_rest() c=
alls
>=20
> v6 - implements bq256xx_remove function
>=20
> v7 - applies various fixes
>=20
>    - implements clamp() API
>=20
>    - implements memcmp() API
>=20
>    - changes cache_type to REGACHE_FLAT
>=20
>    - changes bq256xx_probe to properly unregister device
>=20
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---

Thanks, looks mostly good now.

>  drivers/power/supply/Kconfig           |   11 +
>  drivers/power/supply/Makefile          |    1 +
>  drivers/power/supply/bq256xx_charger.c | 1747 ++++++++++++++++++++++++
>  3 files changed, 1759 insertions(+)
>  create mode 100644 drivers/power/supply/bq256xx_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 44d3c8512fb8..87d852914bc2 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -618,6 +618,17 @@ config CHARGER_BQ25890
>  	help
>  	  Say Y to enable support for the TI BQ25890 battery charger.
> =20
> +config CHARGER_BQ256XX
> +	tristate "TI BQ256XX battery charger driver"
> +	depends on I2C
> +	depends on GPIOLIB || COMPILE_TEST
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the TI BQ256XX battery chargers. The
> +	  BQ256XX family of devices are highly-integrated, switch-mode battery
> +	  charge management and system power path management devices for single
> +	  cell Li-ion and Li-polymer batteries.
> +
>  config CHARGER_SMB347
>  	tristate "Summit Microelectronics SMB347 Battery Charger"
>  	depends on I2C

Please rebase to current power-supply for-next branch, Kconfig and
Makefile diff does not apply because of one additional BQ device.

> [...]
> +static void bq256xx_usb_work(struct work_struct *data)
> +{
> +	struct bq256xx_device *bq =3D
> +			container_of(data, struct bq256xx_device, usb_work);
> +
> +	switch (bq->usb_event) {
> +	case USB_EVENT_ID:
> +		break;
> +

spurious newline, please remove!

> +	case USB_EVENT_NONE:
> +		power_supply_changed(bq->charger);
> +		break;
> +	default:
> +		dev_err(bq->dev, "Error switching to charger mode.\n");
> +		break;
> +	}
> +}
> +

> [...]

> +static int bq256xx_hw_init(struct bq256xx_device *bq)
> +{
> +	struct power_supply_battery_info bat_info =3D { };
> +	int wd_reg_val =3D BQ256XX_WATCHDOG_DIS;
> +	int ret =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < BQ256XX_NUM_WD_VAL; i++) {
> +		if (bq->watchdog_timer > bq256xx_watchdog_time[i] &&
> +		    bq->watchdog_timer < bq256xx_watchdog_time[i + 1])
> +			wd_reg_val =3D i;
> +	}
> +	ret =3D regmap_update_bits(bq->regmap, BQ256XX_CHARGER_CONTROL_1,
> +				 BQ256XX_WATCHDOG_MASK, wd_reg_val <<
> +						BQ256XX_WDT_BIT_SHIFT);
> +
> +	ret =3D power_supply_get_battery_info(bq->charger, &bat_info);
> +	if (ret) {
> +		dev_warn(bq->dev, "battery info missing, default values will be applie=
d\n");
> +
> +		bat_info.constant_charge_current_max_ua =3D
> +				bq->chip_info->bq256xx_def_ichg;
> +
> +		bat_info.constant_charge_voltage_max_uv =3D
> +				bq->chip_info->bq256xx_def_vbatreg;
> +
> +		bat_info.precharge_current_ua =3D
> +				bq->chip_info->bq256xx_def_iprechg;
> +
> +		bat_info.charge_term_current_ua =3D
> +				bq->chip_info->bq256xx_def_iterm;
> +
> +		bq->init_data.ichg_max =3D
> +				bq->chip_info->bq256xx_max_ichg;
> +
> +		bq->init_data.vbatreg_max =3D
> +				bq->chip_info->bq256xx_max_vbatreg;
> +	} else {
> +		bq->init_data.ichg_max =3D
> +			bat_info.constant_charge_current_max_ua;
> +
> +		bq->init_data.vbatreg_max =3D
> +			bat_info.constant_charge_voltage_max_uv;
> +	}
> +
> +	ret =3D bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq->chip_info->bq256xx_set_iindpm(bq, bq->init_data.iindpm);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq->chip_info->bq256xx_set_ichg(bq,
> +				bat_info.constant_charge_current_max_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq->chip_info->bq256xx_set_iprechg(bq,
> +				bat_info.precharge_current_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq->chip_info->bq256xx_set_vbatreg(bq,
> +				bat_info.constant_charge_voltage_max_uv);
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq->chip_info->bq256xx_set_iterm(bq,
> +				bat_info.charge_term_current_ua);
> +	if (ret)
> +		goto err_out;
> +
> +	power_supply_put_battery_info(bq->charger, &bat_info);
> +
> +	return 0;
> +
> +err_out:
> +	return ret;

please return error code directly instead of adding this useless
goto.

> [...]

-- Sebastian

--kregzxwqskd3mmqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl/xHS4ACgkQ2O7X88g7
+ppMaw/+LL/6dRFRi5RSXmt4yxDjFQuDRvP0Fa2mXCW8NDxS9y9QP9UrM8uGGbVW
V45cqW0T8h18zJD6oe0mFLO7E1XTUe5+O51ZGtskVdjt4eYjkZr3CxvQfkGswDsG
Azumr60smGHo+XIvlOscPMg5/SbVxee8qkCUM3vSUsArYGWYazxviQFfHFeanypQ
2sG600HAzaY7AEQluNE0AOokUhV5mgixu3qhgopFFTyUoHOB+YSI2vMG7TdBL5E9
+YT5C1KjNt2sF2DaP2x+CtJU8xIAREjLUGPECzQJGkZCoruO/qLgSOW0iS+u3iqy
SbFCvyOjZwJQv5jun7aUjmsZlpgvk++2SHmEFwqYcu85TAS/mII72T1zPLpwaT7k
qioNSSy56RtsF7HKbRKWzmyCjWif/SFQS/2PNkjwqJDZX2Ql5Gq01LmQ4r+1ch/K
h7ZZBoWbf4oxhGgPRWmrbOERWuE4Vn4ZSRzEgKr6BQ3L8E5Hosdue8+sBeZIsjhT
xFIvHrTh7dZMVmDiwdTLbHCXdTksw53OqfGBhJ7z97FPHqEL87fOHmx3TQN86P70
oaimLTDS8tqbLPUeNQVwweROmXEvu/OQKIdc90Aodc9U8sJ75f0V2DyMW2PoFjX6
32Q4i6sph1oC/l/SXQNwN7ceHKL6G9uPeK4hY5+Z75l54qA8eYs=
=LPL1
-----END PGP SIGNATURE-----

--kregzxwqskd3mmqq--
