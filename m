Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2B3E3D2D
	for <lists+linux-pm@lfdr.de>; Mon,  9 Aug 2021 01:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhHHXsB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 8 Aug 2021 19:48:01 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45574 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhHHXsA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Aug 2021 19:48:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 51E461F42222
Received: by earth.universe (Postfix, from userid 1000)
        id 1C6733C0C99; Mon,  9 Aug 2021 01:47:38 +0200 (CEST)
Date:   Mon, 9 Aug 2021 01:47:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Chris Morgan <macroalpha82@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, maccraft123mc@gmail.com,
        heiko@sntech.de, robh+dt@kernel.org, lee.jones@linaro.org,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [RFC v2 3/4] power: supply: Add charger driver for Rockchip RK817
Message-ID: <20210808234738.s76kgcswcff6xe4l@earth.universe>
References: <20210726190130.1973-1-macroalpha82@gmail.com>
 <20210726190130.1973-4-macroalpha82@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzazbjndfjo2c33z"
Content-Disposition: inline
In-Reply-To: <20210726190130.1973-4-macroalpha82@gmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--qzazbjndfjo2c33z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 26, 2021 at 02:01:29PM -0500, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>=20
> Add support for the Rockchip rk817 battery charger integrated into the
> rk817 PMIC.
>=20
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  drivers/power/supply/Kconfig         |   6 +
>  drivers/power/supply/Makefile        |   1 +
>  drivers/power/supply/rk817_charger.c | 932 +++++++++++++++++++++++++++
>  3 files changed, 939 insertions(+)
>  create mode 100644 drivers/power/supply/rk817_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 11f5368e810e..311130da36ff 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -666,6 +666,12 @@ config CHARGER_BQ256XX
>  	  charge management and system power path management devices for single
>  	  cell Li-ion and Li-polymer batteries.
> =20
> +config CHARGER_RK817
> +	tristate "Rockchip RK817 PMIC Battery Charger"
> +	depends on MFD_RK808
> +	help
> +	  Say Y to include support for Rockchip RK817 Battery Charger.
> +
>  config CHARGER_SMB347
>  	tristate "Summit Microelectronics SMB3XX Battery Charger"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 33059a91f60c..9497d2105712 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -87,6 +87,7 @@ obj-$(CONFIG_CHARGER_BQ2515X)	+=3D bq2515x_charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
>  obj-$(CONFIG_CHARGER_BQ25980)	+=3D bq25980_charger.o
>  obj-$(CONFIG_CHARGER_BQ256XX)	+=3D bq256xx_charger.o
> +obj-$(CONFIG_CHARGER_RK817)	+=3D rk817_charger.o
>  obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
>  obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
>  obj-$(CONFIG_CHARGER_TPS65217)	+=3D tps65217_charger.o
> diff --git a/drivers/power/supply/rk817_charger.c b/drivers/power/supply/=
rk817_charger.c
> new file mode 100644
> index 000000000000..0861bd428756
> --- /dev/null
> +++ b/drivers/power/supply/rk817_charger.c
> @@ -0,0 +1,932 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Charger Driver for Rockchip rk817
> + *
> + * Copyright (c) 2021
> + *
> + * Authors: Maya Matuszczyk <maccraft123mc@gmail.com>
> + *	    Chris Morgan <macromorgan@hotmail.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/extcon.h>
> +#include <linux/fb.h>
> +#include <linux/gpio.h>
> +#include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/irq.h>
> +#include <linux/jiffies.h>
> +#include <linux/mfd/rk808.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/rtc.h>
> +#include <linux/timer.h>
> +#include <linux/workqueue.h>
> +#include <linux/power_supply.h>

how the heck did you come up with those includes? You are neither
using extcon, framebuffer, gpio, iio, rtc, workqueue, nor timers.

> +/* Charging statuses reported by hardware register */
> +enum rk817_charge_status {
> +	CHRG_OFF,
> +	DEAD_CHRG,
> +	TRICKLE_CHRG,
> +	CC_OR_CV_CHRG,
> +	CHARGE_FINISH,
> +	USB_OVER_VOL,
> +	BAT_TMP_ERR,
> +	BAT_TIM_ERR,
> +};
> +
> +/* Max charging current read to/written from hardware register.
> + * Note how highest value corresponding to 0x7 is the lowest
> + * current, this is per the datasheet.
> + */
> +enum rk817_chg_cur {
> +	CHG_1A,
> +	CHG_1_5A,
> +	CHG_2A,
> +	CHG_2_5A,
> +	CHG_2_75A,
> +	CHG_3A,
> +	CHG_3_5A,
> +	CHG_0_5A,
> +};
> +
> +struct rk817_charger {
> +	struct device *dev;
> +	struct rk808 *rk808;
> +
> +	struct power_supply *bat_ps;
> +	struct power_supply_battery_info bat_info;
> +
> +	struct power_supply *chg_ps;
> +	bool plugged_in;
> +
> +	uint32_t voltage_k;
> +	uint32_t voltage_b;

what's voltage_k and voltage_b?

> +
> +	/* dsoc seems to be difference between full charge and actual charge in
> +	 * BSP stored as a percentage, to the thousandth.
> +	 */
> +	int dsoc;
> +
> +	/* Implementation specific properties from device tree */
> +	int res_div;
> +	int sleep_enter_current;
> +	int sleep_filter_current;
> +};
> +
> +/* ADC coefficients extracted from BSP kernel */
> +#define ADC_TO_CURRENT(adc_value, res_div)	\
> +	(adc_value * 172 / res_div)
> +
> +#define CURRENT_TO_ADC(current, samp_res)	\
> +	(current * samp_res / 172)
> +
> +#define CHARGE_TO_ADC(capacity, res_div)	\
> +	(capacity * res_div * 3600 / 172 * 1000)
> +
> +#define ADC_TO_CHARGE_UAH(adc_value, res_div)	\
> +	(adc_value / 3600 * 172 / res_div)
> +
> +#define ADC_TO_CAPACITY(adc_value, res_div)	\
> +	(adc_value / 1000 * 172 / 3600 / res_div)
> +
> +static u8 rk817_chg_cur_to_reg(u32 chg_cur_ma)
> +{
> +	if (chg_cur_ma < 500)
> +		return -EINVAL;
> +	else if (chg_cur_ma < 1000)
> +		return CHG_0_5A;
> +	else if (chg_cur_ma < 1500)
> +		return CHG_1A;
> +	else if (chg_cur_ma < 2000)
> +		return CHG_1_5A;
> +	else if (chg_cur_ma < 2500)
> +		return CHG_2A;
> +	else if (chg_cur_ma < 2750)
> +		return CHG_2_5A;
> +	else if (chg_cur_ma < 3000)
> +		return CHG_2_75A;
> +	else if (chg_cur_ma < 3500)
> +		return CHG_3A;
> +	else
> +		return CHG_3_5A;
> +}

