Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E564836A5
	for <lists+linux-pm@lfdr.de>; Mon,  3 Jan 2022 19:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiACSMT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 3 Jan 2022 13:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiACSMT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jan 2022 13:12:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9136BC061761
        for <linux-pm@vger.kernel.org>; Mon,  3 Jan 2022 10:12:18 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 606771F426D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641233537;
        bh=XEsfGeGaJltF9edPK8R1+irbeRMw8jIM12NNPAt5yXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BoWMzJcN79fF5ELHTn3j9SXmo/f2AQiroMT+GgcaodasqoRx5+IskQRq7QWUYv2BN
         dmPbwnXMcmdDFKzeXRGtlRtaN5fekCDU/sgDYI8YYdqPDeEr8TQKn/FqNW0fGb6C42
         CXrEm8hpnmXxHAiiUhLy4lJLR3NWpC3jW8iXCqCp93JJjsz0pvqPXE/55doLYdRKai
         YdHMAv+wB0URwTFg0DEwpn/W3TEZ6Fy/RJmmc7h0rrbbXIT6PUAjBXA1AQwdJaMVnE
         vBGnTdJzgIPPnXFeYkY8iSMsDcJhiAz4nYFS0mRSYo0WyI8tXZ49uboPLl8kjO7muL
         oNdVy5HwQtCLQ==
Received: by earth.universe (Postfix, from userid 1000)
        id 192F43C0CB7; Mon,  3 Jan 2022 19:12:15 +0100 (CET)
