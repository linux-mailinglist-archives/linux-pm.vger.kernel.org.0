Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6361467F06
	for <lists+linux-pm@lfdr.de>; Fri,  3 Dec 2021 22:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbhLCVFg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Dec 2021 16:05:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60968 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243206AbhLCVFg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Dec 2021 16:05:36 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 474101F472CE
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638565329; bh=EDDdAydqHoi1MgcKpclcjxSqHQlsIWCf8EkcpYm31FI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4yZgTubt+idXUK4kkxASZsldfTaoO2iNU/ty0HC2w2arABpzC9G/8jXEvFUcW9bz
         TPXq1S261U1hCcDQT6NJWJdLSPdm9NKUZCBBpPMujPHuhOxYgCTD7vW4SXi+Z0rAv5
         WwPokNfuBqhNDE1yOKZyTM8Nsbn4zaWhv5snlxfVgXER7ERXP3BA+s0FvqeGIAdQUl
         IeoyWRGP1igL/UYw7jj6NwbZVffp2FtAgOAttM7N7d6jhFKt+M6zYp4prGlyZ1BHez
         kECFh1B6V6grnH8pgf7T/NU+ZHBtoybLlpFqE3PbJ0dmfGC+Wcot0WhMxrlIzOnj0I
         +hpqXow3XDPkQ==
Received: by earth.universe (Postfix, from userid 1000)
        id CD7893C0CA8; Fri,  3 Dec 2021 22:02:06 +0100 (CET)
Date:   Fri, 3 Dec 2021 22:02:06 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Cooper <codekipper@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: ab8500: Standardize maintenance
 charging
Message-ID: <20211203210206.6b5cxb4i63j5jpv7@earth.universe>
References: <20211122234141.3356340-1-linus.walleij@linaro.org>
 <20211122234141.3356340-3-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="acjulbkwfxb3x5fl"
Content-Disposition: inline
In-Reply-To: <20211122234141.3356340-3-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--acjulbkwfxb3x5fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 23, 2021 at 12:41:41AM +0100, Linus Walleij wrote:
> Maintenance charging is the phase of keeping up the charge
> after the battery has charged fully using CC/CV charging.
>=20
> This can be done in many successive phases and is usually
> done with a slightly lower constant voltage than CV, and
> a slightly lower allowed current.
>=20
> Add an array of maintenance charging points each with a
> current, voltage and safety timer, and add helper functions
> to use these. Migrate the AB8500 code over.
>=20
> This is used in several Samsung products using the AB8500
> and these batteries and their complete parameters will
> be added later as full examples, but the default battery
> in the AB8500 code serves as a reasonable example so far.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

I wonder if this will ever be used by any other driver. Having
multiple maintanence states seems to be very specific to the
ab8500 driver stack. But the code itself looks ok and considering
this does not expose any (potentially unfixable) userspace ABI
and improves the AB8500 mess I'm fine with it.

-- Sebastian