if you change the order this becomes more readable:

if (chg_cur_ma > 3500)
    return CHG_3_5A;
else if (chg_cur_ma > 3000)
    return CHG_3A;
=2E..
else if (chg_cur_ma > 500)
    return CHG_0_5A;
else
    return -EINVAL;

> +static int rk817_chg_cur_from_reg(u8 reg)
> +{
> +	switch (reg) {
> +	case CHG_0_5A:
> +		return 500000;
> +	case CHG_1A:
> +		return 1000000;
> +	case CHG_1_5A:
> +		return 1500000;
> +	case CHG_2A:
> +		return 2000000;
> +	case CHG_2_5A:
> +		return 2500000;
> +	case CHG_2_75A:
> +		return 2750000;
> +	case CHG_3A:
> +		return 3000000;
> +	case CHG_3_5A:
> +		return 3500000;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int rk817_get_reg_hl(struct rk817_charger *charger, int regH, int=
 regL)
> +{
> +	int tmp, ret;
> +	uint32_t out;
> +	struct rk808 *rk808 =3D charger->rk808;
> +
> +	ret =3D regmap_read(rk808->regmap, regL, &tmp);
> +	if (ret)
> +		return ret;
> +	out =3D tmp;
> +
> +	ret =3D regmap_read(rk808->regmap, regH, &tmp);
> +	if (ret)
> +		return ret;
> +	out |=3D tmp << 8;
> +
> +	return out;
> +}
> +
> +static void rk817_write_reg_hl(struct rk817_charger *charger, int regH,
> +			       int regL, int val)
> +{
> +	uint8_t tmp;
> +	struct rk808 *rk808 =3D charger->rk808;
> +
> +	tmp =3D val & 0xff;
> +	regmap_write(rk808->regmap, regL, tmp);
> +	tmp =3D (val >> 8) & 0xff;
> +	regmap_write(rk808->regmap, regH, tmp);
> +}
> +
> +static void rk817_bat_calib_vol(struct rk817_charger *charger)
> +{
> +	uint32_t vcalib0 =3D 0;
> +	uint32_t vcalib1 =3D 0;
> +
> +	/* calibrate voltage */
> +	vcalib0 =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_VCALIB0_H,
> +				   RK817_GAS_GAUGE_VCALIB0_L);
> +	vcalib1 =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_VCALIB1_H,
> +				   RK817_GAS_GAUGE_VCALIB1_L);
> +
> +	/* values were taken from BSP kernel */
> +	charger->voltage_k =3D (4025 - 2300) * 1000 /
> +			     ((vcalib1 - vcalib0) ? (vcalib1 - vcalib0) : 1);
> +	charger->voltage_b =3D 4025 - (charger->voltage_k * vcalib1) / 1000;
> +}
> +
> +static void rk817_bat_calib_cur(struct rk817_charger *charger)
> +{
> +	int ioffset =3D 0;
> +	/* calibrate current */
> +	ioffset =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_IOFFSET_H,
> +				   RK817_GAS_GAUGE_IOFFSET_L);
> +	rk817_write_reg_hl(charger, RK817_GAS_GAUGE_CAL_OFFSET_H,
> +			   RK817_GAS_GAUGE_CAL_OFFSET_L, ioffset);
> +}
> +
> +static int rk817_bat_calib_cap(struct rk817_charger *charger)
> +{
> +	struct rk808 *rk808 =3D charger->rk808;
> +	struct power_supply_battery_info *info =3D &charger->bat_info;
> +	int reg, tmp, charge_now, charge_now_adc, dsoc_value;
> +	u8 bulk_reg[4];
> +
> +	/* Calibrate the capacity on a fully charged battery */
> +
> +	regmap_read(rk808->regmap, RK817_PMIC_CHRG_STS, &reg);
> +	tmp =3D (reg >> 4) & 0x07;
> +	if (tmp =3D=3D CHARGE_FINISH) {
> +		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
> +				 bulk_reg, 4);
> +		charge_now_adc =3D (bulk_reg[0] << 24) | (bulk_reg[1] << 16) |
> +				 (bulk_reg[2] << 8) | bulk_reg[3];

charge_now_adc =3D get_unaligned_be32(bulk_reg);

> +		if (charge_now_adc < 0)
> +			charge_now_adc =3D 0;
> +		charge_now =3D ADC_TO_CHARGE_UAH(charge_now_adc, charger->res_div);
> +		dsoc_value =3D ((charge_now * 100) /
> +			      (info->charge_full_design_uah / 1000));
> +		if (dsoc_value > 100000)
> +			charger->dsoc =3D 100000;
> +		if (dsoc_value !=3D charger->dsoc) {
> +			charger->dsoc =3D dsoc_value;
> +			bulk_reg[2] =3D (dsoc_value >> 16) & 0xff;
> +			bulk_reg[1] =3D (dsoc_value >> 8) & 0xff;
> +			bulk_reg[0] =3D dsoc_value & 0xff;

put_unaligned_le24(dsoc_value, bulk_reg);

> +			regmap_bulk_write(rk808->regmap,
> +					  RK817_GAS_GAUGE_BAT_R1, bulk_reg, 3);
> +		}
> +	}
> +
> +	return 0;
> +
> +}

