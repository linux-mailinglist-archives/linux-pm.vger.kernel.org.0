Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C130467EFC
	for <lists+linux-pm@lfdr.de>; Fri,  3 Dec 2021 21:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236868AbhLCU4r (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Dec 2021 15:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhLCU4q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Dec 2021 15:56:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5717EC061751;
        Fri,  3 Dec 2021 12:53:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 086011F472A8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638564801; bh=F9hZFfr0l+WJ6ZDCopxZ3/a/IXd9UCsEYWqWW7qxWRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ileE7zD0Ogmx7ajyJxdDtiNQ7NtsJ5/D4fZarANhoKOpgI8bZU8XhEQqUgH4Op/h5
         qcznLJR3hdrJAaVK9JzTA73IiNWerMaQUg/sDqjFAHoGmwEgAaB1UxW/algZG4HmMc
         HzMBpLrKSeR4Ufc8l8Nj7YdG4Kk7u7stmmgE/Cot7ONNMfrMbrpq1UmA6vD1OZW0IT
         zBwzFFjcqSyp1DszoQrIqLAs6EX+N19DUQRwIzqtwnuhyTFsprL9UM+qcxHOeJ6ysw
         UITWN0jToVPKsm0Lo8fPOu8du6QxRo/hw7oxRCDFPvvhXtSQg6wq1wFdfggwVbajhL
         Hqg53DSTyNvjQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 167E73C0CA8; Fri,  3 Dec 2021 21:53:19 +0100 (CET)
Date:   Fri, 3 Dec 2021 21:53:19 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 1/2] power: supply: ab8500: Standardize NTC battery temp
Message-ID: <20211203205319.aag27knjeapn5d2v@earth.universe>
References: <20211122234141.3356340-1-linus.walleij@linaro.org>
 <20211122234141.3356340-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xxwxyib36clh6qox"
Content-Disposition: inline
In-Reply-To: <20211122234141.3356340-2-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--xxwxyib36clh6qox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 23, 2021 at 12:41:40AM +0100, Linus Walleij wrote:
> Several batteries monitor the temperature of the battery using
> an NTC resistor. Add an NTC resistor resistance to temperature
> look-up table to struct power_supply_battery_info and use this
> in the AB8500 battery temperature driver to look up the battery
> temperature.
>=20
> Add a helper function in the power supply core:
> power_supply_ntc_resist2temp_simple(), which can use the
> NTC resistance table to look up and interpolate a temperature
> from the table.
>=20
> Fix up some of the confusing wording on the temperature to
> internal resistance table, and clarify what each resistance
> table is for.
>=20
> The AB8500 default NTC resistor is 47KOhm at 25 degrees
> Celsius and serves as a good example of how this usually works.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

This LGTM, but let's wait a bit to synchronize with the work
happening in the AXP driver.

-- Sebastian

