Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA4A39A69A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 19:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhFCRF2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 13:05:28 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51410 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhFCRF2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 13:05:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5AFF31F434BC
Received: by earth.universe (Postfix, from userid 1000)
        id 808BD3C0C95; Thu,  3 Jun 2021 19:03:40 +0200 (CEST)
Date:   Thu, 3 Jun 2021 19:03:40 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] power: pm2301_charger: Delete driver
Message-ID: <20210603170340.cb7dte7bqn5lr5yq@earth.universe>
References: <20210528235952.438439-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wlacmrpb6putzxkb"
Content-Disposition: inline
In-Reply-To: <20210528235952.438439-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--wlacmrpb6putzxkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 29, 2021 at 01:59:52AM +0200, Linus Walleij wrote:
> The PM2301 was only used in tandem with AB9540, part of U9540,
> a platform that was cancelled and never deployed in products.
> Delete it.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Thanks, queued.

-- Sebastian

>  drivers/power/supply/Makefile         |    2 +-
>  drivers/power/supply/pm2301_charger.c | 1249 -------------------------
>  include/linux/pm2301_charger.h        |   48 -
>  3 files changed, 1 insertion(+), 1298 deletions(-)
>  delete mode 100644 drivers/power/supply/pm2301_charger.c
>  delete mode 100644 include/linux/pm2301_charger.h
>=20
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index a7309a3d1a47..16ebfaf6d55b 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -60,7 +60,7 @@ obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_ba=
ttery.o
>  obj-$(CONFIG_CHARGER_88PM860X)	+=3D 88pm860x_charger.o
>  obj-$(CONFIG_CHARGER_PCF50633)	+=3D pcf50633-charger.o
>  obj-$(CONFIG_BATTERY_RX51)	+=3D rx51_battery.o
> -obj-$(CONFIG_AB8500_BM)		+=3D ab8500_bmdata.o ab8500_charger.o ab8500_fg=
=2Eo ab8500_btemp.o abx500_chargalg.o pm2301_charger.o
> +obj-$(CONFIG_AB8500_BM)		+=3D ab8500_bmdata.o ab8500_charger.o ab8500_fg=
=2Eo ab8500_btemp.o abx500_chargalg.o
>  obj-$(CONFIG_CHARGER_CPCAP)	+=3D cpcap-charger.o
>  obj-$(CONFIG_CHARGER_ISP1704)	+=3D isp1704_charger.o
>  obj-$(CONFIG_CHARGER_MAX8903)	+=3D max8903_charger.o
> diff --git a/drivers/power/supply/pm2301_charger.c b/drivers/power/supply=
/pm2301_charger.c
> deleted file mode 100644
> index f86bbbeaff6c..000000000000
> --- a/drivers/power/supply/pm2301_charger.c
> +++ /dev/null
> @@ -1,1249 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright 2012 ST Ericsson.
> - *
> - * Power supply driver for ST Ericsson pm2xxx_charger charger
> - */
> -
> -#include <linux/init.h>
> -#include <linux/module.h>
> -#include <linux/device.h>
> -#include <linux/interrupt.h>
> -#include <linux/delay.h>
> -#include <linux/slab.h>
> -#include <linux/platform_device.h>
> -#include <linux/power_supply.h>
> -#include <linux/regulator/consumer.h>
> -#include <linux/err.h>
> -#include <linux/i2c.h>
> -#include <linux/workqueue.h>
> -#include <linux/mfd/abx500/ab8500.h>
> -#include <linux/pm2301_charger.h>
> -#include <linux/gpio.h>
> -#include <linux/pm_runtime.h>
> -#include <linux/pm.h>
> -
> -#include "ab8500-bm.h"
> -#include "ab8500-chargalg.h"
> -#include "pm2301_charger.h"
> -
> -#define to_pm2xxx_charger_ac_device_info(x) container_of((x), \
> -		struct pm2xxx_charger, ac_chg)
> -#define SLEEP_MIN		50
> -#define SLEEP_MAX		100
> -#define PM2XXX_AUTOSUSPEND_DELAY 500
> -
> -static int pm2xxx_interrupt_registers[] =3D {
> -	PM2XXX_REG_INT1,
> -	PM2XXX_REG_INT2,
> -	PM2XXX_REG_INT3,
> -	PM2XXX_REG_INT4,
> -	PM2XXX_REG_INT5,
> -	PM2XXX_REG_INT6,
> -};
> -
> -static enum power_supply_property pm2xxx_charger_ac_props[] =3D {
> -	POWER_SUPPLY_PROP_HEALTH,
> -	POWER_SUPPLY_PROP_PRESENT,
> -	POWER_SUPPLY_PROP_ONLINE,
> -	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> -};
> -
> -static int pm2xxx_charger_voltage_map[] =3D {
> -	3500,
> -	3525,
> -	3550,
> -	3575,
> -	3600,
> -	3625,
> -	3650,
> -	3675,
> -	3700,
> -	3725,
> -	3750,
> -	3775,
> -	3800,
> -	3825,
> -	3850,
> -	3875,
> -	3900,
> -	3925,
> -	3950,
> -	3975,
> -	4000,
> -	4025,
> -	4050,
> -	4075,
> -	4100,
> -	4125,
> -	4150,
> -	4175,
> -	4200,
> -	4225,
> -	4250,
> -	4275,
> -	4300,
> -};
> -
> -static int pm2xxx_charger_current_map[] =3D {
> -	200,
> -	200,
> -	400,
> -	600,
> -	800,
> -	1000,
> -	1200,
> -	1400,
> -	1600,
> -	1800,
> -	2000,
> -	2200,
> -	2400,
> -	2600,
> -	2800,
> -	3000,
> -};
> -
> -static void set_lpn_pin(struct pm2xxx_charger *pm2)
> -{
> -	if (!pm2->ac.charger_connected && gpio_is_valid(pm2->lpn_pin)) {
> -		gpio_set_value(pm2->lpn_pin, 1);
> -		usleep_range(SLEEP_MIN, SLEEP_MAX);
> -	}
> -}
> -
> -static void clear_lpn_pin(struct pm2xxx_charger *pm2)
> -{
> -	if (!pm2->ac.charger_connected && gpio_is_valid(pm2->lpn_pin))
> -		gpio_set_value(pm2->lpn_pin, 0);
> -}
> -
> -static int pm2xxx_reg_read(struct pm2xxx_charger *pm2, int reg, u8 *val)
> -{
> -	int ret;
> -
> -	/* wake up the device */
> -	pm_runtime_get_sync(pm2->dev);
> -
> -	ret =3D i2c_smbus_read_i2c_block_data(pm2->config.pm2xxx_i2c, reg,
> -				1, val);
> -	if (ret < 0)
> -		dev_err(pm2->dev, "Error reading register at 0x%x\n", reg);
> -	else
> -		ret =3D 0;
> -
> -	pm_runtime_put_sync(pm2->dev);
> -
> -	return ret;
> -}
> -
> -static int pm2xxx_reg_write(struct pm2xxx_charger *pm2, int reg, u8 val)
> -{
> -	int ret;
> -
> -	/* wake up the device */
> -	pm_runtime_get_sync(pm2->dev);
> -
> -	ret =3D i2c_smbus_write_i2c_block_data(pm2->config.pm2xxx_i2c, reg,
> -				1, &val);
> -	if (ret < 0)
> -		dev_err(pm2->dev, "Error writing register at 0x%x\n", reg);
> -	else
> -		ret =3D 0;
> -
> -	pm_runtime_put_sync(pm2->dev);
> -
> -	return ret;
> -}
> -
> -static int pm2xxx_charging_enable_mngt(struct pm2xxx_charger *pm2)
> -{
> -	int ret;
> -
> -	/* Enable charging */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG2,
> -			(PM2XXX_CH_AUTO_RESUME_EN | PM2XXX_CHARGER_ENA));
> -
> -	return ret;
> -}
> -
> -static int pm2xxx_charging_disable_mngt(struct pm2xxx_charger *pm2)
> -{
> -	int ret;
> -
> -	/* Disable SW EOC ctrl */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_SW_CTRL_REG, PM2XXX_SWCTRL_HW);
> -	if (ret < 0) {
> -		dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
> -		return ret;
> -	}
> -
> -	/* Disable charging */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG2,
> -			(PM2XXX_CH_AUTO_RESUME_DIS | PM2XXX_CHARGER_DIS));
> -	if (ret < 0) {
> -		dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
> -		return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -static int pm2xxx_charger_batt_therm_mngt(struct pm2xxx_charger *pm2, in=
t val)
> -{
> -	queue_work(pm2->charger_wq, &pm2->check_main_thermal_prot_work);
> -
> -	return 0;
> -}
> -
> -
> -static int pm2xxx_charger_die_therm_mngt(struct pm2xxx_charger *pm2, int=
 val)
> -{
> -	queue_work(pm2->charger_wq, &pm2->check_main_thermal_prot_work);
> -
> -	return 0;
> -}
> -
> -static int pm2xxx_charger_ovv_mngt(struct pm2xxx_charger *pm2, int val)
> -{
> -	dev_err(pm2->dev, "Overvoltage detected\n");
> -	pm2->flags.ovv =3D true;
> -	power_supply_changed(pm2->ac_chg.psy);
> -
> -	/* Schedule a new HW failure check */
> -	queue_delayed_work(pm2->charger_wq, &pm2->check_hw_failure_work, 0);
> -
> -	return 0;
> -}
> -
> -static int pm2xxx_charger_wd_exp_mngt(struct pm2xxx_charger *pm2, int va=
l)
> -{
> -	dev_dbg(pm2->dev , "20 minutes watchdog expired\n");
> -
> -	pm2->ac.wd_expired =3D true;
> -	power_supply_changed(pm2->ac_chg.psy);
> -
> -	return 0;
> -}
> -
> -static int pm2xxx_charger_vbat_lsig_mngt(struct pm2xxx_charger *pm2, int=
 val)
> -{
> -	int ret;
> -
> -	switch (val) {
> -	case PM2XXX_INT1_ITVBATLOWR:
> -		dev_dbg(pm2->dev, "VBAT grows above VBAT_LOW level\n");
> -		/* Enable SW EOC ctrl */
> -		ret =3D pm2xxx_reg_write(pm2, PM2XXX_SW_CTRL_REG,
> -							PM2XXX_SWCTRL_SW);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
> -			return ret;
> -		}
> -		break;
> -
> -	case PM2XXX_INT1_ITVBATLOWF:
> -		dev_dbg(pm2->dev, "VBAT drops below VBAT_LOW level\n");
> -		/* Disable SW EOC ctrl */
> -		ret =3D pm2xxx_reg_write(pm2, PM2XXX_SW_CTRL_REG,
> -							PM2XXX_SWCTRL_HW);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
> -			return ret;
> -		}
> -		break;
> -
> -	default:
> -		dev_err(pm2->dev, "Unknown VBAT level\n");
> -	}
> -
> -	return 0;
> -}
> -
> -static int pm2xxx_charger_bat_disc_mngt(struct pm2xxx_charger *pm2, int =
val)
> -{
> -	dev_dbg(pm2->dev, "battery disconnected\n");
> -
> -	return 0;
> -}
> -
> -static int pm2xxx_charger_detection(struct pm2xxx_charger *pm2, u8 *val)
> -{
> -	int ret;
> -
> -	ret =3D pm2xxx_reg_read(pm2, PM2XXX_SRCE_REG_INT2, val);
> -
> -	if (ret < 0) {
> -		dev_err(pm2->dev, "Charger detection failed\n");
> -		goto out;
> -	}
> -
> -	*val &=3D (PM2XXX_INT2_S_ITVPWR1PLUG | PM2XXX_INT2_S_ITVPWR2PLUG);
> -
> -out:
> -	return ret;
> -}
> -
> -static int pm2xxx_charger_itv_pwr_plug_mngt(struct pm2xxx_charger *pm2, =
int val)
> -{
> -
> -	int ret;
> -	u8 read_val;
> -
> -	/*
> -	 * Since we can't be sure that the events are received
> -	 * synchronously, we have the check if the main charger is
> -	 * connected by reading the interrupt source register.
> -	 */
> -	ret =3D pm2xxx_charger_detection(pm2, &read_val);
> -
> -	if ((ret =3D=3D 0) && read_val) {
> -		pm2->ac.charger_connected =3D 1;
> -		pm2->ac_conn =3D true;
> -		queue_work(pm2->charger_wq, &pm2->ac_work);
> -	}
> -
> -
> -	return ret;
> -}
> -
> -static int pm2xxx_charger_itv_pwr_unplug_mngt(struct pm2xxx_charger *pm2,
> -								int val)
> -{
> -	pm2->ac.charger_connected =3D 0;
> -	queue_work(pm2->charger_wq, &pm2->ac_work);
> -
> -	return 0;
> -}
> -
> -static int pm2_int_reg0(void *pm2_data, int val)
> -{
> -	struct pm2xxx_charger *pm2 =3D pm2_data;
> -	int ret =3D 0;
> -
> -	if (val & PM2XXX_INT1_ITVBATLOWR) {
> -		ret =3D pm2xxx_charger_vbat_lsig_mngt(pm2,
> -						PM2XXX_INT1_ITVBATLOWR);
> -		if (ret < 0)
> -			goto out;
> -	}
> -
> -	if (val & PM2XXX_INT1_ITVBATLOWF) {
> -		ret =3D pm2xxx_charger_vbat_lsig_mngt(pm2,
> -						PM2XXX_INT1_ITVBATLOWF);
> -		if (ret < 0)
> -			goto out;
> -	}
> -
> -	if (val & PM2XXX_INT1_ITVBATDISCONNECT) {
> -		ret =3D pm2xxx_charger_bat_disc_mngt(pm2,
> -				PM2XXX_INT1_ITVBATDISCONNECT);
> -		if (ret < 0)
> -			goto out;
> -	}
> -out:
> -	return ret;
> -}
> -
> -static int pm2_int_reg1(void *pm2_data, int val)
> -{
> -	struct pm2xxx_charger *pm2 =3D pm2_data;
> -	int ret =3D 0;
> -
> -	if (val & (PM2XXX_INT2_ITVPWR1PLUG | PM2XXX_INT2_ITVPWR2PLUG)) {
> -		dev_dbg(pm2->dev , "Main charger plugged\n");
> -		ret =3D pm2xxx_charger_itv_pwr_plug_mngt(pm2, val &
> -			(PM2XXX_INT2_ITVPWR1PLUG | PM2XXX_INT2_ITVPWR2PLUG));
> -	}
> -
> -	if (val &
> -		(PM2XXX_INT2_ITVPWR1UNPLUG | PM2XXX_INT2_ITVPWR2UNPLUG)) {
> -		dev_dbg(pm2->dev , "Main charger unplugged\n");
> -		ret =3D pm2xxx_charger_itv_pwr_unplug_mngt(pm2, val &
> -						(PM2XXX_INT2_ITVPWR1UNPLUG |
> -						PM2XXX_INT2_ITVPWR2UNPLUG));
> -	}
> -
> -	return ret;
> -}
> -
> -static int pm2_int_reg2(void *pm2_data, int val)
> -{
> -	struct pm2xxx_charger *pm2 =3D pm2_data;
> -	int ret =3D 0;
> -
> -	if (val & PM2XXX_INT3_ITAUTOTIMEOUTWD)
> -		ret =3D pm2xxx_charger_wd_exp_mngt(pm2, val);
> -
> -	if (val & (PM2XXX_INT3_ITCHPRECHARGEWD |
> -				PM2XXX_INT3_ITCHCCWD | PM2XXX_INT3_ITCHCVWD)) {
> -		dev_dbg(pm2->dev,
> -			"Watchdog occurred for precharge, CC and CV charge\n");
> -	}
> -
> -	return ret;
> -}
> -
> -static int pm2_int_reg3(void *pm2_data, int val)
> -{
> -	struct pm2xxx_charger *pm2 =3D pm2_data;
> -	int ret =3D 0;
> -
> -	if (val & (PM2XXX_INT4_ITCHARGINGON)) {
> -		dev_dbg(pm2->dev ,
> -			"charging operation has started\n");
> -	}
> -
> -	if (val & (PM2XXX_INT4_ITVRESUME)) {
> -		dev_dbg(pm2->dev,
> -			"battery discharged down to VResume threshold\n");
> -	}
> -
> -	if (val & (PM2XXX_INT4_ITBATTFULL)) {
> -		dev_dbg(pm2->dev , "battery fully detected\n");
> -	}
> -
> -	if (val & (PM2XXX_INT4_ITCVPHASE)) {
> -		dev_dbg(pm2->dev, "CV phase enter with 0.5C charging\n");
> -	}
> -
> -	if (val & (PM2XXX_INT4_ITVPWR2OVV | PM2XXX_INT4_ITVPWR1OVV)) {
> -		pm2->failure_case =3D VPWR_OVV;
> -		ret =3D pm2xxx_charger_ovv_mngt(pm2, val &
> -			(PM2XXX_INT4_ITVPWR2OVV | PM2XXX_INT4_ITVPWR1OVV));
> -		dev_dbg(pm2->dev, "VPWR/VSYSTEM overvoltage detected\n");
> -	}
> -
> -	if (val & (PM2XXX_INT4_S_ITBATTEMPCOLD |
> -				PM2XXX_INT4_S_ITBATTEMPHOT)) {
> -		ret =3D pm2xxx_charger_batt_therm_mngt(pm2, val &
> -			(PM2XXX_INT4_S_ITBATTEMPCOLD |
> -			PM2XXX_INT4_S_ITBATTEMPHOT));
> -		dev_dbg(pm2->dev, "BTEMP is too Low/High\n");
> -	}
> -
> -	return ret;
> -}
> -
> -static int pm2_int_reg4(void *pm2_data, int val)
> -{
> -	struct pm2xxx_charger *pm2 =3D pm2_data;
> -	int ret =3D 0;
> -
> -	if (val & PM2XXX_INT5_ITVSYSTEMOVV) {
> -		pm2->failure_case =3D VSYSTEM_OVV;
> -		ret =3D pm2xxx_charger_ovv_mngt(pm2, val &
> -						PM2XXX_INT5_ITVSYSTEMOVV);
> -		dev_dbg(pm2->dev, "VSYSTEM overvoltage detected\n");
> -	}
> -
> -	if (val & (PM2XXX_INT5_ITTHERMALWARNINGFALL |
> -				PM2XXX_INT5_ITTHERMALWARNINGRISE |
> -				PM2XXX_INT5_ITTHERMALSHUTDOWNFALL |
> -				PM2XXX_INT5_ITTHERMALSHUTDOWNRISE)) {
> -		dev_dbg(pm2->dev, "BTEMP die temperature is too Low/High\n");
> -		ret =3D pm2xxx_charger_die_therm_mngt(pm2, val &
> -			(PM2XXX_INT5_ITTHERMALWARNINGFALL |
> -			PM2XXX_INT5_ITTHERMALWARNINGRISE |
> -			PM2XXX_INT5_ITTHERMALSHUTDOWNFALL |
> -			PM2XXX_INT5_ITTHERMALSHUTDOWNRISE));
> -	}
> -
> -	return ret;
> -}
> -
> -static int pm2_int_reg5(void *pm2_data, int val)
> -{
> -	struct pm2xxx_charger *pm2 =3D pm2_data;
> -
> -	if (val & (PM2XXX_INT6_ITVPWR2DROP | PM2XXX_INT6_ITVPWR1DROP)) {
> -		dev_dbg(pm2->dev, "VMPWR drop to VBAT level\n");
> -	}
> -
> -	if (val & (PM2XXX_INT6_ITVPWR2VALIDRISE |
> -			PM2XXX_INT6_ITVPWR1VALIDRISE |
> -			PM2XXX_INT6_ITVPWR2VALIDFALL |
> -			PM2XXX_INT6_ITVPWR1VALIDFALL)) {
> -		dev_dbg(pm2->dev, "Falling/Rising edge on WPWR1/2\n");
> -	}
> -
> -	return 0;
> -}
> -
> -static irqreturn_t  pm2xxx_irq_int(int irq, void *data)
> -{
> -	struct pm2xxx_charger *pm2 =3D data;
> -	struct pm2xxx_interrupts *interrupt =3D pm2->pm2_int;
> -	int i;
> -
> -	/* wake up the device */
> -	pm_runtime_get_sync(pm2->dev);
> -
> -	do {
> -		for (i =3D 0; i < PM2XXX_NUM_INT_REG; i++) {
> -			pm2xxx_reg_read(pm2,
> -				pm2xxx_interrupt_registers[i],
> -				&(interrupt->reg[i]));
> -
> -			if (interrupt->reg[i] > 0)
> -				interrupt->handler[i](pm2, interrupt->reg[i]);
> -		}
> -	} while (gpio_get_value(pm2->pdata->gpio_irq_number) =3D=3D 0);
> -
> -	pm_runtime_mark_last_busy(pm2->dev);
> -	pm_runtime_put_autosuspend(pm2->dev);
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int pm2xxx_charger_get_ac_cv(struct pm2xxx_charger *pm2)
> -{
> -	int ret =3D 0;
> -	u8 val;
> -
> -	if (pm2->ac.charger_connected && pm2->ac.charger_online) {
> -
> -		ret =3D pm2xxx_reg_read(pm2, PM2XXX_SRCE_REG_INT4, &val);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
> -			goto out;
> -		}
> -
> -		if (val & PM2XXX_INT4_S_ITCVPHASE)
> -			ret =3D PM2XXX_CONST_VOLT;
> -		else
> -			ret =3D PM2XXX_CONST_CURR;
> -	}
> -out:
> -	return ret;
> -}
> -
> -static int pm2xxx_current_to_regval(int curr)
> -{
> -	int i;
> -
> -	if (curr < pm2xxx_charger_current_map[0])
> -		return 0;
> -
> -	for (i =3D 1; i < ARRAY_SIZE(pm2xxx_charger_current_map); i++) {
> -		if (curr < pm2xxx_charger_current_map[i])
> -			return (i - 1);
> -	}
> -
> -	i =3D ARRAY_SIZE(pm2xxx_charger_current_map) - 1;
> -	if (curr =3D=3D pm2xxx_charger_current_map[i])
> -		return i;
> -	else
> -		return -EINVAL;
> -}
> -
> -static int pm2xxx_voltage_to_regval(int curr)
> -{
> -	int i;
> -
> -	if (curr < pm2xxx_charger_voltage_map[0])
> -		return 0;
> -
> -	for (i =3D 1; i < ARRAY_SIZE(pm2xxx_charger_voltage_map); i++) {
> -		if (curr < pm2xxx_charger_voltage_map[i])
> -			return i - 1;
> -	}
> -
> -	i =3D ARRAY_SIZE(pm2xxx_charger_voltage_map) - 1;
> -	if (curr =3D=3D pm2xxx_charger_voltage_map[i])
> -		return i;
> -	else
> -		return -EINVAL;
> -}
> -
> -static int pm2xxx_charger_update_charger_current(struct ux500_charger *c=
harger,
> -		int ich_out)
> -{
> -	int ret;
> -	int curr_index;
> -	struct pm2xxx_charger *pm2;
> -	u8 val;
> -
> -	if (charger->psy->desc->type =3D=3D POWER_SUPPLY_TYPE_MAINS)
> -		pm2 =3D to_pm2xxx_charger_ac_device_info(charger);
> -	else
> -		return -ENXIO;
> -
> -	curr_index =3D pm2xxx_current_to_regval(ich_out);
> -	if (curr_index < 0) {
> -		dev_err(pm2->dev,
> -			"Charger current too high, charging not started\n");
> -		return -ENXIO;
> -	}
> -
> -	ret =3D pm2xxx_reg_read(pm2, PM2XXX_BATT_CTRL_REG6, &val);
> -	if (ret >=3D 0) {
> -		val &=3D ~PM2XXX_DIR_CH_CC_CURRENT_MASK;
> -		val |=3D curr_index;
> -		ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG6, val);
> -		if (ret < 0) {
> -			dev_err(pm2->dev,
> -				"%s write failed\n", __func__);
> -		}
> -	}
> -	else
> -		dev_err(pm2->dev, "%s read failed\n", __func__);
> -
> -	return ret;
> -}
> -
> -static int pm2xxx_charger_ac_get_property(struct power_supply *psy,
> -	enum power_supply_property psp,
> -	union power_supply_propval *val)
> -{
> -	struct pm2xxx_charger *pm2;
> -
> -	pm2 =3D to_pm2xxx_charger_ac_device_info(psy_to_ux500_charger(psy));
> -
> -	switch (psp) {
> -	case POWER_SUPPLY_PROP_HEALTH:
> -		if (pm2->flags.mainextchnotok)
> -			val->intval =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> -		else if (pm2->ac.wd_expired)
> -			val->intval =3D POWER_SUPPLY_HEALTH_DEAD;
> -		else if (pm2->flags.main_thermal_prot)
> -			val->intval =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> -		else if (pm2->flags.ovv)
> -			val->intval =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> -		else
> -			val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> -		break;
> -	case POWER_SUPPLY_PROP_ONLINE:
> -		val->intval =3D pm2->ac.charger_online;
> -		break;
> -	case POWER_SUPPLY_PROP_PRESENT:
> -		val->intval =3D pm2->ac.charger_connected;
> -		break;
> -	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> -		pm2->ac.cv_active =3D pm2xxx_charger_get_ac_cv(pm2);
> -		val->intval =3D pm2->ac.cv_active;
> -		break;
> -	default:
> -		return -EINVAL;
> -	}
> -	return 0;
> -}
> -
> -static int pm2xxx_charging_init(struct pm2xxx_charger *pm2)
> -{
> -	int ret =3D 0;
> -
> -	/* enable CC and CV watchdog */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG3,
> -		(PM2XXX_CH_WD_CV_PHASE_60MIN | PM2XXX_CH_WD_CC_PHASE_60MIN));
> -	if( ret < 0)
> -		return ret;
> -
> -	/* enable precharge watchdog */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG4,
> -					PM2XXX_CH_WD_PRECH_PHASE_60MIN);
> -
> -	/* Disable auto timeout */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG5,
> -					PM2XXX_CH_WD_AUTO_TIMEOUT_20MIN);
> -
> -	/*
> -     * EOC current level =3D 100mA
> -	 * Precharge current level =3D 100mA
> -	 * CC current level =3D 1000mA
> -	 */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG6,
> -		(PM2XXX_DIR_CH_CC_CURRENT_1000MA |
> -		PM2XXX_CH_PRECH_CURRENT_100MA |
> -		PM2XXX_CH_EOC_CURRENT_100MA));
> -
> -	/*
> -     * recharge threshold =3D 3.8V
> -	 * Precharge to CC threshold =3D 2.9V
> -	 */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG7,
> -		(PM2XXX_CH_PRECH_VOL_2_9 | PM2XXX_CH_VRESUME_VOL_3_8));
> -
> -	/* float voltage charger level =3D 4.2V */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG8,
> -		PM2XXX_CH_VOLT_4_2);
> -
> -	/* Voltage drop between VBAT and VSYS in HW charging =3D 300mV */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG9,
> -		(PM2XXX_CH_150MV_DROP_300MV | PM2XXX_CHARCHING_INFO_DIS |
> -		PM2XXX_CH_CC_REDUCED_CURRENT_IDENT |
> -		PM2XXX_CH_CC_MODEDROP_DIS));
> -
> -	/* Input charger level of over voltage =3D 10V */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_INP_VOLT_VPWR2,
> -					PM2XXX_VPWR2_OVV_10);
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_INP_VOLT_VPWR1,
> -					PM2XXX_VPWR1_OVV_10);
> -
> -	/* Input charger drop */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_INP_DROP_VPWR2,
> -		(PM2XXX_VPWR2_HW_OPT_DIS | PM2XXX_VPWR2_VALID_DIS |
> -		PM2XXX_VPWR2_DROP_DIS));
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_INP_DROP_VPWR1,
> -		(PM2XXX_VPWR1_HW_OPT_DIS | PM2XXX_VPWR1_VALID_DIS |
> -		PM2XXX_VPWR1_DROP_DIS));
> -
> -	/* Disable battery low monitoring */
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_LOW_LEV_COMP_REG,
> -		PM2XXX_VBAT_LOW_MONITORING_ENA);
> -
> -	return ret;
> -}
> -
> -static int pm2xxx_charger_ac_en(struct ux500_charger *charger,
> -	int enable, int vset, int iset)
> -{
> -	int ret;
> -	int volt_index;
> -	int curr_index;
> -	u8 val;
> -
> -	struct pm2xxx_charger *pm2 =3D to_pm2xxx_charger_ac_device_info(charger=
);
> -
> -	if (enable) {
> -		if (!pm2->ac.charger_connected) {
> -			dev_dbg(pm2->dev, "AC charger not connected\n");
> -			return -ENXIO;
> -		}
> -
> -		dev_dbg(pm2->dev, "Enable AC: %dmV %dmA\n", vset, iset);
> -		if (!pm2->vddadc_en_ac) {
> -			ret =3D regulator_enable(pm2->regu);
> -			if (ret)
> -				dev_warn(pm2->dev,
> -					"Failed to enable vddadc regulator\n");
> -			else
> -				pm2->vddadc_en_ac =3D true;
> -		}
> -
> -		ret =3D pm2xxx_charging_init(pm2);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s charging init failed\n",
> -					__func__);
> -			goto error_occured;
> -		}
> -
> -		volt_index =3D pm2xxx_voltage_to_regval(vset);
> -		curr_index =3D pm2xxx_current_to_regval(iset);
> -
> -		if (volt_index < 0 || curr_index < 0) {
> -			dev_err(pm2->dev,
> -				"Charger voltage or current too high, "
> -				"charging not started\n");
> -			return -ENXIO;
> -		}
> -
> -		ret =3D pm2xxx_reg_read(pm2, PM2XXX_BATT_CTRL_REG8, &val);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
> -			goto error_occured;
> -		}
> -		val &=3D ~PM2XXX_CH_VOLT_MASK;
> -		val |=3D volt_index;
> -		ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG8, val);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
> -			goto error_occured;
> -		}
> -
> -		ret =3D pm2xxx_reg_read(pm2, PM2XXX_BATT_CTRL_REG6, &val);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
> -			goto error_occured;
> -		}
> -		val &=3D ~PM2XXX_DIR_CH_CC_CURRENT_MASK;
> -		val |=3D curr_index;
> -		ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_CTRL_REG6, val);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "%s pm2xxx write failed\n", __func__);
> -			goto error_occured;
> -		}
> -
> -		if (!pm2->bat->enable_overshoot) {
> -			ret =3D pm2xxx_reg_read(pm2, PM2XXX_LED_CTRL_REG, &val);
> -			if (ret < 0) {
> -				dev_err(pm2->dev, "%s pm2xxx read failed\n",
> -								__func__);
> -				goto error_occured;
> -			}
> -			val |=3D PM2XXX_ANTI_OVERSHOOT_EN;
> -			ret =3D pm2xxx_reg_write(pm2, PM2XXX_LED_CTRL_REG, val);
> -			if (ret < 0) {
> -				dev_err(pm2->dev, "%s pm2xxx write failed\n",
> -								__func__);
> -				goto error_occured;
> -			}
> -		}
> -
> -		ret =3D pm2xxx_charging_enable_mngt(pm2);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "Failed to enable"
> -						"pm2xxx ac charger\n");
> -			goto error_occured;
> -		}
> -
> -		pm2->ac.charger_online =3D 1;
> -	} else {
> -		pm2->ac.charger_online =3D 0;
> -		pm2->ac.wd_expired =3D false;
> -
> -		/* Disable regulator if enabled */
> -		if (pm2->vddadc_en_ac) {
> -			regulator_disable(pm2->regu);
> -			pm2->vddadc_en_ac =3D false;
> -		}
> -
> -		ret =3D pm2xxx_charging_disable_mngt(pm2);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "failed to disable"
> -						"pm2xxx ac charger\n");
> -			goto error_occured;
> -		}
> -
> -		dev_dbg(pm2->dev, "PM2301: " "Disabled AC charging\n");
> -	}
> -	power_supply_changed(pm2->ac_chg.psy);
> -
> -error_occured:
> -	return ret;
> -}
> -
> -static int pm2xxx_charger_watchdog_kick(struct ux500_charger *charger)
> -{
> -	int ret;
> -	struct pm2xxx_charger *pm2;
> -
> -	if (charger->psy->desc->type =3D=3D POWER_SUPPLY_TYPE_MAINS)
> -		pm2 =3D to_pm2xxx_charger_ac_device_info(charger);
> -	else
> -		return -ENXIO;
> -
> -	ret =3D pm2xxx_reg_write(pm2, PM2XXX_BATT_WD_KICK, WD_TIMER);
> -	if (ret)
> -		dev_err(pm2->dev, "Failed to kick WD!\n");
> -
> -	return ret;
> -}
> -
> -static void pm2xxx_charger_ac_work(struct work_struct *work)
> -{
> -	struct pm2xxx_charger *pm2 =3D container_of(work,
> -		struct pm2xxx_charger, ac_work);
> -
> -
> -	power_supply_changed(pm2->ac_chg.psy);
> -	sysfs_notify(&pm2->ac_chg.psy->dev.kobj, NULL, "present");
> -};
> -
> -static void pm2xxx_charger_check_hw_failure_work(struct work_struct *wor=
k)
> -{
> -	u8 reg_value;
> -
> -	struct pm2xxx_charger *pm2 =3D container_of(work,
> -		struct pm2xxx_charger, check_hw_failure_work.work);
> -
> -	if (pm2->flags.ovv) {
> -		pm2xxx_reg_read(pm2, PM2XXX_SRCE_REG_INT4, &reg_value);
> -
> -		if (!(reg_value & (PM2XXX_INT4_S_ITVPWR1OVV |
> -					PM2XXX_INT4_S_ITVPWR2OVV))) {
> -			pm2->flags.ovv =3D false;
> -			power_supply_changed(pm2->ac_chg.psy);
> -		}
> -	}
> -
> -	/* If we still have a failure, schedule a new check */
> -	if (pm2->flags.ovv) {
> -		queue_delayed_work(pm2->charger_wq,
> -			&pm2->check_hw_failure_work, round_jiffies(HZ));
> -	}
> -}
> -
> -static void pm2xxx_charger_check_main_thermal_prot_work(
> -	struct work_struct *work)
> -{
> -	int ret;
> -	u8 val;
> -
> -	struct pm2xxx_charger *pm2 =3D container_of(work, struct pm2xxx_charger,
> -					check_main_thermal_prot_work);
> -
> -	/* Check if die temp warning is still active */
> -	ret =3D pm2xxx_reg_read(pm2, PM2XXX_SRCE_REG_INT5, &val);
> -	if (ret < 0) {
> -		dev_err(pm2->dev, "%s pm2xxx read failed\n", __func__);
> -		return;
> -	}
> -	if (val & (PM2XXX_INT5_S_ITTHERMALWARNINGRISE
> -			| PM2XXX_INT5_S_ITTHERMALSHUTDOWNRISE))
> -		pm2->flags.main_thermal_prot =3D true;
> -	else if (val & (PM2XXX_INT5_S_ITTHERMALWARNINGFALL
> -				| PM2XXX_INT5_S_ITTHERMALSHUTDOWNFALL))
> -		pm2->flags.main_thermal_prot =3D false;
> -
> -	power_supply_changed(pm2->ac_chg.psy);
> -}
> -
> -static struct pm2xxx_interrupts pm2xxx_int =3D {
> -	.handler[0] =3D pm2_int_reg0,
> -	.handler[1] =3D pm2_int_reg1,
> -	.handler[2] =3D pm2_int_reg2,
> -	.handler[3] =3D pm2_int_reg3,
> -	.handler[4] =3D pm2_int_reg4,
> -	.handler[5] =3D pm2_int_reg5,
> -};
> -
> -static struct pm2xxx_irq pm2xxx_charger_irq[] =3D {
> -	{"PM2XXX_IRQ_INT", pm2xxx_irq_int},
> -};
> -
> -static int __maybe_unused pm2xxx_wall_charger_resume(struct device *dev)
> -{
> -	struct i2c_client *i2c_client =3D to_i2c_client(dev);
> -	struct pm2xxx_charger *pm2;
> -
> -	pm2 =3D  (struct pm2xxx_charger *)i2c_get_clientdata(i2c_client);
> -	set_lpn_pin(pm2);
> -
> -	/* If we still have a HW failure, schedule a new check */
> -	if (pm2->flags.ovv)
> -		queue_delayed_work(pm2->charger_wq,
> -				&pm2->check_hw_failure_work, 0);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused pm2xxx_wall_charger_suspend(struct device *dev)
> -{
> -	struct i2c_client *i2c_client =3D to_i2c_client(dev);
> -	struct pm2xxx_charger *pm2;
> -
> -	pm2 =3D  (struct pm2xxx_charger *)i2c_get_clientdata(i2c_client);
> -	clear_lpn_pin(pm2);
> -
> -	/* Cancel any pending HW failure check */
> -	if (delayed_work_pending(&pm2->check_hw_failure_work))
> -		cancel_delayed_work(&pm2->check_hw_failure_work);
> -
> -	flush_work(&pm2->ac_work);
> -	flush_work(&pm2->check_main_thermal_prot_work);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused pm2xxx_runtime_suspend(struct device *dev)
> -{
> -	struct i2c_client *pm2xxx_i2c_client =3D to_i2c_client(dev);
> -	struct pm2xxx_charger *pm2;
> -
> -	pm2 =3D (struct pm2xxx_charger *)i2c_get_clientdata(pm2xxx_i2c_client);
> -	clear_lpn_pin(pm2);
> -
> -	return 0;
> -}
> -
> -static int __maybe_unused pm2xxx_runtime_resume(struct device *dev)
> -{
> -	struct i2c_client *pm2xxx_i2c_client =3D to_i2c_client(dev);
> -	struct pm2xxx_charger *pm2;
> -
> -	pm2 =3D (struct pm2xxx_charger *)i2c_get_clientdata(pm2xxx_i2c_client);
> -
> -	if (gpio_is_valid(pm2->lpn_pin) && gpio_get_value(pm2->lpn_pin) =3D=3D =
0)
> -		set_lpn_pin(pm2);
> -
> -	return 0;
> -}
> -
> -static const struct dev_pm_ops pm2xxx_pm_ops __maybe_unused =3D {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm2xxx_wall_charger_suspend,
> -		pm2xxx_wall_charger_resume)
> -	SET_RUNTIME_PM_OPS(pm2xxx_runtime_suspend, pm2xxx_runtime_resume, NULL)
> -};
> -
> -static int pm2xxx_wall_charger_probe(struct i2c_client *i2c_client,
> -		const struct i2c_device_id *id)
> -{
> -	struct pm2xxx_platform_data *pl_data =3D i2c_client->dev.platform_data;
> -	struct power_supply_config psy_cfg =3D {};
> -	struct pm2xxx_charger *pm2;
> -	int ret =3D 0;
> -	u8 val;
> -	int i;
> -
> -	if (!pl_data) {
> -		dev_err(&i2c_client->dev, "No platform data supplied\n");
> -		return -EINVAL;
> -	}
> -
> -	pm2 =3D kzalloc(sizeof(struct pm2xxx_charger), GFP_KERNEL);
> -	if (!pm2) {
> -		dev_err(&i2c_client->dev, "pm2xxx_charger allocation failed\n");
> -		return -ENOMEM;
> -	}
> -
> -	/* get parent data */
> -	pm2->dev =3D &i2c_client->dev;
> -
> -	pm2->pm2_int =3D &pm2xxx_int;
> -
> -	/* get charger spcific platform data */
> -	if (!pl_data->wall_charger) {
> -		dev_err(pm2->dev, "no charger platform data supplied\n");
> -		ret =3D -EINVAL;
> -		goto free_device_info;
> -	}
> -
> -	pm2->pdata =3D pl_data->wall_charger;
> -
> -	/* get battery specific platform data */
> -	if (!pl_data->battery) {
> -		dev_err(pm2->dev, "no battery platform data supplied\n");
> -		ret =3D -EINVAL;
> -		goto free_device_info;
> -	}
> -
> -	pm2->bat =3D pl_data->battery;
> -
> -	if (!i2c_check_functionality(i2c_client->adapter,
> -			I2C_FUNC_SMBUS_BYTE_DATA |
> -			I2C_FUNC_SMBUS_READ_WORD_DATA)) {
> -		ret =3D -ENODEV;
> -		dev_info(pm2->dev, "pm2301 i2c_check_functionality failed\n");
> -		goto free_device_info;
> -	}
> -
> -	pm2->config.pm2xxx_i2c =3D i2c_client;
> -	pm2->config.pm2xxx_id =3D (struct i2c_device_id *) id;
> -	i2c_set_clientdata(i2c_client, pm2);
> -
> -	/* AC supply */
> -	/* power_supply base class */
> -	pm2->ac_chg_desc.name =3D pm2->pdata->label;
> -	pm2->ac_chg_desc.type =3D POWER_SUPPLY_TYPE_MAINS;
> -	pm2->ac_chg_desc.properties =3D pm2xxx_charger_ac_props;
> -	pm2->ac_chg_desc.num_properties =3D ARRAY_SIZE(pm2xxx_charger_ac_props);
> -	pm2->ac_chg_desc.get_property =3D pm2xxx_charger_ac_get_property;
> -
> -	psy_cfg.supplied_to =3D pm2->pdata->supplied_to;
> -	psy_cfg.num_supplicants =3D pm2->pdata->num_supplicants;
> -	/* pm2xxx_charger sub-class */
> -	pm2->ac_chg.ops.enable =3D &pm2xxx_charger_ac_en;
> -	pm2->ac_chg.ops.kick_wd =3D &pm2xxx_charger_watchdog_kick;
> -	pm2->ac_chg.ops.update_curr =3D &pm2xxx_charger_update_charger_current;
> -	pm2->ac_chg.max_out_volt =3D pm2xxx_charger_voltage_map[
> -		ARRAY_SIZE(pm2xxx_charger_voltage_map) - 1];
> -	pm2->ac_chg.max_out_curr =3D pm2xxx_charger_current_map[
> -		ARRAY_SIZE(pm2xxx_charger_current_map) - 1];
> -	pm2->ac_chg.wdt_refresh =3D WD_KICK_INTERVAL;
> -	pm2->ac_chg.enabled =3D true;
> -	pm2->ac_chg.external =3D true;
> -
> -	/* Create a work queue for the charger */
> -	pm2->charger_wq =3D alloc_ordered_workqueue("pm2xxx_charger_wq",
> -						  WQ_MEM_RECLAIM);
> -	if (pm2->charger_wq =3D=3D NULL) {
> -		ret =3D -ENOMEM;
> -		dev_err(pm2->dev, "failed to create work queue\n");
> -		goto free_device_info;
> -	}
> -
> -	/* Init work for charger detection */
> -	INIT_WORK(&pm2->ac_work, pm2xxx_charger_ac_work);
> -
> -	/* Init work for checking HW status */
> -	INIT_WORK(&pm2->check_main_thermal_prot_work,
> -		pm2xxx_charger_check_main_thermal_prot_work);
> -
> -	/* Init work for HW failure check */
> -	INIT_DEFERRABLE_WORK(&pm2->check_hw_failure_work,
> -		pm2xxx_charger_check_hw_failure_work);
> -
> -	/*
> -	 * VDD ADC supply needs to be enabled from this driver when there
> -	 * is a charger connected to avoid erroneous BTEMP_HIGH/LOW
> -	 * interrupts during charging
> -	 */
> -	pm2->regu =3D regulator_get(pm2->dev, "vddadc");
> -	if (IS_ERR(pm2->regu)) {
> -		ret =3D PTR_ERR(pm2->regu);
> -		dev_err(pm2->dev, "failed to get vddadc regulator\n");
> -		goto free_charger_wq;
> -	}
> -
> -	/* Register AC charger class */
> -	pm2->ac_chg.psy =3D power_supply_register(pm2->dev, &pm2->ac_chg_desc,
> -						&psy_cfg);
> -	if (IS_ERR(pm2->ac_chg.psy)) {
> -		dev_err(pm2->dev, "failed to register AC charger\n");
> -		ret =3D PTR_ERR(pm2->ac_chg.psy);
> -		goto free_regulator;
> -	}
> -
> -	/* Register interrupts */
> -	ret =3D request_threaded_irq(gpio_to_irq(pm2->pdata->gpio_irq_number),
> -				NULL,
> -				pm2xxx_charger_irq[0].isr,
> -				pm2->pdata->irq_type | IRQF_ONESHOT,
> -				pm2xxx_charger_irq[0].name, pm2);
> -
> -	if (ret !=3D 0) {
> -		dev_err(pm2->dev, "failed to request %s IRQ %d: %d\n",
> -		pm2xxx_charger_irq[0].name,
> -			gpio_to_irq(pm2->pdata->gpio_irq_number), ret);
> -		goto unregister_pm2xxx_charger;
> -	}
> -
> -	ret =3D pm_runtime_set_active(pm2->dev);
> -	if (ret)
> -		dev_err(pm2->dev, "set active Error\n");
> -
> -	pm_runtime_enable(pm2->dev);
> -	pm_runtime_set_autosuspend_delay(pm2->dev, PM2XXX_AUTOSUSPEND_DELAY);
> -	pm_runtime_use_autosuspend(pm2->dev);
> -	pm_runtime_resume(pm2->dev);
> -
> -	/* pm interrupt can wake up system */
> -	ret =3D enable_irq_wake(gpio_to_irq(pm2->pdata->gpio_irq_number));
> -	if (ret) {
> -		dev_err(pm2->dev, "failed to set irq wake\n");
> -		goto unregister_pm2xxx_interrupt;
> -	}
> -
> -	mutex_init(&pm2->lock);
> -
> -	if (gpio_is_valid(pm2->pdata->lpn_gpio)) {
> -		/* get lpn GPIO from platform data */
> -		pm2->lpn_pin =3D pm2->pdata->lpn_gpio;
> -
> -		/*
> -		 * Charger detection mechanism requires pulling up the LPN pin
> -		 * while i2c communication if Charger is not connected
> -		 * LPN pin of PM2301 is GPIO60 of AB9540
> -		 */
> -		ret =3D gpio_request(pm2->lpn_pin, "pm2301_lpm_gpio");
> -
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "pm2301_lpm_gpio request failed\n");
> -			goto disable_pm2_irq_wake;
> -		}
> -		ret =3D gpio_direction_output(pm2->lpn_pin, 0);
> -		if (ret < 0) {
> -			dev_err(pm2->dev, "pm2301_lpm_gpio direction failed\n");
> -			goto free_gpio;
> -		}
> -		set_lpn_pin(pm2);
> -	}
> -
> -	/* read  interrupt registers */
> -	for (i =3D 0; i < PM2XXX_NUM_INT_REG; i++)
> -		pm2xxx_reg_read(pm2,
> -			pm2xxx_interrupt_registers[i],
> -			&val);
> -
> -	ret =3D pm2xxx_charger_detection(pm2, &val);
> -
> -	if ((ret =3D=3D 0) && val) {
> -		pm2->ac.charger_connected =3D 1;
> -		ab8500_override_turn_on_stat(~AB8500_POW_KEY_1_ON,
> -					     AB8500_MAIN_CH_DET);
> -		pm2->ac_conn =3D true;
> -		power_supply_changed(pm2->ac_chg.psy);
> -		sysfs_notify(&pm2->ac_chg.psy->dev.kobj, NULL, "present");
> -	}
> -
> -	return 0;
> -
> -free_gpio:
> -	if (gpio_is_valid(pm2->lpn_pin))
> -		gpio_free(pm2->lpn_pin);
> -disable_pm2_irq_wake:
> -	disable_irq_wake(gpio_to_irq(pm2->pdata->gpio_irq_number));
> -unregister_pm2xxx_interrupt:
> -	/* disable interrupt */
> -	free_irq(gpio_to_irq(pm2->pdata->gpio_irq_number), pm2);
> -unregister_pm2xxx_charger:
> -	/* unregister power supply */
> -	power_supply_unregister(pm2->ac_chg.psy);
> -free_regulator:
> -	/* disable the regulator */
> -	regulator_put(pm2->regu);
> -free_charger_wq:
> -	destroy_workqueue(pm2->charger_wq);
> -free_device_info:
> -	kfree(pm2);
> -
> -	return ret;
> -}
> -
> -static int pm2xxx_wall_charger_remove(struct i2c_client *i2c_client)
> -{
> -	struct pm2xxx_charger *pm2 =3D i2c_get_clientdata(i2c_client);
> -
> -	/* Disable pm_runtime */
> -	pm_runtime_disable(pm2->dev);
> -	/* Disable AC charging */
> -	pm2xxx_charger_ac_en(&pm2->ac_chg, false, 0, 0);
> -
> -	/* Disable wake by pm interrupt */
> -	disable_irq_wake(gpio_to_irq(pm2->pdata->gpio_irq_number));
> -
> -	/* Disable interrupts */
> -	free_irq(gpio_to_irq(pm2->pdata->gpio_irq_number), pm2);
> -
> -	/* Delete the work queue */
> -	destroy_workqueue(pm2->charger_wq);
> -
> -	flush_scheduled_work();
> -
> -	/* disable the regulator */
> -	regulator_put(pm2->regu);
> -
> -	power_supply_unregister(pm2->ac_chg.psy);
> -
> -	if (gpio_is_valid(pm2->lpn_pin))
> -		gpio_free(pm2->lpn_pin);
> -
> -	kfree(pm2);
> -
> -	return 0;
> -}
> -
> -static const struct i2c_device_id pm2xxx_id[] =3D {
> -	{ "pm2301", 0 },
> -	{ }
> -};
> -
> -MODULE_DEVICE_TABLE(i2c, pm2xxx_id);
> -
> -static struct i2c_driver pm2xxx_charger_driver =3D {
> -	.probe =3D pm2xxx_wall_charger_probe,
> -	.remove =3D pm2xxx_wall_charger_remove,
> -	.driver =3D {
> -		.name =3D "pm2xxx-wall_charger",
> -		.pm =3D IS_ENABLED(CONFIG_PM) ? &pm2xxx_pm_ops : NULL,
> -	},
> -	.id_table =3D pm2xxx_id,
> -};
> -
> -static int __init pm2xxx_charger_init(void)
> -{
> -	return i2c_add_driver(&pm2xxx_charger_driver);
> -}
> -
> -static void __exit pm2xxx_charger_exit(void)
> -{
> -	i2c_del_driver(&pm2xxx_charger_driver);
> -}
> -
> -device_initcall_sync(pm2xxx_charger_init);
> -module_exit(pm2xxx_charger_exit);
> -
> -MODULE_LICENSE("GPL v2");
> -MODULE_AUTHOR("Rajkumar kasirajan, Olivier Launay");
> -MODULE_DESCRIPTION("PM2xxx charger management driver");
> diff --git a/include/linux/pm2301_charger.h b/include/linux/pm2301_charge=
r.h
> deleted file mode 100644
> index b8fac96f05aa..000000000000
> --- a/include/linux/pm2301_charger.h
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * PM2301 charger driver.
> - *
> - * Copyright (C) 2012 ST Ericsson Corporation
> - *
> - * Contact: Olivier LAUNAY (olivier.launay@stericsson.com
> - */
> -
> -#ifndef __LINUX_PM2301_H
> -#define __LINUX_PM2301_H
> -
> -/**
> - * struct pm2xxx_bm_charger_parameters - Charger specific parameters
> - * @ac_volt_max:	maximum allowed AC charger voltage in mV
> - * @ac_curr_max:	maximum allowed AC charger current in mA
> - */
> -struct pm2xxx_bm_charger_parameters {
> -	int ac_volt_max;
> -	int ac_curr_max;
> -};
> -
> -/**
> - * struct pm2xxx_bm_data - pm2xxx battery management data
> - * @enable_overshoot    flag to enable VBAT overshoot control
> - * @chg_params	  charger parameters
> - */
> -struct pm2xxx_bm_data {
> -	bool enable_overshoot;
> -	const struct pm2xxx_bm_charger_parameters *chg_params;
> -};
> -
> -struct pm2xxx_charger_platform_data {
> -	char **supplied_to;
> -	size_t num_supplicants;
> -	int i2c_bus;
> -	const char *label;
> -	int gpio_irq_number;
> -	unsigned int lpn_gpio;
> -	int irq_type;
> -};
> -
> -struct pm2xxx_platform_data {
> -	struct pm2xxx_charger_platform_data *wall_charger;
> -	struct pm2xxx_bm_data *battery;
> -};
> -
> -#endif /* __LINUX_PM2301_H */
> --=20
> 2.31.1
>=20

--wlacmrpb6putzxkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmC5C2QACgkQ2O7X88g7
+pr2Dg//UKJfXv0vmn7UDBWqdmnq+lngxx2ET07O3pMM8p0gsV7RjXHgWAgguWiE
pgfJs7WtonlVIW5MZfb9C4x+QEu+HNvZEXJurug88TvLZF/MV+YbIiuOZ75otx9O
gSsW1UCDa3lKxPul3sr/hL6nInbk/zaSfAex7dNxXUeBCLqeap+dOoofE/MhE/BO
1f++JQqtrzxzr90IyBugB0AfJTSN0+Yt76hQO1Qui6kxhNF1Wj0eXmXlnjmHXzWN
y/kv+llBwRYGSH3HSMo+ow5MNu1fryTeO25wUk57MzLuu0C8HdXvbWCWpuTKdgly
QkYv+OgCPqL89Uv5S/kXJfAh3Ms3LQTukTRwjMBZLndOnAAZQ+0r4lBcVbkyU0Uf
zt/12JaYJTYuJ4bkYAW1LaGjfxMP5Eck1/yjnmqqLSosuyerchtyJSY2Ns7NPevt
D8ytvPQxghXR0gizVUtz/9TM40EcRovEQRi8txnIYWcw/exfZh8XbWfoAunU7o8W
SscLz9OtIPQErXzRuskTcurO1zpPftL+b8Db6nb5LEVu47a6LZC1SAyntMcHFsV0
kjSN07G2TLK/CmeK63yyIG6l6b8BivSkJgFIpIdwjZgPUp5gbpPQE8RADMjupj8N
b1iLbBuOSVhqyNIOKOO9pLh6P2g7lId97k4y1ZOZaFBSWej3Yc4=
=m+xW
-----END PGP SIGNATURE-----

--wlacmrpb6putzxkb--