extra newline at end of function.

> +
> +static int rk817_bat_get_prop(struct power_supply *ps,
> +		enum power_supply_property prop,
> +		union power_supply_propval *val)
> +{
> +	struct rk817_charger *charger =3D power_supply_get_drvdata(ps);
> +	uint32_t tmp =3D 0;
> +	/* Registers for current is a signed 16bit int */
> +	short int cur =3D 0;
> +	/* Registers for capacity-now is a signed 32bit int */
> +	int32_t charge_now =3D 0;
> +	int ret =3D 0;
> +	int reg =3D 0;
> +	u8 bulk_reg[4];
> +	struct rk808 *rk808 =3D charger->rk808;
> +
> +	/* Recalibrate voltage and current readings if we need to BSP does both
> +	 * on CUR_CALIB_UPD, ignoring VOL_CALIB_UPD. Curiously enough, both
> +	 * documentation and the BSP show that you perform an update if bit 7
> +	 * is 1, but you clear the status by writing a 1 to bit 7.
> +	 */
> +	regmap_read(rk808->regmap, RK817_GAS_GAUGE_ADC_CONFIG1, &reg);
> +	tmp =3D (reg >> 7) & 0x01;
> +	if (tmp) {
> +		rk817_bat_calib_cur(charger);
> +		rk817_bat_calib_vol(charger);
> +		regmap_write_bits(rk808->regmap, RK817_GAS_GAUGE_ADC_CONFIG1,
> +				   RK817_CUR_CALIB_UPD, (1 << 7));
> +	}
> +
> +	rk817_bat_calib_cap(charger);
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		regmap_read(rk808->regmap, RK817_PMIC_CHRG_STS, &reg);
> +		val->intval =3D (reg >> 7);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!charger->plugged_in) {
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +			break;
> +		}
> +		ret =3D regmap_read(rk808->regmap, RK817_PMIC_CHRG_STS, &reg);
> +		if (ret)
> +			return ret;
> +		tmp =3D (reg >> 4) & 0x07;
> +		switch (tmp) {
> +		case CHRG_OFF:
> +			val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +			break;
> +		/* Dead charge is documented, but not explained. I never
> +		 * observed it but assume it's a pre-charge for a dead
> +		 * battery.
> +		 */
> +		case DEAD_CHRG:
> +		case TRICKLE_CHRG:
> +		case CC_OR_CV_CHRG:
> +			val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +			break;
> +		case CHARGE_FINISH:
> +			val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +			break;
> +		default:
> +			val->intval =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +			return -EINVAL;
> +
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret =3D regmap_read(rk808->regmap, RK817_PMIC_CHRG_STS, &reg);
> +		if (ret)
> +			return ret;
> +		tmp =3D (reg >> 4) & 0x07;
> +		switch (tmp) {
> +		case CHRG_OFF:
> +		case CHARGE_FINISH:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +			break;
> +		case TRICKLE_CHRG:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +			break;
> +		case DEAD_CHRG:
> +		case CC_OR_CV_CHRG:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> +			break;
> +		default:
> +			val->intval =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +			break;
> +		}
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		val->intval =3D ((charger->bat_info.charge_full_design_uah /
> +			       1000) * charger->dsoc) / 100;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		val->intval =3D charger->bat_info.charge_full_design_uah;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN:
> +		val->intval =3D 0;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_NOW:
> +		regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_Q_PRES_H3,
> +				 bulk_reg, 4);
> +		charge_now =3D (bulk_reg[0] << 24) | (bulk_reg[1] << 16) |
> +			     (bulk_reg[2] << 8) | bulk_reg[3];

charge_now =3D get_unaligned_be32(bulk_reg);

> +		if (charge_now < 0)
> +			charge_now =3D 0;
> +		val->intval =3D ADC_TO_CHARGE_UAH(charge_now, charger->res_div);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		val->intval =3D charger->bat_info.voltage_min_design_uv;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_BOOT:
> +		tmp =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_PWRON_VOL_H,
> +				       RK817_GAS_GAUGE_PWRON_VOL_L);
> +		val->intval =3D (1000 * (((charger->voltage_k * tmp) / 1000) +
> +			       charger->voltage_b));