Date:   Mon, 3 Jan 2022 19:12:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Subject: Re: [PATCH v4] power: supply_core: Pass pointer to battery info
Message-ID: <20220103181215.r6a4aqzctxixdelr@earth.universe>
References: <20211215010118.1354938-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i4zu3v5ng3lk7ulc"
Content-Disposition: inline
In-Reply-To: <20211215010118.1354938-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--i4zu3v5ng3lk7ulc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 15, 2021 at 02:01:18AM +0100, Linus Walleij wrote:
> The function to retrieve battery info (from the device tree) assumes
> we have a static info struct that gets populated by calling into
> power_supply_get_battery_info().
>=20
> This is awkward since I want to support tables of static battery
> info by just assigning a pointer to all info based on e.g. a
> compatible value in the device tree.
>=20
> We also have a mixture of static and dynamically allocated
> variables here.
>=20
> Bite the bullet and let power_supply_get_battery_info() allocate
> also the memory used for the very top level
> struct power_supply_battery_info container. Pass pointers
> around and lifecycle this with the psy device just like the
> stuff we allocate inside it.
>=20
> Change all current users over.
>=20
> As part of the change, initializers need to be added to some
> previously uninitialized fields in struct
> power_supply_battery_info.
>=20
> Reviewed-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Discovered by way of Matti that some new initializers are
>   needed and added them.
> ChangeLog v2->v3:
> - Keep power_supply_put_battery_info() in the bd99954
>   charger driver: the init data can indeed be dropped
>   after initialization.
> ChangeLog v1->v2:
> - Fix two bugs causing compile errors - was hard to get
>   compiler coverage but the build servers stepped in and
>   corrected me.
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/ab8500-bm.h         |  2 +-
>  drivers/power/supply/ab8500_bmdata.c     |  7 +++--
>  drivers/power/supply/ab8500_btemp.c      | 10 +++++--
>  drivers/power/supply/ab8500_chargalg.c   | 16 +++++-----
>  drivers/power/supply/ab8500_fg.c         | 18 ++++++-----
>  drivers/power/supply/axp20x_battery.c    |  6 ++--
>  drivers/power/supply/bd99954-charger.c   | 24 ++++++++-------
>  drivers/power/supply/bq24190_charger.c   |  6 ++--
>  drivers/power/supply/bq2515x_charger.c   |  8 ++---
>  drivers/power/supply/bq256xx_charger.c   | 24 +++++++--------
>  drivers/power/supply/bq25980_charger.c   |  6 ++--
>  drivers/power/supply/bq27xxx_battery.c   | 38 ++++++++++++------------
>  drivers/power/supply/cw2015_battery.c    | 20 ++++++++-----
>  drivers/power/supply/ingenic-battery.c   | 14 ++++-----
>  drivers/power/supply/power_supply_core.c | 19 ++++++++++--
>  drivers/power/supply/sc2731_charger.c    |  8 ++---
>  drivers/power/supply/sc27xx_fuel_gauge.c | 22 +++++++-------
>  drivers/power/supply/smb347-charger.c    | 34 ++++++++++-----------
>  include/linux/power_supply.h             |  2 +-
>  19 files changed, 157 insertions(+), 127 deletions(-)
>=20
> diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab85=
00-bm.h
> index 57e1a8e27e51..56a5aaf9a27a 100644
> --- a/drivers/power/supply/ab8500-bm.h
> +++ b/drivers/power/supply/ab8500-bm.h
> @@ -439,7 +439,7 @@ struct ab8500_bm_charger_parameters {
>   * @fg_params		fuel gauge parameters
>   */
>  struct ab8500_bm_data {
> -	struct power_supply_battery_info bi;
> +	struct power_supply_battery_info *bi;
>  	int temp_now;
>  	int temp_interval_chg;
>  	int temp_interval_nochg;
> diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/=
ab8500_bmdata.c
> index 62953f9cb85a..7ae95f537580 100644
> --- a/drivers/power/supply/ab8500_bmdata.c
> +++ b/drivers/power/supply/ab8500_bmdata.c
> @@ -167,15 +167,16 @@ struct ab8500_bm_data ab8500_bm_data =3D {
>  int ab8500_bm_of_probe(struct power_supply *psy,
>  		       struct ab8500_bm_data *bm)
>  {
> -	struct power_supply_battery_info *bi =3D &bm->bi;
> +	struct power_supply_battery_info *bi;
>  	struct device *dev =3D &psy->dev;
>  	int ret;
> =20
> -	ret =3D power_supply_get_battery_info(psy, bi);
> +	ret =3D power_supply_get_battery_info(psy, &bm->bi);
>  	if (ret) {
>  		dev_err(dev, "cannot retrieve battery info\n");
>  		return ret;
>  	}
> +	bi =3D bm->bi;
> =20
>  	/* Fill in defaults for any data missing from the device tree */
>  	if (bi->charge_full_design_uah < 0)
> @@ -240,5 +241,5 @@ int ab8500_bm_of_probe(struct power_supply *psy,
>  void ab8500_bm_of_remove(struct power_supply *psy,
>  			 struct ab8500_bm_data *bm)
>  {
> -	power_supply_put_battery_info(psy, &bm->bi);
> +	power_supply_put_battery_info(psy, bm->bi);
>  }
> diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/a=
b8500_btemp.c
> index 20253b8a7fe9..cc33c5187fbb 100644
> --- a/drivers/power/supply/ab8500_btemp.c
> +++ b/drivers/power/supply/ab8500_btemp.c
> @@ -451,12 +451,13 @@ static int ab8500_btemp_res_to_temp(struct ab8500_b=
temp *di,
>   */
>  static int ab8500_btemp_measure_temp(struct ab8500_btemp *di)
>  {
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
>  	int temp, ret;
>  	static int prev;
>  	int rbat, rntc, vntc;
> =20
>  	if ((di->bm->adc_therm =3D=3D AB8500_ADC_THERM_BATCTRL) &&
> -	    (di->bm->bi.technology =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
> +	    (bi && (bi->technology =3D=3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN))) {
> =20
>  		rbat =3D ab8500_btemp_get_batctrl_res(di);
>  		if (rbat < 0) {
> @@ -540,7 +541,7 @@ static int ab8500_btemp_id(struct ab8500_btemp *di)
>  	 * that need it.
>  	 */
>  	if ((di->bm->adc_therm =3D=3D AB8500_ADC_THERM_BATCTRL) &&
> -	    (di->bm->bi.technology =3D=3D POWER_SUPPLY_TECHNOLOGY_LIPO) &&
> +	    (di->bm->bi && (di->bm->bi->technology =3D=3D POWER_SUPPLY_TECHNOLO=
GY_LIPO)) &&
>  	    (res <=3D 53407) && (res >=3D 12500)) {
>  		dev_dbg(di->dev, "Set BATCTRL current source to 20uA\n");
>  		di->curr_source =3D BTEMP_BATCTRL_CURR_SRC_20UA;
> @@ -807,7 +808,10 @@ static int ab8500_btemp_get_property(struct power_su=
pply *psy,
>  			val->intval =3D 1;
>  		break;
>  	case POWER_SUPPLY_PROP_TECHNOLOGY:
> -		val->intval =3D di->bm->bi.technology;
> +		if (di->bm->bi)
> +			val->intval =3D di->bm->bi->technology;
> +		else
> +			val->intval =3D POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
>  		break;
>  	case POWER_SUPPLY_PROP_TEMP:
>  		val->intval =3D ab8500_btemp_get_temp(di);
> diff --git a/drivers/power/supply/ab8500_chargalg.c b/drivers/power/suppl=
y/ab8500_chargalg.c
> index 86d740ce3a63..c4a2fe07126c 100644
> --- a/drivers/power/supply/ab8500_chargalg.c
> +++ b/drivers/power/supply/ab8500_chargalg.c
> @@ -352,7 +352,7 @@ static void ab8500_chargalg_state_to(struct ab8500_ch=
argalg *di,
> =20
>  static int ab8500_chargalg_check_charger_enable(struct ab8500_chargalg *=
di)
>  {
> -	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
> =20
>  	switch (di->charge_state) {
>  	case STATE_NORMAL:
> @@ -731,7 +731,7 @@ static void ab8500_chargalg_start_charging(struct ab8=
500_chargalg *di,
>   */
>  static void ab8500_chargalg_check_temp(struct ab8500_chargalg *di)
>  {
> -	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
> =20
>  	if (di->batt_data.temp > (bi->temp_alert_min + di->t_hyst_norm) &&
>  		di->batt_data.temp < (bi->temp_alert_max - di->t_hyst_norm)) {
> @@ -802,10 +802,10 @@ static void ab8500_chargalg_end_of_charge(struct ab=
8500_chargalg *di)
>  	if (di->charge_status =3D=3D POWER_SUPPLY_STATUS_CHARGING &&
>  		di->charge_state =3D=3D STATE_NORMAL &&
>  		!di->maintenance_chg && (di->batt_data.volt_uv >=3D
> -		di->bm->bi.overvoltage_limit_uv ||
> +		di->bm->bi->overvoltage_limit_uv ||
>  		di->events.usb_cv_active || di->events.ac_cv_active) &&
>  		di->batt_data.avg_curr_ua <
> -		di->bm->bi.charge_term_current_ua &&
> +		di->bm->bi->charge_term_current_ua &&
>  		di->batt_data.avg_curr_ua > 0) {
>  		if (++di->eoc_cnt >=3D EOC_COND_CNT) {
>  			di->eoc_cnt =3D 0;
> @@ -827,7 +827,7 @@ static void ab8500_chargalg_end_of_charge(struct ab85=
00_chargalg *di)
> =20
>  static void init_maxim_chg_curr(struct ab8500_chargalg *di)
>  {
> -	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
> =20
>  	di->ccm.original_iset_ua =3D bi->constant_charge_current_max_ua;
>  	di->ccm.current_iset_ua =3D bi->constant_charge_current_max_ua;
> @@ -920,7 +920,7 @@ static enum maxim_ret ab8500_chargalg_chg_curr_maxim(=
struct ab8500_chargalg *di)
> =20
>  static void handle_maxim_chg_curr(struct ab8500_chargalg *di)
>  {
> -	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
>  	enum maxim_ret ret;
>  	int result;
> =20
> @@ -1299,7 +1299,7 @@ static void ab8500_chargalg_external_power_changed(=
struct power_supply *psy)
>   */
>  static void ab8500_chargalg_algorithm(struct ab8500_chargalg *di)
>  {
> -	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
>  	int charger_status;
>  	int ret;
>  	int curr_step_lvl_ua;
> @@ -1723,7 +1723,7 @@ static int ab8500_chargalg_get_property(struct powe=
r_supply *psy,
>  		if (di->events.batt_ovv) {
>  			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
>  		} else if (di->events.btemp_underover) {
> -			if (di->batt_data.temp <=3D di->bm->bi.temp_min)
> +			if (di->batt_data.temp <=3D di->bm->bi->temp_min)
>  				val->intval =3D POWER_SUPPLY_HEALTH_COLD;
>  			else
>  				val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index eb3e5c4ca44f..b0919a6a6587 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -852,7 +852,7 @@ static int ab8500_fg_bat_voltage(struct ab8500_fg *di)
>   */
>  static int ab8500_fg_volt_to_capacity(struct ab8500_fg *di, int voltage_=
uv)
>  {
> -	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
> =20
>  	/* Multiply by 10 because the capacity is tracked in per mille */
>  	return power_supply_batinfo_ocv2cap(bi, voltage_uv, di->bat_temp) *  10;
> @@ -881,7 +881,7 @@ static int ab8500_fg_uncomp_volt_to_capacity(struct a=
b8500_fg *di)
>   */
>  static int ab8500_fg_battery_resistance(struct ab8500_fg *di)
>  {
> -	struct power_supply_battery_info *bi =3D &di->bm->bi;
> +	struct power_supply_battery_info *bi =3D di->bm->bi;
>  	int resistance_percent =3D 0;
>  	int resistance;
> =20
> @@ -2140,11 +2140,13 @@ static int ab8500_fg_get_ext_psy_data(struct devi=
ce *dev, void *data)
>  	struct power_supply *ext =3D dev_get_drvdata(dev);
>  	const char **supplicants =3D (const char **)ext->supplied_to;
>  	struct ab8500_fg *di;
> +	struct power_supply_battery_info *bi;
>  	union power_supply_propval ret;
>  	int j;
> =20
>  	psy =3D (struct power_supply *)data;
>  	di =3D power_supply_get_drvdata(psy);
> +	bi =3D di->bm->bi;
> =20
>  	/*
>  	 * For all psy where the name of your driver
> @@ -2207,8 +2209,8 @@ static int ab8500_fg_get_ext_psy_data(struct device=
 *dev, void *data)
>  			switch (ext->desc->type) {
>  			case POWER_SUPPLY_TYPE_BATTERY:
>  				if (!di->flags.batt_id_received &&
> -				    (di->bm->bi.technology !=3D
> -				     POWER_SUPPLY_TECHNOLOGY_UNKNOWN)) {
> +				    (bi && (bi->technology !=3D
> +					    POWER_SUPPLY_TECHNOLOGY_UNKNOWN))) {
>  					const struct ab8500_battery_type *b;
> =20
>  					b =3D di->bm->bat_type;
> @@ -2216,13 +2218,13 @@ static int ab8500_fg_get_ext_psy_data(struct devi=
ce *dev, void *data)
>  					di->flags.batt_id_received =3D true;
> =20
>  					di->bat_cap.max_mah_design =3D
> -						di->bm->bi.charge_full_design_uah;
> +						di->bm->bi->charge_full_design_uah;
> =20
>  					di->bat_cap.max_mah =3D
>  						di->bat_cap.max_mah_design;
> =20
>  					di->vbat_nom_uv =3D
> -						di->bm->bi.voltage_max_design_uv;
> +						di->bm->bi->voltage_max_design_uv;
>  				}
> =20
>  				if (ret.intval)
> @@ -2992,9 +2994,9 @@ static int ab8500_fg_bind(struct device *dev, struc=
t device *master,
>  		return -ENOMEM;
>  	}
> =20
> -	di->bat_cap.max_mah_design =3D di->bm->bi.charge_full_design_uah;
> +	di->bat_cap.max_mah_design =3D di->bm->bi->charge_full_design_uah;
>  	di->bat_cap.max_mah =3D di->bat_cap.max_mah_design;
> -	di->vbat_nom_uv =3D di->bm->bi.voltage_max_design_uv;
> +	di->vbat_nom_uv =3D di->bm->bi->voltage_max_design_uv;
> =20
>  	/* Start the coulomb counter */
>  	ab8500_fg_coulomb_counter(di, true);
> diff --git a/drivers/power/supply/axp20x_battery.c b/drivers/power/supply=
/axp20x_battery.c
> index 18a9db0df4b1..5d197141f476 100644
> --- a/drivers/power/supply/axp20x_battery.c
> +++ b/drivers/power/supply/axp20x_battery.c
> @@ -561,7 +561,7 @@ static int axp20x_power_probe(struct platform_device =
*pdev)
>  {
>  	struct axp20x_batt_ps *axp20x_batt;
>  	struct power_supply_config psy_cfg =3D {};
> -	struct power_supply_battery_info info;
> +	struct power_supply_battery_info *info;
>  	struct device *dev =3D &pdev->dev;
> =20
>  	if (!of_device_is_available(pdev->dev.of_node))
> @@ -615,8 +615,8 @@ static int axp20x_power_probe(struct platform_device =
*pdev)
>  	}
> =20
>  	if (!power_supply_get_battery_info(axp20x_batt->batt, &info)) {
> -		int vmin =3D info.voltage_min_design_uv;
> -		int ccc =3D info.constant_charge_current_max_ua;
> +		int vmin =3D info->voltage_min_design_uv;
> +		int ccc =3D info->constant_charge_current_max_ua;
> =20
>  		if (vmin > 0 && axp20x_set_voltage_min_design(axp20x_batt,
>  							      vmin))
> diff --git a/drivers/power/supply/bd99954-charger.c b/drivers/power/suppl=
y/bd99954-charger.c
> index ffd8bfa08179..96e93e1b8094 100644
> --- a/drivers/power/supply/bd99954-charger.c
> +++ b/drivers/power/supply/bd99954-charger.c
> @@ -882,7 +882,7 @@ struct dt_init {
>  static int bd9995x_fw_probe(struct bd9995x_device *bd)
>  {
>  	int ret;
> -	struct power_supply_battery_info info;
> +	struct power_supply_battery_info *info;
>  	u32 property;
>  	int i;
>  	int regval;
> @@ -891,49 +891,41 @@ static int bd9995x_fw_probe(struct bd9995x_device *=
bd)
>  	struct battery_init battery_inits[] =3D {
>  		{
>  			.name =3D "trickle-charging current",
> -			.info_data =3D &info.tricklecharge_current_ua,
>  			.range =3D &charging_current_ranges[0],
>  			.ranges =3D 2,
>  			.data =3D &init->itrich_set,
>  		}, {
>  			.name =3D "pre-charging current",
> -			.info_data =3D &info.precharge_current_ua,
>  			.range =3D &charging_current_ranges[0],
>  			.ranges =3D 2,
>  			.data =3D &init->iprech_set,
>  		}, {
>  			.name =3D "pre-to-trickle charge voltage threshold",
> -			.info_data =3D &info.precharge_voltage_max_uv,
>  			.range =3D &trickle_to_pre_threshold_ranges[0],
>  			.ranges =3D 2,
>  			.data =3D &init->vprechg_th_set,
>  		}, {
>  			.name =3D "charging termination current",
> -			.info_data =3D &info.charge_term_current_ua,
>  			.range =3D &charging_current_ranges[0],
>  			.ranges =3D 2,
>  			.data =3D &init->iterm_set,
>  		}, {
>  			.name =3D "charging re-start voltage",
> -			.info_data =3D &info.charge_restart_voltage_uv,
>  			.range =3D &charge_voltage_regulation_ranges[0],
>  			.ranges =3D 2,
>  			.data =3D &init->vrechg_set,
>  		}, {
>  			.name =3D "battery overvoltage limit",
> -			.info_data =3D &info.overvoltage_limit_uv,
>  			.range =3D &charge_voltage_regulation_ranges[0],
>  			.ranges =3D 2,
>  			.data =3D &init->vbatovp_set,
>  		}, {
>  			.name =3D "fast-charging max current",
> -			.info_data =3D &info.constant_charge_current_max_ua,
>  			.range =3D &fast_charge_current_ranges[0],
>  			.ranges =3D 1,
>  			.data =3D &init->ichg_set,
>  		}, {
>  			.name =3D "fast-charging voltage",
> -			.info_data =3D &info.constant_charge_voltage_max_uv,
>  			.range =3D &charge_voltage_regulation_ranges[0],
>  			.ranges =3D 2,
>  			.data =3D &init->vfastchg_reg_set1,
> @@ -966,6 +958,16 @@ static int bd9995x_fw_probe(struct bd9995x_device *b=
d)
>  	if (ret < 0)
>  		return ret;
> =20
> +	/* Put pointers to the generic battery info */
> +	battery_inits[0].info_data =3D &info->tricklecharge_current_ua;
> +	battery_inits[1].info_data =3D &info->precharge_current_ua;
> +	battery_inits[2].info_data =3D &info->precharge_voltage_max_uv;
> +	battery_inits[3].info_data =3D &info->charge_term_current_ua;
> +	battery_inits[4].info_data =3D &info->charge_restart_voltage_uv;
> +	battery_inits[5].info_data =3D &info->overvoltage_limit_uv;
> +	battery_inits[6].info_data =3D &info->constant_charge_current_max_ua;
> +	battery_inits[7].info_data =3D &info->constant_charge_voltage_max_uv;
> +
>  	for (i =3D 0; i < ARRAY_SIZE(battery_inits); i++) {
>  		int val =3D *battery_inits[i].info_data;
>  		const struct linear_range *range =3D battery_inits[i].range;
> @@ -980,7 +982,7 @@ static int bd9995x_fw_probe(struct bd9995x_device *bd)
>  			dev_err(bd->dev, "Unsupported value for %s\n",
>  				battery_inits[i].name);
> =20
> -			power_supply_put_battery_info(bd->charger, &info);
> +			power_supply_put_battery_info(bd->charger, info);
>  			return -EINVAL;
>  		}
>  		if (!found) {
> @@ -991,7 +993,7 @@ static int bd9995x_fw_probe(struct bd9995x_device *bd)
>  		*(battery_inits[i].data) =3D regval;
>  	}
> =20
> -	power_supply_put_battery_info(bd->charger, &info);
> +	power_supply_put_battery_info(bd->charger, info);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(props); i++) {
>  		ret =3D device_property_read_u32(bd->dev, props[i].prop,
> diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/suppl=
y/bq24190_charger.c
> index 35ff0c8fe96f..06c34b09349c 100644
> --- a/drivers/power/supply/bq24190_charger.c
> +++ b/drivers/power/supply/bq24190_charger.c
> @@ -1670,7 +1670,7 @@ static int bq24190_hw_init(struct bq24190_dev_info =
*bdi)
>  static int bq24190_get_config(struct bq24190_dev_info *bdi)
>  {
>  	const char * const s =3D "ti,system-minimum-microvolt";
> -	struct power_supply_battery_info info =3D {};
> +	struct power_supply_battery_info *info;
>  	int v;
> =20
>  	if (device_property_read_u32(bdi->dev, s, &v) =3D=3D 0) {
> @@ -1684,7 +1684,7 @@ static int bq24190_get_config(struct bq24190_dev_in=
fo *bdi)
> =20
>  	if (bdi->dev->of_node &&
>  	    !power_supply_get_battery_info(bdi->charger, &info)) {
> -		v =3D info.precharge_current_ua / 1000;
> +		v =3D info->precharge_current_ua / 1000;
>  		if (v >=3D BQ24190_REG_PCTCC_IPRECHG_MIN
>  		 && v <=3D BQ24190_REG_PCTCC_IPRECHG_MAX)
>  			bdi->iprechg =3D v;
> @@ -1692,7 +1692,7 @@ static int bq24190_get_config(struct bq24190_dev_in=
fo *bdi)
>  			dev_warn(bdi->dev, "invalid value for battery:precharge-current-micro=
amp: %d\n",
>  				 v);
> =20
> -		v =3D info.charge_term_current_ua / 1000;
> +		v =3D info->charge_term_current_ua / 1000;
>  		if (v >=3D BQ24190_REG_PCTCC_ITERM_MIN
>  		 && v <=3D BQ24190_REG_PCTCC_ITERM_MAX)
>  			bdi->iterm =3D v;
> diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/suppl=
y/bq2515x_charger.c
> index 374b112f712a..4f76ad9c2f18 100644
> --- a/drivers/power/supply/bq2515x_charger.c
> +++ b/drivers/power/supply/bq2515x_charger.c
> @@ -945,7 +945,7 @@ static int bq2515x_power_supply_register(struct bq251=
5x_device *bq2515x,
>  static int bq2515x_hw_init(struct bq2515x_device *bq2515x)
>  {
>  	int ret;
> -	struct power_supply_battery_info bat_info =3D { };
> +	struct power_supply_battery_info *bat_info;
> =20
>  	ret =3D bq2515x_disable_watchdog_timers(bq2515x);
>  	if (ret)
> @@ -969,13 +969,13 @@ static int bq2515x_hw_init(struct bq2515x_device *b=
q2515x)
> =20
>  	} else {
>  		bq2515x->init_data.ichg =3D
> -				bat_info.constant_charge_current_max_ua;
> +				bat_info->constant_charge_current_max_ua;
> =20
>  		bq2515x->init_data.vbatreg =3D
> -				bat_info.constant_charge_voltage_max_uv;
> +				bat_info->constant_charge_voltage_max_uv;
> =20
>  		bq2515x->init_data.iprechg =3D
> -				bat_info.precharge_current_ua;
> +				bat_info->precharge_current_ua;
>  	}
> =20
>  	ret =3D bq2515x_set_const_charge_current(bq2515x,
> diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/suppl=
y/bq256xx_charger.c
> index f501ecd49202..b274942dc46a 100644
> --- a/drivers/power/supply/bq256xx_charger.c
> +++ b/drivers/power/supply/bq256xx_charger.c
> @@ -1504,7 +1504,7 @@ static int bq256xx_power_supply_init(struct bq256xx=
_device *bq,
> =20
>  static int bq256xx_hw_init(struct bq256xx_device *bq)
>  {
> -	struct power_supply_battery_info bat_info =3D { };
> +	struct power_supply_battery_info *bat_info;
>  	int wd_reg_val =3D BQ256XX_WATCHDOG_DIS;
>  	int ret =3D 0;
>  	int i;
> @@ -1526,16 +1526,16 @@ static int bq256xx_hw_init(struct bq256xx_device =
*bq)
>  	if (ret) {
>  		dev_warn(bq->dev, "battery info missing, default values will be applie=
d\n");
> =20
> -		bat_info.constant_charge_current_max_ua =3D
> +		bat_info->constant_charge_current_max_ua =3D
>  				bq->chip_info->bq256xx_def_ichg;
> =20
> -		bat_info.constant_charge_voltage_max_uv =3D
> +		bat_info->constant_charge_voltage_max_uv =3D
>  				bq->chip_info->bq256xx_def_vbatreg;
> =20
> -		bat_info.precharge_current_ua =3D
> +		bat_info->precharge_current_ua =3D
>  				bq->chip_info->bq256xx_def_iprechg;
> =20
> -		bat_info.charge_term_current_ua =3D
> +		bat_info->charge_term_current_ua =3D
>  				bq->chip_info->bq256xx_def_iterm;
> =20
>  		bq->init_data.ichg_max =3D
> @@ -1545,10 +1545,10 @@ static int bq256xx_hw_init(struct bq256xx_device =
*bq)
>  				bq->chip_info->bq256xx_max_vbatreg;
>  	} else {
>  		bq->init_data.ichg_max =3D
> -			bat_info.constant_charge_current_max_ua;
> +			bat_info->constant_charge_current_max_ua;
> =20
>  		bq->init_data.vbatreg_max =3D
> -			bat_info.constant_charge_voltage_max_uv;
> +			bat_info->constant_charge_voltage_max_uv;
>  	}
> =20
>  	ret =3D bq->chip_info->bq256xx_set_vindpm(bq, bq->init_data.vindpm);
> @@ -1560,26 +1560,26 @@ static int bq256xx_hw_init(struct bq256xx_device =
*bq)
>  		return ret;
> =20
>  	ret =3D bq->chip_info->bq256xx_set_ichg(bq,
> -				bat_info.constant_charge_current_max_ua);
> +				bat_info->constant_charge_current_max_ua);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D bq->chip_info->bq256xx_set_iprechg(bq,
> -				bat_info.precharge_current_ua);
> +				bat_info->precharge_current_ua);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D bq->chip_info->bq256xx_set_vbatreg(bq,
> -				bat_info.constant_charge_voltage_max_uv);
> +				bat_info->constant_charge_voltage_max_uv);
>  	if (ret)
>  		return ret;
> =20
>  	ret =3D bq->chip_info->bq256xx_set_iterm(bq,
> -				bat_info.charge_term_current_ua);
> +				bat_info->charge_term_current_ua);
>  	if (ret)
>  		return ret;
> =20
> -	power_supply_put_battery_info(bq->charger, &bat_info);
> +	power_supply_put_battery_info(bq->charger, bat_info);
> =20
>  	return 0;
>  }
> diff --git a/drivers/power/supply/bq25980_charger.c b/drivers/power/suppl=
y/bq25980_charger.c
> index 0008c229fd9c..9daa6d14db4d 100644
> --- a/drivers/power/supply/bq25980_charger.c
> +++ b/drivers/power/supply/bq25980_charger.c
> @@ -1079,7 +1079,7 @@ static int bq25980_power_supply_init(struct bq25980=
_device *bq,
> =20
>  static int bq25980_hw_init(struct bq25980_device *bq)
>  {
> -	struct power_supply_battery_info bat_info =3D { };
> +	struct power_supply_battery_info *bat_info;
>  	int wd_reg_val =3D BQ25980_WATCHDOG_DIS;
>  	int wd_max_val =3D BQ25980_NUM_WD_VAL - 1;
>  	int ret =3D 0;
> @@ -1112,8 +1112,8 @@ static int bq25980_hw_init(struct bq25980_device *b=
q)
>  		return -EINVAL;
>  	}
> =20
> -	bq->init_data.ichg_max =3D bat_info.constant_charge_current_max_ua;
> -	bq->init_data.vreg_max =3D bat_info.constant_charge_voltage_max_uv;
> +	bq->init_data.ichg_max =3D bat_info->constant_charge_current_max_ua;
> +	bq->init_data.vreg_max =3D bat_info->constant_charge_voltage_max_uv;
> =20
>  	if (bq->state.bypass) {
>  		ret =3D regmap_update_bits(bq->regmap, BQ25980_CHRGR_CTRL_2,
> diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/suppl=
y/bq27xxx_battery.c
> index 7e5e24b585d8..72e727cd31e8 100644
> --- a/drivers/power/supply/bq27xxx_battery.c
> +++ b/drivers/power/supply/bq27xxx_battery.c
> @@ -1474,7 +1474,7 @@ static void bq27xxx_battery_set_config(struct bq27x=
xx_device_info *di,
> =20
>  static void bq27xxx_battery_settings(struct bq27xxx_device_info *di)
>  {
> -	struct power_supply_battery_info info =3D {};
> +	struct power_supply_battery_info *info;
>  	unsigned int min, max;
> =20
>  	if (power_supply_get_battery_info(di->bat, &info) < 0)
> @@ -1485,43 +1485,43 @@ static void bq27xxx_battery_settings(struct bq27x=
xx_device_info *di)
>  		return;
>  	}
> =20
> -	if (info.energy_full_design_uwh !=3D info.charge_full_design_uah) {
> -		if (info.energy_full_design_uwh =3D=3D -EINVAL)
> +	if (info->energy_full_design_uwh !=3D info->charge_full_design_uah) {
> +		if (info->energy_full_design_uwh =3D=3D -EINVAL)
>  			dev_warn(di->dev, "missing battery:energy-full-design-microwatt-hours=
\n");
> -		else if (info.charge_full_design_uah =3D=3D -EINVAL)
> +		else if (info->charge_full_design_uah =3D=3D -EINVAL)
>  			dev_warn(di->dev, "missing battery:charge-full-design-microamp-hours\=
n");
>  	}
> =20
>  	/* assume min =3D=3D 0 */
>  	max =3D di->dm_regs[BQ27XXX_DM_DESIGN_ENERGY].max;
> -	if (info.energy_full_design_uwh > max * 1000) {
> +	if (info->energy_full_design_uwh > max * 1000) {
>  		dev_err(di->dev, "invalid battery:energy-full-design-microwatt-hours %=
d\n",
> -			info.energy_full_design_uwh);
> -		info.energy_full_design_uwh =3D -EINVAL;
> +			info->energy_full_design_uwh);
> +		info->energy_full_design_uwh =3D -EINVAL;
>  	}
> =20
>  	/* assume min =3D=3D 0 */
>  	max =3D di->dm_regs[BQ27XXX_DM_DESIGN_CAPACITY].max;
> -	if (info.charge_full_design_uah > max * 1000) {
> +	if (info->charge_full_design_uah > max * 1000) {
>  		dev_err(di->dev, "invalid battery:charge-full-design-microamp-hours %d=
\n",
> -			info.charge_full_design_uah);
> -		info.charge_full_design_uah =3D -EINVAL;
> +			info->charge_full_design_uah);
> +		info->charge_full_design_uah =3D -EINVAL;
>  	}
> =20
>  	min =3D di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].min;
>  	max =3D di->dm_regs[BQ27XXX_DM_TERMINATE_VOLTAGE].max;
> -	if ((info.voltage_min_design_uv < min * 1000 ||
> -	     info.voltage_min_design_uv > max * 1000) &&
> -	     info.voltage_min_design_uv !=3D -EINVAL) {
> +	if ((info->voltage_min_design_uv < min * 1000 ||
> +	     info->voltage_min_design_uv > max * 1000) &&
> +	     info->voltage_min_design_uv !=3D -EINVAL) {
>  		dev_err(di->dev, "invalid battery:voltage-min-design-microvolt %d\n",
> -			info.voltage_min_design_uv);
> -		info.voltage_min_design_uv =3D -EINVAL;
> +			info->voltage_min_design_uv);
> +		info->voltage_min_design_uv =3D -EINVAL;
>  	}
> =20
> -	if ((info.energy_full_design_uwh !=3D -EINVAL &&
> -	     info.charge_full_design_uah !=3D -EINVAL) ||
> -	     info.voltage_min_design_uv  !=3D -EINVAL)
> -		bq27xxx_battery_set_config(di, &info);
> +	if ((info->energy_full_design_uwh !=3D -EINVAL &&
> +	     info->charge_full_design_uah !=3D -EINVAL) ||
> +	     info->voltage_min_design_uv  !=3D -EINVAL)
> +		bq27xxx_battery_set_config(di, info);
>  }
> =20
>  /*
> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply=
/cw2015_battery.c
> index 091868e9e9e8..0c87ad0dbf71 100644
> --- a/drivers/power/supply/cw2015_battery.c
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -61,7 +61,7 @@ struct cw_battery {
>  	struct delayed_work battery_delay_work;
>  	struct regmap *regmap;
>  	struct power_supply *rk_bat;
> -	struct power_supply_battery_info battery;
> +	struct power_supply_battery_info *battery;
>  	u8 *bat_profile;
> =20
>  	bool charger_attached;
> @@ -505,22 +505,22 @@ static int cw_battery_get_property(struct power_sup=
ply *psy,
> =20
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> -		if (cw_bat->battery.charge_full_design_uah > 0)
> -			val->intval =3D cw_bat->battery.charge_full_design_uah;
> +		if (cw_bat->battery->charge_full_design_uah > 0)
> +			val->intval =3D cw_bat->battery->charge_full_design_uah;
>  		else
>  			val->intval =3D 0;
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_CHARGE_NOW:
> -		val->intval =3D cw_bat->battery.charge_full_design_uah;
> +		val->intval =3D cw_bat->battery->charge_full_design_uah;
>  		val->intval =3D val->intval * cw_bat->soc / 100;
>  		break;
> =20
>  	case POWER_SUPPLY_PROP_CURRENT_NOW:
>  		if (cw_battery_valid_time_to_empty(cw_bat) &&
> -		    cw_bat->battery.charge_full_design_uah > 0) {
> +		    cw_bat->battery->charge_full_design_uah > 0) {
>  			/* calculate remaining capacity */
> -			val->intval =3D cw_bat->battery.charge_full_design_uah;
> +			val->intval =3D cw_bat->battery->charge_full_design_uah;
>  			val->intval =3D val->intval * cw_bat->soc / 100;
> =20
>  			/* estimate current based on time to empty */
> @@ -687,6 +687,12 @@ static int cw_bat_probe(struct i2c_client *client)
> =20
>  	ret =3D power_supply_get_battery_info(cw_bat->rk_bat, &cw_bat->battery);
>  	if (ret) {
> +		/* Allocate an empty battery */
> +		cw_bat->battery =3D devm_kzalloc(&client->dev,
> +					       sizeof(cw_bat->battery),
> +					       GFP_KERNEL);
> +		if (!cw_bat->battery)
> +			return -ENOMEM;
>  		dev_warn(cw_bat->dev,
>  			 "No monitored battery, some properties will be missing\n");
>  	}
> @@ -724,7 +730,7 @@ static int cw_bat_remove(struct i2c_client *client)
>  	struct cw_battery *cw_bat =3D i2c_get_clientdata(client);
> =20
>  	cancel_delayed_work_sync(&cw_bat->battery_delay_work);
> -	power_supply_put_battery_info(cw_bat->rk_bat, &cw_bat->battery);
> +	power_supply_put_battery_info(cw_bat->rk_bat, cw_bat->battery);
>  	return 0;
>  }
> =20
> diff --git a/drivers/power/supply/ingenic-battery.c b/drivers/power/suppl=
y/ingenic-battery.c
> index 8b18219ebe90..2e7fdfde47ec 100644
> --- a/drivers/power/supply/ingenic-battery.c
> +++ b/drivers/power/supply/ingenic-battery.c
> @@ -18,7 +18,7 @@ struct ingenic_battery {
>  	struct iio_channel *channel;
>  	struct power_supply_desc desc;
>  	struct power_supply *battery;
> -	struct power_supply_battery_info info;
> +	struct power_supply_battery_info *info;
>  };
> =20
>  static int ingenic_battery_get_property(struct power_supply *psy,
> @@ -26,7 +26,7 @@ static int ingenic_battery_get_property(struct power_su=
pply *psy,
>  					union power_supply_propval *val)
>  {
>  	struct ingenic_battery *bat =3D power_supply_get_drvdata(psy);
> -	struct power_supply_battery_info *info =3D &bat->info;
> +	struct power_supply_battery_info *info =3D bat->info;
>  	int ret;
> =20
>  	switch (psp) {
> @@ -80,7 +80,7 @@ static int ingenic_battery_set_scale(struct ingenic_bat=
tery *bat)
>  	if (ret !=3D IIO_AVAIL_LIST || scale_type !=3D IIO_VAL_FRACTIONAL_LOG2)
>  		return -EINVAL;
> =20
> -	max_mV =3D bat->info.voltage_max_design_uv / 1000;
> +	max_mV =3D bat->info->voltage_max_design_uv / 1000;
> =20
>  	for (i =3D 0; i < scale_len; i +=3D 2) {
>  		u64 scale_mV =3D (max_raw * scale_raw[i]) >> scale_raw[i + 1];
> @@ -156,13 +156,13 @@ static int ingenic_battery_probe(struct platform_de=
vice *pdev)
>  		dev_err(dev, "Unable to get battery info: %d\n", ret);
>  		return ret;
>  	}
> -	if (bat->info.voltage_min_design_uv < 0) {
> +	if (bat->info->voltage_min_design_uv < 0) {
>  		dev_err(dev, "Unable to get voltage min design\n");
> -		return bat->info.voltage_min_design_uv;
> +		return bat->info->voltage_min_design_uv;
>  	}
> -	if (bat->info.voltage_max_design_uv < 0) {
> +	if (bat->info->voltage_max_design_uv < 0) {
>  		dev_err(dev, "Unable to get voltage max design\n");
> -		return bat->info.voltage_max_design_uv;
> +		return bat->info->voltage_max_design_uv;
>  	}
> =20
>  	return ingenic_battery_set_scale(bat);
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 2723d7d0ced3..ec838c9bcc0a 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -564,14 +564,19 @@ EXPORT_SYMBOL_GPL(devm_power_supply_get_by_phandle);
>  #endif /* CONFIG_OF */
> =20
>  int power_supply_get_battery_info(struct power_supply *psy,
> -				  struct power_supply_battery_info *info)
> +				  struct power_supply_battery_info **info_out)
>  {
>  	struct power_supply_resistance_temp_table *resist_table;
> +	struct power_supply_battery_info *info;
>  	struct device_node *battery_np;
>  	const char *value;
>  	int err, len, index;
>  	const __be32 *list;
> =20
> +	info =3D devm_kmalloc(&psy->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
>  	info->technology                     =3D POWER_SUPPLY_TECHNOLOGY_UNKNOW=
N;
>  	info->energy_full_design_uwh         =3D -EINVAL;
>  	info->charge_full_design_uah         =3D -EINVAL;
> @@ -581,6 +586,10 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
>  	info->charge_term_current_ua         =3D -EINVAL;
>  	info->constant_charge_current_max_ua =3D -EINVAL;
>  	info->constant_charge_voltage_max_uv =3D -EINVAL;
> +	info->tricklecharge_current_ua       =3D -EINVAL;
> +	info->precharge_voltage_max_uv       =3D -EINVAL;
> +	info->charge_restart_voltage_uv      =3D -EINVAL;
> +	info->overvoltage_limit_uv           =3D -EINVAL;
>  	info->temp_ambient_alert_min         =3D INT_MIN;
>  	info->temp_ambient_alert_max         =3D INT_MAX;
>  	info->temp_alert_min                 =3D INT_MIN;
> @@ -728,7 +737,7 @@ int power_supply_get_battery_info(struct power_supply=
 *psy,
> =20
>  	list =3D of_get_property(battery_np, "resistance-temp-table", &len);
>  	if (!list || !len)
> -		goto out_put_node;
> +		goto out_ret_pointer;
> =20
>  	info->resist_table_size =3D len / (2 * sizeof(__be32));
>  	resist_table =3D info->resist_table =3D devm_kcalloc(&psy->dev,
> @@ -746,6 +755,10 @@ int power_supply_get_battery_info(struct power_suppl=
y *psy,
>  		resist_table[index].resistance =3D be32_to_cpu(*list++);
>  	}
> =20
> +out_ret_pointer:
> +	/* Finally return the whole thing */
> +	*info_out =3D info;
> +
>  out_put_node:
>  	of_node_put(battery_np);
>  	return err;
> @@ -764,6 +777,8 @@ void power_supply_put_battery_info(struct power_suppl=
y *psy,
> =20
>  	if (info->resist_table)
>  		devm_kfree(&psy->dev, info->resist_table);
> +
> +	devm_kfree(&psy->dev, info);
>  }
>  EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
> =20
> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply=
/sc2731_charger.c
> index 288b79836c13..9ac17cf7a126 100644
> --- a/drivers/power/supply/sc2731_charger.c
> +++ b/drivers/power/supply/sc2731_charger.c
> @@ -368,7 +368,7 @@ static int sc2731_charger_usb_change(struct notifier_=
block *nb,
> =20
>  static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
>  {
> -	struct power_supply_battery_info bat_info =3D { };
> +	struct power_supply_battery_info *bat_info;
>  	u32 term_currrent, term_voltage, cur_val, vol_val;
>  	int ret;
> =20
> @@ -390,7 +390,7 @@ static int sc2731_charger_hw_init(struct sc2731_charg=
er_info *info)
>  		cur_val =3D 0x2;
>  		vol_val =3D 0x1;
>  	} else {
> -		term_currrent =3D bat_info.charge_term_current_ua / 1000;
> +		term_currrent =3D bat_info->charge_term_current_ua / 1000;
> =20
>  		if (term_currrent <=3D 90)
>  			cur_val =3D 0;
> @@ -399,7 +399,7 @@ static int sc2731_charger_hw_init(struct sc2731_charg=
er_info *info)
>  		else
>  			cur_val =3D ((term_currrent - 90) / 25) + 1;
> =20
> -		term_voltage =3D bat_info.constant_charge_voltage_max_uv / 1000;
> +		term_voltage =3D bat_info->constant_charge_voltage_max_uv / 1000;
> =20
>  		if (term_voltage > 4500)
>  			term_voltage =3D 4500;
> @@ -409,7 +409,7 @@ static int sc2731_charger_hw_init(struct sc2731_charg=
er_info *info)
>  		else
>  			vol_val =3D 0;
> =20
> -		power_supply_put_battery_info(info->psy_usb, &bat_info);
> +		power_supply_put_battery_info(info->psy_usb, bat_info);
>  	}
> =20
>  	/* Set charge termination current */
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/sup=
ply/sc27xx_fuel_gauge.c
> index ae45069bd5e1..632977f84b95 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -998,7 +998,7 @@ static int sc27xx_fgu_calibration(struct sc27xx_fgu_d=
ata *data)
> =20
>  static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
>  {
> -	struct power_supply_battery_info info =3D { };
> +	struct power_supply_battery_info *info;
>  	struct power_supply_battery_ocv_table *table;
>  	int ret, delta_clbcnt, alarm_adc;
> =20
> @@ -1008,16 +1008,16 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_d=
ata *data)
>  		return ret;
>  	}
> =20
> -	data->total_cap =3D info.charge_full_design_uah / 1000;
> -	data->max_volt =3D info.constant_charge_voltage_max_uv / 1000;
> -	data->internal_resist =3D info.factory_internal_resistance_uohm / 1000;
> -	data->min_volt =3D info.voltage_min_design_uv;
> +	data->total_cap =3D info->charge_full_design_uah / 1000;
> +	data->max_volt =3D info->constant_charge_voltage_max_uv / 1000;
> +	data->internal_resist =3D info->factory_internal_resistance_uohm / 1000;
> +	data->min_volt =3D info->voltage_min_design_uv;
> =20
>  	/*
>  	 * For SC27XX fuel gauge device, we only use one ocv-capacity
>  	 * table in normal temperature 20 Celsius.
>  	 */
> -	table =3D power_supply_find_ocv2cap_table(&info, 20, &data->table_len);
> +	table =3D power_supply_find_ocv2cap_table(info, 20, &data->table_len);
>  	if (!table)
>  		return -EINVAL;
> =20
> @@ -1025,7 +1025,7 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_dat=
a *data)
>  				       data->table_len * sizeof(*table),
>  				       GFP_KERNEL);
>  	if (!data->cap_table) {
> -		power_supply_put_battery_info(data->battery, &info);
> +		power_supply_put_battery_info(data->battery, info);
>  		return -ENOMEM;
>  	}
> =20
> @@ -1035,19 +1035,19 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_d=
ata *data)
>  	if (!data->alarm_cap)
>  		data->alarm_cap +=3D 1;
> =20
> -	data->resist_table_len =3D info.resist_table_size;
> +	data->resist_table_len =3D info->resist_table_size;
>  	if (data->resist_table_len > 0) {
> -		data->resist_table =3D devm_kmemdup(data->dev, info.resist_table,
> +		data->resist_table =3D devm_kmemdup(data->dev, info->resist_table,
>  						  data->resist_table_len *
>  						  sizeof(struct power_supply_resistance_temp_table),
>  						  GFP_KERNEL);
>  		if (!data->resist_table) {
> -			power_supply_put_battery_info(data->battery, &info);
> +			power_supply_put_battery_info(data->battery, info);
>  			return -ENOMEM;
>  		}
>  	}
> =20
> -	power_supply_put_battery_info(data->battery, &info);
> +	power_supply_put_battery_info(data->battery, info);
> =20
>  	ret =3D sc27xx_fgu_calibration(data);
>  	if (ret)
> diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply=
/smb347-charger.c
> index 753944e774c4..d56e469043bb 100644
> --- a/drivers/power/supply/smb347-charger.c
> +++ b/drivers/power/supply/smb347-charger.c
> @@ -1281,7 +1281,7 @@ static void smb347_dt_parse_dev_info(struct smb347_=
charger *smb)
> =20
>  static int smb347_get_battery_info(struct smb347_charger *smb)
>  {
> -	struct power_supply_battery_info info =3D {};
> +	struct power_supply_battery_info *info;
>  	struct power_supply *supply;
>  	int err;
> =20
> @@ -1296,29 +1296,29 @@ static int smb347_get_battery_info(struct smb347_=
charger *smb)
>  	if (err)
>  		return err;
> =20
> -	if (info.constant_charge_current_max_ua !=3D -EINVAL)
> -		smb->max_charge_current =3D info.constant_charge_current_max_ua;
> +	if (info->constant_charge_current_max_ua !=3D -EINVAL)
> +		smb->max_charge_current =3D info->constant_charge_current_max_ua;
> =20
> -	if (info.constant_charge_voltage_max_uv !=3D -EINVAL)
> -		smb->max_charge_voltage =3D info.constant_charge_voltage_max_uv;
> +	if (info->constant_charge_voltage_max_uv !=3D -EINVAL)
> +		smb->max_charge_voltage =3D info->constant_charge_voltage_max_uv;
> =20
> -	if (info.precharge_current_ua !=3D -EINVAL)
> -		smb->pre_charge_current =3D info.precharge_current_ua;
> +	if (info->precharge_current_ua !=3D -EINVAL)
> +		smb->pre_charge_current =3D info->precharge_current_ua;
> =20
> -	if (info.charge_term_current_ua !=3D -EINVAL)
> -		smb->termination_current =3D info.charge_term_current_ua;
> +	if (info->charge_term_current_ua !=3D -EINVAL)
> +		smb->termination_current =3D info->charge_term_current_ua;
> =20
> -	if (info.temp_alert_min !=3D INT_MIN)
> -		smb->soft_cold_temp_limit =3D info.temp_alert_min;
> +	if (info->temp_alert_min !=3D INT_MIN)
> +		smb->soft_cold_temp_limit =3D info->temp_alert_min;
> =20
> -	if (info.temp_alert_max !=3D INT_MAX)
> -		smb->soft_hot_temp_limit =3D info.temp_alert_max;
> +	if (info->temp_alert_max !=3D INT_MAX)
> +		smb->soft_hot_temp_limit =3D info->temp_alert_max;
> =20
> -	if (info.temp_min !=3D INT_MIN)
> -		smb->hard_cold_temp_limit =3D info.temp_min;
> +	if (info->temp_min !=3D INT_MIN)
> +		smb->hard_cold_temp_limit =3D info->temp_min;
> =20
> -	if (info.temp_max !=3D INT_MAX)
> -		smb->hard_hot_temp_limit =3D info.temp_max;
> +	if (info->temp_max !=3D INT_MAX)
> +		smb->hard_hot_temp_limit =3D info->temp_max;
> =20
>  	/* Suspend when battery temperature is outside hard limits */
>  	if (smb->hard_cold_temp_limit !=3D SMB3XX_TEMP_USE_DEFAULT ||
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index b5079109ac00..f8e318440e26 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -574,7 +574,7 @@ devm_power_supply_get_by_phandle(struct device *dev, =
const char *property)
>  #endif /* CONFIG_OF */
> =20
>  extern int power_supply_get_battery_info(struct power_supply *psy,
> -					 struct power_supply_battery_info *info);
> +					 struct power_supply_battery_info **info_out);
>  extern void power_supply_put_battery_info(struct power_supply *psy,
>  					  struct power_supply_battery_info *info);
>  extern int power_supply_ocv2cap_simple(struct power_supply_battery_ocv_t=
able *table,
> --=20
> 2.31.1
>=20

--i4zu3v5ng3lk7ulc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmHTPHMACgkQ2O7X88g7
+prufA/7BcT4rzspsYl474w41F4PURlFnCzDNNC9jkKB3G2AbSs9vR2M/GOpnmXR
rZF5WwXNf24UYg3b+uwQlt+YY2cx5OP041feEWwavPVHGHW4NSw/M0uTUzX3xvBz
L9RRQ50EHBY7tPlAJfiAiJqJpNkJJcpFxNROSauwwUYsNGlEwB8nqqO+uZB0liEN
POGSTPYMShoKWjTZcvNYc2oP0R8cPOhC3hib21vkgQJYdkCE8N6H5d+rFpu3nnih
/5DuXp5x7X7BmHOovxcUcJqHHTHTr+1j625yWVIatfHRqn47UQtWABWEebd/Uln7
nIB574MtZw0Uddvu30Zdld00xWE4lDQVC+0tL3X4fYx9W80r5YnftVxhSYpLxkh6
xKy6whOiQirx4CTtXMN0AJQPJX6H2cBvuRJLflAqgi9hVaLnRSOqbKC9x4jnElq/
lfeLKRbOg/qCBVRCzIVNapsAkrSWFbjs2fQLv6/smpJzu3Q5LkIfd3OuDXLTU3Bx
4hjMiZPQ/QwbqtwR8kWyahRQU+SEZ2oV75+7KLqBMx7mU8mJfNVdzwQzUuBJ16sh
mPEXYfjuiPVN8eC8aTGexLHpnDtkcJewNUtEcBtSgd0lvAgGOasq4mktWej6Apsp
ZnHS/KhRDFqEd3b/9fskjbZYKZmCmfHs4wtA8EbYSf4iv6nH91g=
=Z4Wt
-----END PGP SIGNATURE-----

--i4zu3v5ng3lk7ulc--