>  drivers/power/supply/ab8500-bm.h         | 14 ------
>  drivers/power/supply/ab8500_bmdata.c     | 27 +++++++---
>  drivers/power/supply/ab8500_chargalg.c   | 41 +++++++++++----
>  drivers/power/supply/power_supply_core.c | 11 ++++
>  include/linux/power_supply.h             | 64 ++++++++++++++++++++++++
>  5 files changed, 126 insertions(+), 31 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab85=
00-bm.h
> index 90397f2a731f..67acf4c72569 100644
> --- a/drivers/power/supply/ab8500-bm.h
> +++ b/drivers/power/supply/ab8500-bm.h
> @@ -343,24 +343,12 @@ struct ab8500_maxim_parameters {
>   * struct ab8500_battery_type - different batteries supported
>   * @resis_high:			battery upper resistance limit
>   * @resis_low:			battery lower resistance limit
> - * @maint_a_cur_lvl:		charger current in maintenance A state in mA
> - * @maint_a_vol_lvl:		charger voltage in maintenance A state in mV
> - * @maint_a_chg_timer_h:	charge time in maintenance A state
> - * @maint_b_cur_lvl:		charger current in maintenance B state in mA
> - * @maint_b_vol_lvl:		charger voltage in maintenance B state in mV
> - * @maint_b_chg_timer_h:	charge time in maintenance B state
>   * @low_high_cur_lvl:		charger current in temp low/high state in mA
>   * @low_high_vol_lvl:		charger voltage in temp low/high state in mV'
>   */
>  struct ab8500_battery_type {
>  	int resis_high;
>  	int resis_low;
> -	int maint_a_cur_lvl;
> -	int maint_a_vol_lvl;
> -	int maint_a_chg_timer_h;
> -	int maint_b_cur_lvl;
> -	int maint_b_vol_lvl;
> -	int maint_b_chg_timer_h;
>  	int low_high_cur_lvl;
>  	int low_high_vol_lvl;
>  };
> @@ -405,7 +393,6 @@ struct ab8500_bm_charger_parameters {
>   * @usb_safety_tmr_h	safety timer for usb charger
>   * @bkup_bat_v		voltage which we charge the backup battery with
>   * @bkup_bat_i		current which we charge the backup battery with
> - * @no_maintenance	indicates that maintenance charging is disabled
>   * @capacity_scaling    indicates whether capacity scaling is to be used
>   * @ab8500_adc_therm	placement of thermistor, batctrl or battemp adc
>   * @chg_unknown_bat	flag to enable charging of unknown batteries
> @@ -431,7 +418,6 @@ struct ab8500_bm_data {
>  	int usb_safety_tmr_h;
>  	int bkup_bat_v;
>  	int bkup_bat_i;
> -	bool no_maintenance;
>  	bool capacity_scaling;
>  	bool chg_unknown_bat;
>  	bool enable_overshoot;
> diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/=
ab8500_bmdata.c
> index aba459393ee6..fe3a316ce643 100644
> --- a/drivers/power/supply/ab8500_bmdata.c
> +++ b/drivers/power/supply/ab8500_bmdata.c
> @@ -80,16 +80,25 @@ static struct power_supply_resistance_temp_table temp=
_to_batres_tbl_thermistor[]
>  	{ .temp =3D -20, .resistance =3D 198 /* 595 mOhm */ },
>  };
> =20
> +struct power_supply_maintenance_charge_table maint_charge_table[] =3D {
> +	{
> +		/* Maintenance charging phase A, 60 hours */
> +		.charge_current_max_ua =3D 400000,
> +		.charge_voltage_max_uv =3D 4050000,
> +		.charge_safety_timer_minutes =3D 60*60,
> +	},
> +	{
> +		/* Maintenance charging phase B, 200 hours */
> +		.charge_current_max_ua =3D 400000,
> +		.charge_voltage_max_uv =3D 4000000,
> +		.charge_safety_timer_minutes =3D 200*60,
> +	}
> +};
> +
>  /* Default battery type for reference designs is the unknown type */
>  static struct ab8500_battery_type bat_type_thermistor_unknown =3D {
>  	.resis_high =3D 0,
>  	.resis_low =3D 0,
> -	.maint_a_cur_lvl =3D 400,
> -	.maint_a_vol_lvl =3D 4050,
> -	.maint_a_chg_timer_h =3D 60,
> -	.maint_b_cur_lvl =3D 400,
> -	.maint_b_vol_lvl =3D 4000,
> -	.maint_b_chg_timer_h =3D 200,
>  	.low_high_cur_lvl =3D 300,
>  	.low_high_vol_lvl =3D 4000,
>  };
> @@ -146,7 +155,6 @@ struct ab8500_bm_data ab8500_bm_data =3D {
>  	.usb_safety_tmr_h       =3D 4,
>  	.bkup_bat_v             =3D BUP_VCH_SEL_2P6V,
>  	.bkup_bat_i             =3D BUP_ICH_SEL_150UA,
> -	.no_maintenance         =3D false,
>  	.capacity_scaling       =3D false,
>  	.adc_therm              =3D AB8500_ADC_THERM_BATCTRL,
>  	.chg_unknown_bat        =3D false,
> @@ -204,6 +212,11 @@ int ab8500_bm_of_probe(struct power_supply *psy,
>  		/* Charging stops when we drop below this current */
>  		bi->charge_term_current_ua =3D 200000;
> =20
> +	if (!bi->maintenance_charge || !bi->maintenance_charge_size) {
> +		bi->maintenance_charge =3D maint_charge_table;
> +		bi->maintenance_charge_size =3D ARRAY_SIZE(maint_charge_table);
> +	}
> +
>  	/*
>  	 * Internal resistance and factory resistance are tightly coupled
>  	 * so both MUST be defined or we fall back to defaults.
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index 86d740ce3a63..a86b714d4f2c 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -484,7 +484,7 @@ static void ab8500_chargalg_stop_safety_timer(struct =
ab8500_chargalg *di)
>  /**
>   * ab8500_chargalg_start_maintenance_timer() - Start charging maintenanc=
e timer
>   * @di:		pointer to the ab8500_chargalg structure
> - * @duration:	duration of ther maintenance timer in hours
> + * @duration:	duration of ther maintenance timer in minutes
>   *
>   * The maintenance timer is used to maintain the charge in the battery o=
nce
>   * the battery is considered full. These timers are chosen to match the
> @@ -493,9 +493,10 @@ static void ab8500_chargalg_stop_safety_timer(struct=
 ab8500_chargalg *di)
>  static void ab8500_chargalg_start_maintenance_timer(struct ab8500_charga=
lg *di,
>  	int duration)
>  {
> +	/* Set a timer in minutes with a 30 second range */
>  	hrtimer_set_expires_range(&di->maintenance_timer,
> -		ktime_set(duration * ONE_HOUR_IN_SECONDS, 0),
> -		ktime_set(FIVE_MINUTES_IN_SECONDS, 0));
> +		ktime_set(duration * 60, 0),
> +		ktime_set(30, 0));
>  	di->events.maintenance_timer_expired =3D false;
>  	hrtimer_start_expires(&di->maintenance_timer, HRTIMER_MODE_REL);
>  }
> @@ -1300,6 +1301,7 @@ static void ab8500_chargalg_external_power_changed(=
struct power_supply *psy)
>  static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
>  {
>  	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_maintenance_charge_table *mt;
>  	int charger_status;
>  	int ret;
>  	int curr_step_lvl_ua;
> @@ -1537,7 +1539,12 @@ static void ab8500_chargalg_algorithm(struct ab850=
0_chargalg *di)
>  		handle_maxim_chg_curr(di);
>  		if (di->charge_status =3D=3D POWER_SUPPLY_STATUS_FULL &&
>  			di->maintenance_chg) {
> -			if (di->bm->no_maintenance)
> +			/*
> +			 * The battery is fully charged, check if we support
> +			 * maintenance charging else go back to waiting for
> +			 * the recharge voltage limit.
> +			 */
> +			if (power_supply_supports_maintenance_charging(bi))
>  				ab8500_chargalg_state_to(di,
>  					STATE_WAIT_FOR_RECHARGE_INIT);
>  			else
> @@ -1558,12 +1565,19 @@ static void ab8500_chargalg_algorithm(struct ab85=
00_chargalg *di)
>  		break;
> =20
>  	case STATE_MAINTENANCE_A_INIT:
> +		mt =3D power_supply_get_maintenance_charging_setting(bi, 0);
> +		if (!mt) {
> +			/* No maintenance A state, go back to normal */
> +			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
> +			power_supply_changed(di->chargalg_psy);
> +			break;
> +		}
>  		ab8500_chargalg_stop_safety_timer(di);
>  		ab8500_chargalg_start_maintenance_timer(di,
> -			di->bm->bat_type->maint_a_chg_timer_h);
> +			mt->charge_safety_timer_minutes);
>  		ab8500_chargalg_start_charging(di,
> -			di->bm->bat_type->maint_a_vol_lvl,
> -			di->bm->bat_type->maint_a_cur_lvl);
> +			mt->charge_voltage_max_uv,
> +			mt->charge_current_max_ua);
>  		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_A);
>  		power_supply_changed(di->chargalg_psy);
>  		fallthrough;
> @@ -1576,11 +1590,18 @@ static void ab8500_chargalg_algorithm(struct ab85=
00_chargalg *di)
>  		break;
> =20
>  	case STATE_MAINTENANCE_B_INIT:
> +		mt =3D power_supply_get_maintenance_charging_setting(bi, 1);
> +		if (!mt) {
> +			/* No maintenance B state, go back to normal */
> +			ab8500_chargalg_state_to(di, STATE_NORMAL_INIT);
> +			power_supply_changed(di->chargalg_psy);
> +			break;
> +		}
>  		ab8500_chargalg_start_maintenance_timer(di,
> -			di->bm->bat_type->maint_b_chg_timer_h);
> +			mt->charge_safety_timer_minutes);
>  		ab8500_chargalg_start_charging(di,
> -			di->bm->bat_type->maint_b_vol_lvl,
> -			di->bm->bat_type->maint_b_cur_lvl);
> +			mt->charge_voltage_max_uv,
> +			mt->charge_current_max_ua);
>  		ab8500_chargalg_state_to(di, STATE_MAINTENANCE_B);
>  		power_supply_changed(di->chargalg_psy);
>  		fallthrough;
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index a870c3fe032c..b3820f087856 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -581,6 +581,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
>  	info->charge_term_current_ua         =3D -EINVAL;
>  	info->constant_charge_current_max_ua =3D -EINVAL;
>  	info->constant_charge_voltage_max_uv =3D -EINVAL;
> +	info->maintenance_charge             =3D NULL;
>  	info->temp_ambient_alert_min         =3D INT_MIN;
>  	info->temp_ambient_alert_max         =3D INT_MAX;
>  	info->temp_alert_min                 =3D INT_MIN;
> @@ -858,6 +859,16 @@ int power_supply_ntc_resist2temp_simple(struct power=
_supply_battery_info *info,
>  }
>  EXPORT_SYMBOL_GPL(power_supply_ntc_resist2temp_simple);
> =20
> +struct power_supply_maintenance_charge_table *
> +power_supply_get_maintenance_charging_setting(struct power_supply_batter=
y_info *info,
> +					      int index)
> +{
> +	if (index >=3D info->maintenance_charge_size)
> +		return NULL;
> +	return &info->maintenance_charge[index];
> +}
> +EXPORT_SYMBOL_GPL(power_supply_get_maintenance_charging_setting);
> +
>  /**
>   * power_supply_ocv2cap_simple() - find the battery capacity
>   * @table: Pointer to battery OCV lookup table
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index a0da806185b5..c6f379715cb1 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -358,6 +358,52 @@ struct power_supply_ntc_resistance_temp_table {
>  	int temp;
>  };
> =20
> +/**
> + * struct power_supply_maintenance_charge_table - setting for maintenace=
 charging
> + * @charge_current_max_ua: maintenance charging current that is used to =
keep
> + *   the charge of the battery full as current is consumed after full ch=
arging.
> + *   The corresponding charge_voltage_max_uv is used as a safeguard: whe=
n we
> + *   reach this voltage the maintenance charging current is turned off. =
It is
> + *   turned back on if we fall below this voltage.
> + * @charge_voltage_max_uv: maintenance charging voltage that is usually =
a bit
> + *   lower than the constant_charge_voltage_max_uv. We can apply this se=
ttings
> + *   charge_current_max_ua until we get back up to this voltage.
> + * @safety_timer_minutes: maintenance charging safety timer, with an exp=
iry

charge_safety_timer_minutes

> + *   time in minutes. We will only use maintenance charging in this sett=
ing
> + *   for a certain amount of time, then we will first move to the next
> + *   maintenance charge current and voltage pair in respective array and=
 wait
> + *   for the next safety timer timeout, or, if we reached the last maint=
encance
> + *   charging setting, disable charging until we reach
> + *   charge_restart_voltage_uv and restart ordinary CC/CV charging from =
there.
> + *   These timers should be chosen to align with the typical discharge c=
urve
> + *   for the battery.
> + *
> + * When the main CC/CV charging is complete the battery can optionally be
> + * maintenance charged at the voltages from this table: a table of setti=
ngs is
> + * traversed using a slightly lower current and voltage than what is use=
d for
> + * CC/CV charging. The maintenance charging will for safety reasons not =
go on
> + * indefinately: we lower the current and voltage with successive mainte=
nance
> + * settings, then disable charging completely after we reach the last on=
e,
> + * and after that we do not restart charging until we reach
> + * charge_restart_voltage_uv (see struct power_supply_battery_info) and =
restart
> + * ordinary CC/CV charging from there.
> + *
> + * As an example, a Samsung EB425161LA Lithium-Ion battery is CC/CV char=
ged
> + * at 900mA to 4340mV, then maintenance charged at 600mA and 4150mV for
> + * 60 hours, then maintenance charged at 600mA and 4100mV for 200 hours.
> + * After this the charge cycle is restarted waiting for
> + * charge_restart_voltage_uv.
> + *
> + * For most mobile electronics this type of maintenance charging is enou=
gh for
> + * the user to disconnect the device and make use of it before both main=
tenance
> + * charging cycles are complete.
> + */
> +struct power_supply_maintenance_charge_table {
> +	int charge_current_max_ua;
> +	int charge_voltage_max_uv;
> +	int charge_safety_timer_minutes;
> +};
> +
>  #define POWER_SUPPLY_OCV_TEMP_MAX 20
> =20
>  /**
> @@ -403,6 +449,10 @@ struct power_supply_ntc_resistance_temp_table {
>   * @constant_charge_voltage_max_uv: voltage in microvolts signifying the=
 end of
>   *   the CC (constant current) charging phase and the beginning of the CV
>   *   (constant voltage) charging phase.
> + * @maintenance_charge: an array of maintenance charging settings to be =
used
> + *   after the main CC/CV charging phase is complete.
> + * @maintenance_charge_size: the number of maintenance charging settings=
 in
> + *   maintenance_charge.
>   * @factory_internal_resistance_uohm: the internal resistance of the bat=
tery
>   *   at fabrication time, expressed in microohms. This resistance will v=
ary
>   *   depending on the lifetime and charge of the battery, so this is jus=
t a
> @@ -564,6 +614,8 @@ struct power_supply_battery_info {
>  	int overvoltage_limit_uv;
>  	int constant_charge_current_max_ua;
>  	int constant_charge_voltage_max_uv;
> +	struct power_supply_maintenance_charge_table *maintenance_charge;
> +	int maintenance_charge_size;
>  	int factory_internal_resistance_uohm;
>  	int ocv_temp[POWER_SUPPLY_OCV_TEMP_MAX];
>  	int temp_ambient_alert_min;
> @@ -621,12 +673,24 @@ power_supply_temp2resist_simple(struct power_supply=
_resistance_temp_table *table
>  				int table_len, int temp);
>  extern int power_supply_ntc_resist2temp_simple(struct power_supply_batte=
ry_info *info,
>  					       int resistance_ohm);
> +extern struct power_supply_maintenance_charge_table *
> +power_supply_get_maintenance_charging_setting(struct power_supply_batter=
y_info *info, int index);
>  extern void power_supply_changed(struct power_supply *psy);
>  extern int power_supply_am_i_supplied(struct power_supply *psy);
>  extern int power_supply_set_input_current_limit_from_supplier(
>  					 struct power_supply *psy);
>  extern int power_supply_set_battery_charged(struct power_supply *psy);
> =20
> +static inline bool
> +power_supply_supports_maintenance_charging(struct power_supply_battery_i=
nfo *info)
> +{
> +	struct power_supply_maintenance_charge_table *mt;
> +
> +	mt =3D power_supply_get_maintenance_charging_setting(info, 0);
> +
> +	return (mt !=3D NULL);
> +}
> +
>  #ifdef CONFIG_POWER_SUPPLY
>  extern int power_supply_is_system_supplied(void);
>  #else
> --=20
> 2.31.1
>=20

--acjulbkwfxb3x5fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmGqhc4ACgkQ2O7X88g7
+pqcZA/+LIxKazBM5I5gNUHe0hbqbVD1HfnSpWTLy9X3X3JSDBzKp10tuk0eV7i5
9ABhq+fwdvrCZB04wU2DOEwmRAfPuITv2IubrztYF8q0X0gwW03UVYHdl+dsVzFX
Cfc/ctzIeGC9DOH5fFRtEuPSZUmTIi2hdgQDB2DZh4Yr4yF57LoGZplAsl9asdvo
dqVsEPsLkIsUIS0WgfXaZx0YvT0AEmlhtbLugcck//wKJP6590h10VLQPwiDo3JT
clhjuQr8fszyrWi5CIreI/gSqvMj3FDzVNEGVlUesVP1IBq/fLxwAezjd/InjNHo
DDdW/49uTTIdxeqaTsgiYFFS9J9msimVFPuE8TQPacZghlpJ2ftPVFORFkO75B1F
nkm8BB19Y/7QepkxaToOd+Ja1s81F2rpD8zefWA8DDmzcLYr/E+y9iooKNzwCYvM
4UxY+uMtpUqdlXPx0XPe1eAD6wgjLl0t37B5azAhmZMu82YtbGOcJWVgUK/ilLpl
k0MshRjH/4QNvxHl55l2o7PAXM08BbMyMt37PXSkEmJULKpPEg+1i5me3IgbzyQK
V0YmyrZ/0HOnLAr1VaGjEKc7IoocSek68Q4M1u6NEEtPeYCX0quWQ6cLfRSXaDS9
AOwNYOntx2kkIu0MoEITodT88gN489gPydRLGnRIZIEQdaQqhuE=
=Gd4P
-----END PGP SIGNATURE-----

--acjulbkwfxb3x5fl--