can be simplified to:

(charger->voltage_k * tmp) + 1000 * charger->voltage_b

> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		tmp =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_BAT_VOL_H,
> +				       RK817_GAS_GAUGE_BAT_VOL_L);
> +		val->intval =3D (1000 * (((charger->voltage_k * tmp) / 1000) +
> +			       charger->voltage_b));

same

> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_OCV:
> +		tmp =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_OCV_VOL_H,
> +				       RK817_GAS_GAUGE_OCV_VOL_H);
> +		val->intval =3D (1000 * (((charger->voltage_k * tmp) / 1000) +
> +			       charger->voltage_b));

same

> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_BOOT:
> +		cur =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_PWRON_CUR_H,
> +				       RK817_GAS_GAUGE_PWRON_CUR_H);
> +		val->intval =3D ADC_TO_CURRENT(cur, charger->res_div);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		cur =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_BAT_CUR_H,
> +				       RK817_GAS_GAUGE_BAT_CUR_L);
> +		val->intval =3D ADC_TO_CURRENT(cur, charger->res_div);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		regmap_read(rk808->regmap, RK817_PMIC_CHRG_OUT, &tmp);
> +		val->intval =3D rk817_chg_cur_from_reg(tmp & RK817_CHRG_CUR_SEL);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX:
> +		regmap_read(rk808->regmap, RK817_PMIC_CHRG_OUT, &tmp);
> +		val->intval =3D ((((tmp & RK817_CHRG_VOL_SEL) >> 4) * 50000) +
> +			       4100000);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D charger->bat_info.voltage_max_design_uv;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int rk817_chg_get_prop(struct power_supply *ps,
> +			      enum power_supply_property prop,
> +			      union power_supply_propval *val)
> +{
> +	struct rk817_charger *charger =3D power_supply_get_drvdata(ps);
> +	int vol, tmp =3D 0;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D charger->plugged_in;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		/* max voltage from datasheet at 5.5v (default 5.0v) */
> +		val->intval =3D 5500000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN:
> +		/* min voltage from datasheet at 3.8v (default 5.0v) */
> +		val->intval =3D 3800000;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		/* Note that on my example hardware (an Odroid Go Advance) the
> +		 * voltage of the power connector is measured on the register
> +		 * labelled USB in the datasheet; I don't know if this is how
> +		 * it is designed or just a quirk of the implementation. I
> +		 * believe this will also measure the voltage of the USB output
> +		 * when in OTG mode, if that is the case we may need to change
> +		 * this in the future to return 0 if the power supply status
> +		 * is offline.
> +		 */
> +		tmp =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_USB_VOL_H,
> +				       RK817_GAS_GAUGE_USB_VOL_L);
> +		vol =3D ((charger->voltage_k * tmp / 1000 + charger->voltage_b) *
> +		       60 / 46);
> +		val->intval =3D vol * 1000;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +
> +}
> +
> +static irqreturn_t rk817_plug_in_isr(int irq, void *cg)
> +{
> +	struct rk817_charger *charger;
> +
> +	charger =3D (struct rk817_charger *)cg;
> +	charger->plugged_in =3D 1;
> +	power_supply_changed(charger->chg_ps);
> +	power_supply_changed(charger->bat_ps);
> +	dev_dbg(charger->dev, "Power Cord Inserted\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t rk817_plug_out_isr(int irq, void *cg)
> +{
> +	struct rk817_charger *charger;
> +	struct rk808 *rk808;
> +
> +	charger =3D (struct rk817_charger *)cg;
> +	rk808 =3D charger->rk808;
> +	charger->plugged_in =3D 0;
> +	power_supply_changed(charger->bat_ps);
> +	power_supply_changed(charger->chg_ps);
> +
> +	/* For some reason the bits of RK817_PMIC_CHRG_IN reset whenever the
> +	 * power cord is unplugged. This was not documented in the BSP kernel
> +	 * or the datasheet and only discovered by trial and error. Set minimum
> +	 * USB input voltage to 4.5v and enable USB voltage input limit.
> +	 */
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN,
> +			  RK817_USB_VLIM_SEL, (0x05 << 4));
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN, RK817_USB_VLIM_EN,
> +			  (0x01 << 7));
> +
> +	/* Set average USB input current limit to 1.5A and enable USB current
> +	 * input limit.
> +	 */
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN,
> +			  RK817_USB_ILIM_SEL, 0x03);
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN, RK817_USB_ILIM_EN,
> +			  (0x01 << 3));
> +
> +	dev_dbg(charger->dev, "Power Cord Removed\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static enum power_supply_property rk817_bat_props[] =3D {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_EMPTY_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_NOW,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_BOOT,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_BOOT,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +};
> +
> +static enum power_supply_property rk817_chg_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +};
> +
> +static const struct power_supply_desc rk817_bat_desc =3D {
> +	.name =3D "rk817-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D rk817_bat_props,
> +	.num_properties =3D ARRAY_SIZE(rk817_bat_props),
> +	.get_property =3D rk817_bat_get_prop,
> +};
> +
> +/* Note that all known existing implementations use a "USB" port that is=
 either
> + * a power only port (no data lines) or use barrel plug to USB cable. Se=
tting
> + * to POWER_SUPPLY_TYPE_USB_DCP.
> + */
> +static const struct power_supply_desc rk817_chg_desc =3D {
> +	.name =3D "rk817-charger",
> +	.type =3D POWER_SUPPLY_TYPE_USB_DCP,

Please don't use that, it only exists for historical purposes.
Set type to POWER_SUPPLY_TYPE_USB and report=20
POWER_SUPPLY_USB_TYPE_DCP via the USB_TYPE property.

> +	.properties =3D rk817_chg_props,
> +	.num_properties =3D ARRAY_SIZE(rk817_chg_props),
> +	.get_property =3D rk817_chg_get_prop,
> +};
> +
> +static int rk817_read_or_set_full_charge_on_boot(struct rk817_charger *c=
harger)
> +{
> +	struct rk808 *rk808 =3D charger->rk808;
> +	struct power_supply_battery_info *info =3D &charger->bat_info;
> +	u8 reg[4];
> +	u32 design_charge_mah =3D (info->charge_full_design_uah / 1000);
> +	u32 boot_voltage, boot_charge, tmp, full_charge_cap;
> +	int ret, boot_capacity;
> +
> +	/* Read DSOC value if pre-existing. If not, initialize at 100%.
> +	 * Note endianness, also register says it's for resistance,
> +	 * however BSP kernel treats this as an nvram field for the DSOC
> +	 * as best I can tell. Doing the same for backwards compatibility.
> +	 */
> +	ret =3D regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_BAT_R1, reg, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	charger->dsoc =3D (reg[2] << 16) | (reg[1] << 8) | (reg[0]);

charger->dsoc =3D get_unaligned_le24(reg);

> +	/* If we have an invalid DSOC, write 100 (100000) as default. */
> +	if (charger->dsoc < 1000 || charger->dsoc > 100000) {
> +		regmap_write(rk808->regmap, RK817_GAS_GAUGE_BAT_R1, 0xa0);
> +		regmap_write(rk808->regmap, RK817_GAS_GAUGE_BAT_R2, 0x86);
> +		regmap_write(rk808->regmap, RK817_GAS_GAUGE_BAT_R3, 0x01);
> +		charger->dsoc =3D 100000;
> +	}
> +
> +	/* Register appears to be nvram that stores capacity in mAH. Note
> +	 * endianness, keeping consistent with BSP kernel, however it looks
> +	 * like we can use any arbitrary method to store value if we don't care
> +	 * about compatibility. Additionally, it doesn't appear that this value
> +	 * is used for anything, so realistically getting it and setting it is
> +	 * to ensure backward compatibility with BSP and serves no purpose with
> +	 * this driver, and I'm not sure if the BSP driver does anything with
> +	 * this value either.
> +	 */
> +
> +	ret =3D regmap_bulk_read(rk808->regmap, RK817_GAS_GAUGE_DATA3, reg, 3);
> +	if (ret < 0)
> +		return ret;
> +
> +	full_charge_cap =3D (reg[2] << 16) | (reg[1] << 8) | (reg[0]);

full_charge_cap =3D get_unaligned_le24(reg);

> +
> +	/* Sanity checking for values equal to zero or less than would be
> +	 * practical for this device (BSP Kernel assumes 500mAH or less) for
> +	 * practicality purposes.
> +	 */
> +	if (full_charge_cap < 500) {
> +		reg[2] =3D (design_charge_mah >> 16) & 0xff;
> +		reg[1] =3D (design_charge_mah >> 8) & 0xff;
> +		reg[0] =3D design_charge_mah & 0xff;
> +		ret =3D regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_DATA3, reg, 3=
);
> +		if (ret < 0)
> +			return ret;
> +		dev_info(charger->dev,
> +			 "Invalid NVRAM Data for max charge, setting to design capacity %u uA=
H\n",
> +			 design_charge_mah*1000);
> +	}
> +
> +	/* Capture boot voltage and look up boot capacity from OCV tables. */
> +
> +	tmp =3D rk817_get_reg_hl(charger, RK817_GAS_GAUGE_PWRON_VOL_H,
> +			       RK817_GAS_GAUGE_PWRON_VOL_L);
> +	boot_voltage =3D (1000 * (((charger->voltage_k * tmp) / 1000) +
> +			charger->voltage_b));
> +	/* Since only implementation has no working thermistor, assume 20C for
> +	 * OCV lookup. If lookup fails, report error with OCV table.
> +	 */
> +	boot_capacity =3D power_supply_batinfo_ocv2cap(info, boot_voltage, 20);
> +	if (boot_capacity < 0) {
> +		dev_err(charger->dev,
> +			"Unable to read boot charge from OCV table: %i\n",
> +			boot_capacity);
> +		return boot_capacity;
> +	}
> +
> +	/* Write boot charge to registers, estimate boot charge based on
> +	 * capacity and max charge of battery.
> +	 */
> +	boot_charge =3D (boot_capacity * info->charge_full_design_uah) / 100;
> +	tmp =3D CHARGE_TO_ADC((boot_charge / 1000), charger->res_div);
> +	regmap_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H3,
> +		     (tmp >> 24) & 0xFF);
> +	regmap_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_H2,
> +		     (tmp >> 16) & 0xFF);
> +	regmap_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_L1,
> +		     (tmp >> 8) & 0xFF);
> +	regmap_write(rk808->regmap, RK817_GAS_GAUGE_Q_INIT_L0,
> +		     tmp & 0xFF);