>  drivers/power/supply/ab8500-bm.h         | 16 --------
>  drivers/power/supply/ab8500_bmdata.c     | 41 ++++++++++---------
>  drivers/power/supply/ab8500_btemp.c      | 45 ++------------------
>  drivers/power/supply/power_supply_core.c | 52 ++++++++++++++++++++++++
>  include/linux/power_supply.h             | 34 ++++++++++++++++
>  5 files changed, 111 insertions(+), 77 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab85=
00-bm.h
> index 57e1a8e27e51..90397f2a731f 100644
> --- a/drivers/power/supply/ab8500-bm.h
> +++ b/drivers/power/supply/ab8500-bm.h
> @@ -272,18 +272,6 @@ enum ab8500_adc_therm {
>  	AB8500_ADC_THERM_BATTEMP,
>  };
> =20
> -/**
> - * struct ab8500_res_to_temp - defines one point in a temp to res curve.=
 To
> - * be used in battery packs that combines the identification resistor wi=
th a
> - * NTC resistor.
> - * @temp:			battery pack temperature in Celsius
> - * @resist:			NTC resistor net total resistance
> - */
> -struct ab8500_res_to_temp {
> -	int temp;
> -	int resist;
> -};
> -
>  /* Forward declaration */
>  struct ab8500_fg;
> =20
> @@ -363,8 +351,6 @@ struct ab8500_maxim_parameters {
>   * @maint_b_chg_timer_h:	charge time in maintenance B state
>   * @low_high_cur_lvl:		charger current in temp low/high state in mA
>   * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
> - * @n_r_t_tbl_elements:		number of elements in r_to_t_tbl
> - * @r_to_t_tbl:			table containing resistance to temp points
>   */
>  struct ab8500_battery_type {
>  	int resis_high;
> @@ -377,8 +363,6 @@ struct ab8500_battery_type {
>  	int maint_b_chg_timer_h;
>  	int low_high_cur_lvl;
>  	int low_high_vol_lvl;
> -	int n_temp_tbl_elements;
> -	const struct ab8500_res_to_temp *r_to_t_tbl;
>  };
> =20
>  /**
> diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/=
ab8500_bmdata.c
> index 62953f9cb85a..aba459393ee6 100644
> --- a/drivers/power/supply/ab8500_bmdata.c
> +++ b/drivers/power/supply/ab8500_bmdata.c
> @@ -44,25 +44,25 @@ static struct power_supply_battery_ocv_table ocv_cap_=
tbl[] =3D {
>  };
> =20
>  /*
> - * Note that the res_to_temp table must be strictly sorted by falling
> + * Note that the ntc_res_to_temp_tbl table must be strictly sorted by fa=
lling
>   * resistance values to work.
>   */
> -static const struct ab8500_res_to_temp temp_tbl[] =3D {
> -	{-5, 214834},
> -	{ 0, 162943},
> -	{ 5, 124820},
> -	{10,  96520},
> -	{15,  75306},
> -	{20,  59254},
> -	{25,  47000},
> -	{30,  37566},
> -	{35,  30245},
> -	{40,  24520},
> -	{45,  20010},
> -	{50,  16432},
> -	{55,  13576},
> -	{60,  11280},
> -	{65,   9425},
> +static struct power_supply_ntc_resistance_temp_table ntc_res_to_temp_tbl=
[] =3D {
> +	{ .resistance_ohm =3D 214834, .temp =3D -5},
> +	{ .resistance_ohm =3D 162943, .temp =3D 0},
> +	{ .resistance_ohm =3D 124820, .temp =3D 5},
> +	{ .resistance_ohm =3D 96520, .temp =3D 10},
> +	{ .resistance_ohm =3D 75306, .temp =3D 15},
> +	{ .resistance_ohm =3D 59254, .temp =3D 20},
> +	{ .resistance_ohm =3D 47000, .temp =3D 25},
> +	{ .resistance_ohm =3D 37566, .temp =3D 30},
> +	{ .resistance_ohm =3D 30245, .temp =3D 35},
> +	{ .resistance_ohm =3D 24520, .temp =3D 40},
> +	{ .resistance_ohm =3D 20010, .temp =3D 45},
> +	{ .resistance_ohm =3D 16432, .temp =3D 50},
> +	{ .resistance_ohm =3D 13576, .temp =3D 55},
> +	{ .resistance_ohm =3D 11280, .temp =3D 60},
> +	{ .resistance_ohm =3D 9425, .temp =3D 65},
>  };
> =20
>  /*
> @@ -92,8 +92,6 @@ static struct ab8500_battery_type bat_type_thermistor_u=
nknown =3D {
>  	.maint_b_chg_timer_h =3D 200,
>  	.low_high_cur_lvl =3D 300,
>  	.low_high_vol_lvl =3D 4000,
> -	.n_temp_tbl_elements =3D ARRAY_SIZE(temp_tbl),
> -	.r_to_t_tbl =3D temp_tbl,
>  };
> =20
>  static const struct ab8500_bm_capacity_levels cap_levels =3D {
> @@ -217,6 +215,11 @@ int ab8500_bm_of_probe(struct power_supply *psy,
>  		bi->resist_table_size =3D ARRAY_SIZE(temp_to_batres_tbl_thermistor);
>  	}
> =20
> +	if (!bi->ntc_resist_table) {
> +		bi->ntc_resist_table =3D ntc_res_to_temp_tbl;
> +		bi->ntc_resist_table_size =3D ARRAY_SIZE(ntc_res_to_temp_tbl);
> +	}
> +
>  	if (!bi->ocv_table[0]) {
>  		/* Default capacity table at say 25 degrees Celsius */
>  		bi->ocv_temp[0] =3D 25;
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index 20253b8a7fe9..79528c18618d 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -407,42 +407,6 @@ static int ab8500_btemp_get_batctrl_res(struct ab850=
0_btemp *di)
>  	return res;
>  }
> =20
> -/**
> - * ab8500_btemp_res_to_temp() - resistance to temperature
> - * @di:		pointer to the ab8500_btemp structure
> - * @tbl:	pointer to the resiatance to temperature table
> - * @tbl_size:	size of the resistance to temperature table
> - * @res:	resistance to calculate the temperature from
> - *
> - * This function returns the battery temperature in degrees Celsius
> - * based on the NTC resistance.
> - */
> -static int ab8500_btemp_res_to_temp(struct ab8500_btemp *di,
> -	const struct ab8500_res_to_temp *tbl, int tbl_size, int res)
> -{
> -	int i;
> -	/*
> -	 * Calculate the formula for the straight line
> -	 * Simple interpolation if we are within
> -	 * the resistance table limits, extrapolate
> -	 * if resistance is outside the limits.
> -	 */
> -	if (res > tbl[0].resist)
> -		i =3D 0;
> -	else if (res <=3D tbl[tbl_size - 1].resist)
> -		i =3D tbl_size - 2;
> -	else {
> -		i =3D 0;
> -		while (!(res <=3D tbl[i].resist &&
> -			res > tbl[i + 1].resist))
> -			i++;
> -	}
> -
> -	return fixp_linear_interpolate(tbl[i].resist, tbl[i].temp,
> -				       tbl[i + 1].resist, tbl[i + 1].temp,
> -				       res);
> -}
> -
>  /**
>   * ab8500_btemp_measure_temp() - measure battery temperature
>   * @di:		pointer to the ab8500_btemp structure
> @@ -451,6 +415,7 @@ static int ab8500_btemp_res_to_temp(struct ab8500_bte=
mp *di,
>   */
>  static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
>  {
> +	struct power_supply_battery_info *bi =3D &di->bm->bi;
>  	int temp, ret;
>  	static int prev;
>  	int rbat, rntc, vntc;
> @@ -469,9 +434,7 @@ static int ab8500_btemp_measure_temp(struct ab8500_bt=
emp *di)
>  			return BTEMP_THERMAL_LOW_LIMIT;
>  		}
> =20
> -		temp =3D ab8500_btemp_res_to_temp(di,
> -			di->bm->bat_type->r_to_t_tbl,
> -			di->bm->bat_type->n_temp_tbl_elements, rbat);
> +		temp =3D power_supply_ntc_resist2temp_simple(bi, rbat);
>  	} else {
>  		ret =3D iio_read_channel_processed(di->btemp_ball, &vntc);
>  		if (ret < 0) {
> @@ -486,9 +449,7 @@ static int ab8500_btemp_measure_temp(struct ab8500_bt=
emp *di)
>  		 */
>  		rntc =3D 230000 * vntc / (VTVOUT_V - vntc);
> =20
> -		temp =3D ab8500_btemp_res_to_temp(di,
> -			di->bm->bat_type->r_to_t_tbl,
> -			di->bm->bat_type->n_temp_tbl_elements, rntc);
> +		temp =3D power_supply_ntc_resist2temp_simple(bi, rntc);
>  		prev =3D temp;
>  	}
>  	dev_dbg(di->dev, "Battery temperature is %d\n", temp);
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 2723d7d0ced3..a870c3fe032c 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -589,6 +589,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  	info->temp_max                       =3D INT_MAX;
>  	info->factory_internal_resistance_uohm  =3D -EINVAL;
>  	info->resist_table =3D NULL;
> +	info->ntc_resist_table =3D NULL;
> =20
>  	for (index =3D 0; index < POWER_SUPPLY_OCV_TEMP_MAX; index++) {
>  		info->ocv_table[index]       =3D NULL;
> @@ -806,6 +807,57 @@ int power_supply_temp2resist_simple(struct power_sup=
ply_resistance_temp_table *t
>  }
>  EXPORT_SYMBOL_GPL(power_supply_temp2resist_simple);
> =20
> +/**
> + * power_supply_ntc_resist2temp_simple() - find the battery temperature
> + * @info: battery information
> + * @resistance_ohm: Current NTC resistance value in microohm
> + *
> + * This helper function is used to look up battery internal temperature
> + * according to current NTC resistance value from one NTC resistance tab=
le.
> + * The NTC resistance table must be ordered descending by resistance:
> + * largest resistance with lowest temperature first, lowest resistance w=
ith
> + * highest temperature last. The function will interpolate to find the
> + * corresponding temperature.
> + *
> + * Return: the battery temperature.
> + */
> +int power_supply_ntc_resist2temp_simple(struct power_supply_battery_info=
 *info,
> +					int resistance_ohm)
> +{
> +	struct power_supply_ntc_resistance_temp_table *table;
> +	int i, high, low;
> +	int table_len;
> +
> +	table =3D info->ntc_resist_table;
> +	table_len =3D info->ntc_resist_table_size;
> +
> +	if (!table || !table_len) {
> +		pr_err("Empty battery NTC resistance table, assume 25 degrees\n");
> +		return 25;
> +	}
> +	if (!resistance_ohm)
> +		pr_info("Battery NTC resistance 0, this is unlikely\n");
> +
> +	/* Break loop at table_len - 1 because that is the highest index */
> +	for (i =3D 0; i < table_len - 1; i++)
> +		if (resistance_ohm > table[i].resistance_ohm)
> +			break;
> +
> +	/* The library function will deal with high =3D=3D low */
> +	if ((i =3D=3D 0) || (i =3D=3D (table_len - 1)))
> +		high =3D i;
> +	else
> +		high =3D i - 1;
> +	low =3D i;
> +
> +	return fixp_linear_interpolate(table[low].resistance_ohm,
> +				       table[low].temp,
> +				       table[high].resistance_ohm,
> +				       table[high].temp,
> +				       resistance_ohm);
> +}
> +EXPORT_SYMBOL_GPL(power_supply_ntc_resist2temp_simple);
> +
>  /**
>   * power_supply_ocv2cap_simple() - find the battery capacity
>   * @table: Pointer to battery OCV lookup table
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index b5079109ac00..a0da806185b5 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -335,11 +335,29 @@ struct power_supply_battery_ocv_table {
>  	int capacity;	/* percent */
>  };
> =20
> +/**
> + * struct power_supply_resistance_temp_table - correlate temperature to =
resistance
> + * @temp: the internal temperature of the battery in degrees Celsius
> + * @resistance: the percentage of the factory internal resistance at this
> + *   temperature, usually nomimal factory resistance is 100 percent at 25
> + *   degrees Celsius, lower at higher temperature and higher at lower
> + *   temperature.
> + */
>  struct power_supply_resistance_temp_table {
>  	int temp;	/* celsius */
>  	int resistance;	/* internal resistance percent */
>  };
> =20
> +/**
> + * struct power_supply_ntc_resistance_temp_table - correlate NTC to temp
> + * @resistance: the NTC resistance in ohm
> + * @temp: the corresponding temperature in degrees Celsius
> + */
> +struct power_supply_ntc_resistance_temp_table {
> +	int resistance_ohm;
> +	int temp;
> +};
> +
>  #define POWER_SUPPLY_OCV_TEMP_MAX 20
> =20
>  /**
> @@ -426,6 +444,18 @@ struct power_supply_resistance_temp_table {
>   *   by temperature: highest temperature with lowest resistance first, l=
owest
>   *   temperature with highest resistance last.
>   * @resist_table_size: the number of items in the resist_table.
> + * @ntc_resist_table: this is a table that correlates a resistance of a =
negative
> + *   temperature coefficient (NTC) resistor to an internal temperature o=
f a
> + *   battery. This can be achieved by a separate thermistor to
> + *   supply voltage on a third terminal on a battery which is the most
> + *   reliable. An external thermistor can also be used sometimes. Knowin=
g the
> + *   temperature of the battery is usually necessary to perform a lookup=
 in the
> + *   resist_table to determine the internal resistance of the battery, a=
nd
> + *   to find the right ocv_table to determine the capacity of the batter=
y.
> + *   The NTC resistance table must be ordered descending by resistance:
> + *   largest resistance with lowest temperature first, lowest resistance=
 with
> + *   highest temperature last.
> + * @ntc_resist_table_size: the number of items in the ntc_resist_table.
>   *
>   * This is the recommended struct to manage static battery parameters,
>   * populated by power_supply_get_battery_info(). Most platform drivers s=
hould
> @@ -546,6 +576,8 @@ struct power_supply_battery_info {
>  	int ocv_table_size[POWER_SUPPLY_OCV_TEMP_MAX];
>  	struct power_supply_resistance_temp_table *resist_table;
>  	int resist_table_size;
> +	struct power_supply_ntc_resistance_temp_table *ntc_resist_table;
> +	int ntc_resist_table_size;
>  };
> =20
>  extern struct atomic_notifier_head power_supply_notifier;
> @@ -587,6 +619,8 @@ extern int power_supply_batinfo_ocv2cap(struct power_=
supply_battery_info *info,
>  extern int
>  power_supply_temp2resist_simple(struct power_supply_resistance_temp_tabl=
e *table,
>  				int table_len, int temp);
> +extern int power_supply_ntc_resist2temp_simple(struct power_supply_batte=
ry_info *info,
> +					       int resistance_ohm);
>  extern void power_supply_changed(struct power_supply *psy);
>  extern int power_supply_am_i_supplied(struct power_supply *psy);
>  extern int power_supply_set_input_current_limit_from_supplier(
> --=20
> 2.31.1
>=20

--xxwxyib36clh6qox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGqg74ACgkQ2O7X88g7
+pomPw//XmOL+vSVw+qN6cvuN3TWu+sgWesBOrt8SjNpzNpxV9bADCENpWG0EcwH
CKcw0l6qEwo1pm8xBcy9uq5mk4UotROtIM48G09qJaF2EvSclXjdN0p1hHeWOGqs
WFgNOGRolNBMhiz7JiI8Oqypc1uWqKmLUuE6V4eA/H3/D03zxGr6UlK5VAkAHyfn
J5sDnWQ205RSx3Ugb89mMjpTFIl+tO/hn2wa8BhZ88KBLjr0L2bt7hXePFU99NXF
n8XKNUmgnB2/6DliOCsHqnmm7n/ojtvstzRdQgnqUGx+I53kw3ldqbhXVBN8zZD3
odsm6CzuKv9LrFxvJGcixlNKlnyM/1rpJGJn4ZSScBODW5W7vdSfRCNa2beZmNvp
PEUXX08Ti1BEvTKuM+ns/op2bLYH4ZUiWtXJqp711JWWA30zMxLwMHrWKEzPSdb8
ca/afI6vw36A4AtPJXbtzx+6gUq/jTsGUGsONFKlCkYSZF0hW/IyGkiyAyUulgfK
0XFBE5/37lH+P5W9wrRVf/HQUGfjLOQviMaxZtUZTf4xCXK6cVB7HU5si0KjSG7b
NA1YzQDvg9+vlrZlyLVu1qAsNATqRqJXxfb97Y3wLNKYrs6Xc39xCpZLDPqIMDDS
F78zn6TYJfoL0inR+RVg8hFesdm+JiCnl90JmYLwsmBUXhNOW/Y=
=MaRD
-----END PGP SIGNATURE-----

--xxwxyib36clh6qox--