regmap_bulk_write?

> +
> +	/* Set QMAX value to max design capacity. */
> +	tmp =3D CHARGE_TO_ADC((info->charge_full_design_uah / 1000),
> +			    charger->res_div);
> +	reg[0] =3D (tmp >> 24) & 0xff;
> +	reg[1] =3D (tmp >> 16) & 0xff;
> +	reg[2] =3D (tmp >> 8) & 0xff;
> +	reg[3] =3D tmp & 0xff;

use put_unaligned_* API

> +	ret =3D regmap_bulk_write(rk808->regmap, RK817_GAS_GAUGE_Q_MAX_H3,
> +				reg, 4);
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +
> +}
> +
> +static int rk817_battery_init(struct rk817_charger *charger)
> +{
> +	struct rk808 *rk808 =3D charger->rk808;
> +	struct power_supply_battery_info *info =3D &charger->bat_info;
> +	u32 tmp, max_chg_vol_mv, max_chg_cur_ma;
> +	u8 max_chg_vol_reg, chg_term_i_reg, max_chg_cur_reg;
> +	int ret, chg_term_ma;
> +
> +	/* Get initial plug state */
> +	regmap_read(rk808->regmap, RK817_SYS_STS, &tmp);
> +	charger->plugged_in =3D (tmp & RK817_PLUG_IN_STS);
> +
> +	/* Turn on all ADC functions to measure battery, USB, and sys voltage,
> +	 * as well as batt temp. Note only tested implementation so far does
> +	 * not use a battery with a thermistor.
> +	 */
> +	regmap_write(rk808->regmap, RK817_GAS_GAUGE_ADC_CONFIG0, 0xfc);
> +
> +	/* Set relax mode voltage sampling interval and ADC offset calibration
> +	 * interval to 8 minutes to mirror BSP kernel. Set voltage and current
> +	 * modes to average to mirror BSP kernel.
> +	 */
> +	regmap_write(rk808->regmap, RK817_GAS_GAUGE_GG_CON, 0x04);
> +
> +	/* Write relax threshold, derived from sleep enter current. */
> +	tmp =3D CURRENT_TO_ADC(charger->sleep_enter_current, charger->res_div);
> +	rk817_write_reg_hl(charger, RK817_GAS_GAUGE_RELAX_THRE_H,
> +			   RK817_GAS_GAUGE_RELAX_THRE_L, tmp);
> +
> +	/* Write sleep sample current, derived from sleep filter current. */
> +	tmp =3D CURRENT_TO_ADC(charger->sleep_filter_current, charger->res_div);
> +	rk817_write_reg_hl(charger, RK817_GAS_GAUGE_SLEEP_CON_SAMP_CUR_H,
> +			   RK817_GAS_GAUGE_SLEEP_CON_SAMP_CUR_L, tmp);
> +
> +	/* Restart battery relax voltage */
> +	regmap_write_bits(rk808->regmap, RK817_GAS_GAUGE_GG_STS,
> +			  RK817_RELAX_VOL_UPD, (0x0 << 2));
> +
> +	/* Set OCV Threshold Voltage to 127.5mV. This was hard coded like this
> +	 * in the BSP.
> +	 */
> +	regmap_write(rk808->regmap, RK817_GAS_GAUGE_OCV_THRE_VOL, 0xff);
> +
> +	/* Set maximum charging voltage to battery max voltage. Trying to be
> +	 * incredibly safe with these value, as setting them wrong could
> +	 * overcharge the battery, which would be very bad.
> +	 */
> +	max_chg_vol_mv =3D info->constant_charge_voltage_max_uv / 1000;
> +	max_chg_cur_ma =3D info->constant_charge_current_max_ua / 1000;
> +
> +	if (max_chg_vol_mv < 4100) {
> +		dev_emerg(charger->dev,
> +			  "Danger, invalid max charger voltage! Value %u unsupported\n",
> +			  max_chg_vol_mv * 1000);
> +		return -EINVAL;


return dev_err_probe(charger->dev, -EINVAL, "invalid max charger voltage ..=
=2E",
                     max_chg_vol_mv * 1000);

> +	}
> +	if (max_chg_vol_mv > 4450) {
> +		dev_info(charger->dev,
> +			 "Setting max charge voltage to 4450000uv\n");
> +		max_chg_vol_mv =3D 4450;
> +	}
> +
> +	if (max_chg_cur_ma < 500) {
> +		dev_emerg(charger->dev,
> +			  "Danger, invalid max charger current! Value %u unsupported\n",
> +			  max_chg_cur_ma * 1000);

return dev_err_probe(...);

> +		return -EINVAL;
> +	}
> +	if (max_chg_cur_ma > 3500)
> +		dev_info(charger->dev,
> +			 "Setting max charge current to 3500000ua\n");
> +
> +	/* Now that the values are sanity checked, if we subtract 4100 from the
> +	 * max voltage and divide by 50, we conviently get the exact value for
> +	 * the registers, which are 4.1v, 4.15v, 4.2v, 4.25v, 4.3v, 4.35v,
> +	 * 4.4v, and 4.45v; these correspond to values 0x00 through 0x07.
> +	 */
> +	max_chg_vol_reg =3D (max_chg_vol_mv - 4100) / 50;
> +
> +	max_chg_cur_reg =3D rk817_chg_cur_to_reg(max_chg_cur_ma);
> +
> +	if (max_chg_vol_reg < 0 || max_chg_vol_reg > 7) {
> +		dev_emerg(charger->dev,
> +			  "Danger, invalid max charger voltage! Value %u unsupported\n",
> +			  max_chg_vol_mv * 1000);
> +		return -EINVAL;
> +	}

return dev_err_probe(...);

> +	if (max_chg_cur_reg < 0 || max_chg_cur_reg > 7) {
> +		dev_emerg(charger->dev,
> +			  "Danger, invalid max charger voltage! Value %u unsupported\n",
> +			  max_chg_cur_ma * 1000);
> +		return -EINVAL;
> +	}

return dev_err_probe(...);

> +
> +	/* Write the values to the registers, and deliver an emergency warning
> +	 * in the event they are not written correctly.
> +	 */
> +	ret =3D regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_OUT,
> +				RK817_CHRG_VOL_SEL, (max_chg_vol_reg << 4));
> +	if (ret) {
> +		dev_emerg(charger->dev,
> +			  "Danger, unable to set max charger voltage: %u\n",
> +			  ret);
> +	}
> +
> +	ret =3D regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_OUT,
> +				RK817_CHRG_CUR_SEL, max_chg_cur_reg);
> +	if (ret) {
> +		dev_emerg(charger->dev,
> +			  "Danger, unable to set max charger current: %u\n",
> +			  ret);
> +	}
> +
> +	/* Set charge finishing mode to analog */
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_TERM,
> +			  RK817_CHRG_TERM_ANA_DIG, (0x0 << 2));
> +
> +	/* Set charge finish current, warn if value not in range and keep
> +	 * default.
> +	 */
> +	chg_term_ma =3D info->charge_term_current_ua / 1000;
> +	if (chg_term_ma < 150 || chg_term_ma > 400) {
> +		dev_warn(charger->dev,
> +			 "Invalid charge termination value %u, keeping default\n",
> +			 chg_term_ma * 1000);
> +		chg_term_ma =3D 200;
> +	}
> +
> +	/* Values of 150ma, 200ma, 300ma, and 400ma correspond to 00, 01, 10,
> +	 * and 11.
> +	 */
> +	chg_term_i_reg =3D (chg_term_ma - 100) / 100;
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_TERM,
> +			  RK817_CHRG_TERM_ANA_SEL, chg_term_i_reg);
> +
> +	ret =3D rk817_read_or_set_full_charge_on_boot(charger);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set minimum USB input voltage to 4.5v and enable USB voltage input
> +	 * limit.
> +	 */
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN,
> +			  RK817_USB_VLIM_SEL, (0x05 << 4));
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN, RK817_USB_VLIM_EN,
> +			  (0x01 << 7));
> +
> +	/* Set average USB input current limit to 1.5A and enable USB current
> +	 * input limit.
> +	 */
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN,
> +			  RK817_USB_ILIM_SEL, 0x03);
> +	regmap_write_bits(rk808->regmap, RK817_PMIC_CHRG_IN, RK817_USB_ILIM_EN,
> +			  (0x01 << 3));
> +
> +	return 0;
> +

another useless empty line

> +}
> +
> +static int rk817_charger_probe(struct platform_device *pdev)
> +{
> +	struct rk808 *rk808 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct rk817_charger *charger;
> +	struct device_node *node;
> +	struct power_supply_battery_info *info;
> +	struct device *dev =3D &pdev->dev;
> +	struct power_supply_config pscfg =3D {};
> +	int plugin_irq, plugout_irq;
> +	int of_value;
> +	int ret;
> +
> +	node =3D of_get_child_by_name(dev->parent->of_node, "battery");
> +	if (!node)
> +		return -ENODEV;
> +
> +	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	charger->rk808 =3D rk808;
> +
> +	charger->dev =3D &pdev->dev;
> +	platform_set_drvdata(pdev, charger);
> +
> +	rk817_bat_calib_vol(charger);
> +
> +	pscfg.drv_data =3D charger;
> +	pscfg.of_node =3D node;
> +
> +	/* Get sample resistor value. Note only values of 10000 or 20000
> +	 * microohms are allowed. Schematic for my test implementation (an
> +	 * Odroid Go Advance) shows a 10 milliohm resistor for reference.
> +	 */
> +	ret =3D of_property_read_u32(node, "rockchip,resistor-sense", &of_value=
);

not using correct property unit:

https://github.com/devicetree-org/dt-schema/blob/master/schemas/property-un=
its.yaml

> +	if (ret < 0) {
> +		dev_err(dev, "Error reading sample resistor value: %i\n", ret);
> +		return ret;

return dev_err_probe(...);

> +	}
> +	/* Store as a 1 or a 2, since all we really use the value for is as a
> +	 * divisor in some calculations.
> +	 */
> +	charger->res_div =3D (of_value =3D=3D 20000) ? 2 : 1;
> +
> +	/* Get sleep enter current value. Not sure what this value is for
> +	 * other than to help calibrate the relax threshold.
> +	 */
> +	ret =3D of_property_read_u32(node, "rockchip,sleep-enter-current",
> +				   &of_value);

not using correct property unit:

https://github.com/devicetree-org/dt-schema/blob/master/schemas/property-un=
its.yaml

> +	if (ret < 0) {
> +		dev_err(dev, "Error reading sleep enter current value: %i\n",
> +			ret);
> +		return ret;

return dev_err_probe(...);

> +	}
> +	charger->sleep_enter_current =3D of_value;
> +
> +	/* Get sleep filter current value */
> +	ret =3D of_property_read_u32(node, "rockchip,sleep-filter-current",
> +				   &of_value);

not using correct property unit:

https://github.com/devicetree-org/dt-schema/blob/master/schemas/property-un=
its.yaml

> +	if (ret < 0) {
> +		dev_err(dev, "Error reading sleep filter current value: %i\n",
> +			ret);
> +		return ret;

return dev_err_probe(...);

> +	}
> +	charger->sleep_filter_current =3D of_value;
> +
> +	charger->bat_ps =3D devm_power_supply_register(&pdev->dev,
> +						     &rk817_bat_desc, &pscfg);
> +
> +	charger->chg_ps =3D devm_power_supply_register(&pdev->dev,
> +						     &rk817_chg_desc, &pscfg);
> +
> +	ret =3D power_supply_get_battery_info(charger->bat_ps,
> +					    &charger->bat_info);

You need to call power_supply_put_battery_info for the battery
info object once you no longer need it. I suppose in this case
it makes sense to do it via devm_add_action_or_reset().

> +	if (ret) {
> +		dev_err(dev, "Unable to get battery info: %d\n", ret);
> +		return ret;

return dev_err_probe(...);

> +	}
> +
> +	info =3D &charger->bat_info;
> +	if ((!info->charge_full_design_uah) ||
> +	    (!info->voltage_min_design_uv) ||
> +	    (!info->voltage_max_design_uv) ||
> +	    (!info->constant_charge_voltage_max_uv) ||
> +	    (!info->constant_charge_current_max_ua) ||
> +	    (!info->charge_term_current_ua)) {
> +		dev_err(dev, "Required battery information missing.\n");
> +		return -EINVAL;

return dev_err_probe(...);

> +	}
> +
> +	/* Has to run after power_supply_get_battery_info as it depends on some
> +	 * values discovered from that routine.
> +	 */
> +	ret =3D rk817_battery_init(charger);
> +	if (ret)
> +		return ret;
> +
> +	plugin_irq =3D platform_get_irq(pdev, 0);
> +	if (plugin_irq < 0)
> +		return plugin_irq;
> +
> +	plugout_irq =3D platform_get_irq(pdev, 1);
> +	if (plugout_irq < 0)
> +		return plugout_irq;
> +
> +	ret =3D devm_request_threaded_irq(charger->dev, plugin_irq, NULL,
> +					rk817_plug_in_isr,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"rk817_plug_in", charger);
> +	if (ret) {
> +		dev_err(&pdev->dev, "plug_in_irq request failed!\n");
> +		return ret;

return dev_err_probe(...);

> +	}
> +
> +	ret =3D devm_request_threaded_irq(charger->dev, plugout_irq, NULL,
> +					rk817_plug_out_isr,
> +					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					"rk817_plug_out", charger);
> +	if (ret) {
> +		dev_err(&pdev->dev, "plug_out_irq request failed!\n");
> +		return ret;

return dev_err_probe(...);

> +	}
> +
> +	return 0;
> +}
> +
> +
> +static struct platform_driver rk817_charger_driver =3D {
> +	.probe    =3D rk817_charger_probe,
> +	.driver   =3D {
> +		.name  =3D "rk817-charger",
> +	},
> +};
> +module_platform_driver(rk817_charger_driver);
> +
> +MODULE_DESCRIPTION("Battery power supply driver for RK817 PMIC");
> +MODULE_AUTHOR("Maya Matuszczyk <maccraft123mc@gmail.com>");
> +MODULE_LICENSE("GPL");

-- Sebastian

--qzazbjndfjo2c33z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmEQbRMACgkQ2O7X88g7
+ppupA/9G/oyffdga0x0D1leqF3UQ+u6aGr6TeiCveDuGGtwgMt9k8rGt1FEWUoC
Cc4vlz7CHPYQg4LcU60+H5ueNffVTPdgCzTS5OvSrYWmi+jDmmMifoIJZwtpvv7B
eSAcSF/R4Ckx2DcxiUCBNMhKAVzJfOENPC1VplZF3mEqZ8HDYA0ASld+0MJNV0Dj
W08C4NzWOlrnzMG1UaH6g6P7XJ//35UcbR4NtDomNwOc7udn596ed6ZNwVyrlxZp
BH61K9UnCYkUICuEvmos+44AecHPOnogT3GbDiaY86czF6mnjyvKD4bXqe/YgXh3
41NQp3I51EqCmcaj4OKbBhB/3PJojuRgVi/clBwa6TW+qvHM/4K5N0Z7tjgT5Uqo
6PqAWX2l4wo1/1Elvp7KCfXjqrZRxIhaysBQ/oNGW+vKM8YE8+hCqqikFM1x3kW5
CKo4RlrxOm2HPvAZgfQlN0VB/2NPgBurRX/+p5V5+gJ/1ayezMo5bqkRfpuoDaXP
uAObONswPf6KVIi5YLoUeoiykHbXgC6l/mi0VzfK816ceBv64ikAZXXxOwXxL0J1
HFN5lnXRnIKhHz6T7q6FRKZthP+r8T+XiMk3cqkiUH7La5T3EhTh8rIzTVsVLHIk
q4LF56+C17zdv5CeCxrA6wpx2CtNZvgP8pAp4ec6hFsYvZwWZWg=
=l0EQ
-----END PGP SIGNATURE-----

--qzazbjndfjo2c33z--
