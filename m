Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 191F0139F50
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 03:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgANCGU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Jan 2020 21:06:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgANCGU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 13 Jan 2020 21:06:20 -0500
Received: from earth.universe (dyndsl-091-096-060-001.ewe-ip-backbone.de [91.96.60.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7B9C20CC7;
        Tue, 14 Jan 2020 02:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578967579;
        bh=pnmd3kVhVADGUeCWgWB89yULr9VY1wbUZLfCFPlV5Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z7p5dHhRi5wV6n9zEvLzD9aGRSzwmW2Aiqv4E0DsXo7GRwn9ekSYziHdQFsYCFN1y
         w6NrpqUo+CGHi0LLwl/+18oPjQT/LG/jIMIcvHghlInnWMH9oyk92PUYqztJCJQ5kS
         61SxaZe0OBCsmEtijwjjmvgXx+pAjhVOkFssHYkc=
Received: by earth.universe (Postfix, from userid 1000)
        id 015D33C0C7C; Tue, 14 Jan 2020 03:06:16 +0100 (CET)
Date:   Tue, 14 Jan 2020 03:06:16 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND 1/2] power: supply: add CW2015 Fuel Gauge driver
Message-ID: <20200114020616.3pg4yssrtuwxjd32@earth.universe>
References: <20200109113955.2882-1-t.schramm@manjaro.org>
 <20200109113955.2882-2-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="glbgt24tgkkdzbex"
Content-Disposition: inline
In-Reply-To: <20200109113955.2882-2-t.schramm@manjaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--glbgt24tgkkdzbex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I did not yet review this fully, too many changes are required. You
can find a dozen of comments below.

-- Sebastian

On Thu, Jan 09, 2020 at 12:39:54PM +0100, Tobias Schramm wrote:
> The CellWise CW2015 is a I2C interfaced shuntless Fuel Gauge for lithium-=
ion
> batteries.
> This patch adds support for the CellWise CW2015 Fuel Gauge.
>=20
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  drivers/power/supply/Kconfig          |   7 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/cw2015_battery.c | 962 ++++++++++++++++++++++++++
>  include/linux/power/cw2015_battery.h  | 122 ++++
>  4 files changed, 1092 insertions(+)
>  create mode 100644 drivers/power/supply/cw2015_battery.c
>  create mode 100644 include/linux/power/cw2015_battery.h
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 27164a1d3c7c..e3eb2dbaf44f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -116,6 +116,13 @@ config BATTERY_CPCAP
>  	  Say Y here to enable support for battery on Motorola
>  	  phones and tablets such as droid 4.
> =20
> +config BATTERY_CW2015
> +	tristate "CW2015 battery driver"
> +	depends on I2C
> +	help
> +	  Say Y here to enable support for the cellwise cw2015
> +	  battery fuel gauge (used in the Pinebook Pro & others)
> +
>  config BATTERY_DS2760
>  	tristate "DS2760 battery driver (HP iPAQ & others)"
>  	depends on W1
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 6c7da920ea83..69727a10e835 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -24,6 +24,7 @@ obj-$(CONFIG_BATTERY_ACT8945A)	+=3D act8945a_charger.o
>  obj-$(CONFIG_BATTERY_AXP20X)	+=3D axp20x_battery.o
>  obj-$(CONFIG_CHARGER_AXP20X)	+=3D axp20x_ac_power.o
>  obj-$(CONFIG_BATTERY_CPCAP)	+=3D cpcap-battery.o
> +obj-$(CONFIG_BATTERY_CW2015)	+=3D cw2015_battery.o
>  obj-$(CONFIG_BATTERY_DS2760)	+=3D ds2760_battery.o
>  obj-$(CONFIG_BATTERY_DS2780)	+=3D ds2780_battery.o
>  obj-$(CONFIG_BATTERY_DS2781)	+=3D ds2781_battery.o
> diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply=
/cw2015_battery.c
> new file mode 100644
> index 000000000000..4f1e75c50374
> --- /dev/null
> +++ b/drivers/power/supply/cw2015_battery.c
> @@ -0,0 +1,962 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Fuel gauge driver for CellWise 2013 / 2015
> + *
> + * Copyright (C) 2012, RockChip
> + * Copyright (C) 2019, Tobias Schramm
> + *
> + * Authors: xuhuicong <xhc@rock-chips.com>
> + * Authors: Tobias Schramm <tobias@t-sys.eu>
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/timekeeping.h>
> +#include <linux/workqueue.h>
> +
> +#include <linux/power/cw2015_battery.h>
> +
> +static int dbg_enable;
> +module_param_named(dbg_level, dbg_enable, int, 0644);
> +
> +#define cw_printk(args...) \
> +	do { \
> +		if (dbg_enable) { \
> +			pr_info(args); \
> +		} \
> +	} while (0)

Please use dev_dbg instead, which can be dynamically enabled
using dyndbg:

https://www.kernel.org/doc/html/v4.19/admin-guide/dynamic-debug-howto.html

> +#define PREFIX "cellwise,"
> +
> +static int cw_read(struct i2c_client *client, u8 reg, u8 buf[])
> +{
> +	return i2c_smbus_read_i2c_block_data(client, reg, 1, buf);
> +}
> +
> +static int cw_write(struct i2c_client *client, u8 reg, u8 const buf[])
> +{
> +	return i2c_smbus_write_i2c_block_data(client, reg, 1, &buf[0]);
> +}
> +
> +static int cw_read_word(struct i2c_client *client, u8 reg, u8 buf[])
> +{
> +	return i2c_smbus_read_i2c_block_data(client, reg, 2, buf);
> +}

Please use regmap instead.

> +int cw_update_config_info(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +	u8 reg_val;
> +	u8 i;
> +	u8 reset_val;
> +
> +	cw_printk("[FGADC] test config_info =3D 0x%x\n",
> +		  cw_bat->plat_data.cw_bat_config_info[0]);
> +
> +	/* make sure no in sleep mode */
> +	ret =3D cw_read(cw_bat->client, CW2015_REG_MODE, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	reset_val =3D reg_val;
> +	if ((reg_val & CW2015_MODE_SLEEP_MASK) =3D=3D CW2015_MODE_SLEEP) {
> +		dev_err(&cw_bat->client->dev,
> +			"device in sleep mode, cannot update battery info\n");
> +		return -1;
> +	}
> +
> +	/* update new battery info */
> +	for (i =3D 0; i < CW2015_SIZE_BATINFO; i++) {
> +		ret =3D
> +		    cw_write(cw_bat->client, CW2015_REG_BATINFO + i,
> +			     (u8 *)&cw_bat->plat_data.cw_bat_config_info[i]);
> +
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	reg_val |=3D CW2015_CONFIG_UPDATE_FLG;	/* set UPDATE_FLAG */
> +	reg_val &=3D ~CW2015_MASK_ATHD;	/* clear ATHD */
> +	reg_val |=3D CW2015_ATHD(cw_bat->alert_level);	/* set CW2015_ATHD */
> +	ret =3D cw_write(cw_bat->client, CW2015_REG_CONFIG, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* check 2015/cw2013 for CW2015_ATHD & update_flag */
> +	ret =3D cw_read(cw_bat->client, CW2015_REG_CONFIG, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(reg_val & CW2015_CONFIG_UPDATE_FLG)) {
> +		dev_info(&cw_bat->client->dev,
> +			 "update flag for new battery info have not set..\n");
> +	}
> +
> +	if ((reg_val & CW2015_MASK_ATHD) !=3D CW2015_ATHD(cw_bat->alert_level))
> +		dev_info(&cw_bat->client->dev, "the new CW2015_ATHD have not set..\n");
> +
> +	/* reset */
> +	reset_val &=3D ~(CW2015_MODE_RESTART);
> +	reg_val =3D reset_val | CW2015_MODE_RESTART;
> +	ret =3D cw_write(cw_bat->client, CW2015_REG_MODE, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	msleep(10);
> +	ret =3D cw_write(cw_bat->client, CW2015_REG_MODE, &reset_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	cw_printk("cw2015 update config success!\n");
> +
> +	return 0;
> +}
> +
> +static int cw_init(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +	int i;
> +	u8 reg_val =3D CW2015_MODE_SLEEP;
> +
> +	if ((reg_val & CW2015_MODE_SLEEP_MASK) =3D=3D CW2015_MODE_SLEEP) {
> +		reg_val =3D CW2015_MODE_NORMAL;
> +		ret =3D cw_write(cw_bat->client, CW2015_REG_MODE, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret =3D cw_read(cw_bat->client, CW2015_REG_CONFIG, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if ((reg_val & CW2015_MASK_ATHD) !=3D CW2015_ATHD(cw_bat->alert_level))=
 {
> +		dev_info(&cw_bat->client->dev, "the new CW2015_ATHD have not set\n");
> +		reg_val &=3D ~CW2015_MASK_ATHD;
> +		reg_val |=3D ~CW2015_ATHD(cw_bat->alert_level);
> +		ret =3D cw_write(cw_bat->client, CW2015_REG_CONFIG, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret =3D cw_read(cw_bat->client, CW2015_REG_CONFIG, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (!(reg_val & CW2015_CONFIG_UPDATE_FLG)) {
> +		cw_printk("update config flg is true, need update config\n");
> +		ret =3D cw_update_config_info(cw_bat);
> +		if (ret < 0) {
> +			dev_info(&cw_bat->client->dev,
> +				 "update flag for new battery info have not set\n");
> +			return ret;
> +		}
> +	} else {
> +		for (i =3D 0; i < CW2015_SIZE_BATINFO; i++) {
> +			ret =3D cw_read(cw_bat->client, (CW2015_REG_BATINFO + i),
> +				      &reg_val);
> +			if (ret < 0)
> +				return ret;
> +
> +			if (cw_bat->plat_data.cw_bat_config_info[i] !=3D reg_val)
> +				break;
> +		}
> +
> +		if (i !=3D CW2015_SIZE_BATINFO) {
> +			dev_info(&cw_bat->client->dev,
> +				 "update flag for new battery info have not set\n");
> +			ret =3D cw_update_config_info(cw_bat);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	}
> +
> +	for (i =3D 0; i < CW2015_READ_TRIES; i++) {
> +		ret =3D cw_read(cw_bat->client, CW2015_REG_SOC, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +		else if (reg_val <=3D 100) // SOC can't be more than 100 %
> +			break;
> +		msleep(120);
> +	}
> +
> +	if (i >=3D CW2015_READ_TRIES) {
> +		reg_val =3D CW2015_MODE_SLEEP;
> +		ret =3D cw_write(cw_bat->client, CW2015_REG_MODE, &reg_val);
> +		dev_info(&cw_bat->client->dev, "report battery capacity error");
> +		return -1;
> +	}
> +
> +	cw_printk("cw2015 init success!\n");
> +	return 0;
> +}
> +
> +static int check_charger_online(struct device *dev, void *data)
> +{
> +	struct device *cw_dev =3D data;
> +	struct power_supply *supply =3D dev_get_drvdata(dev);
> +	union power_supply_propval val;
> +
> +	if (supply->desc->type =3D=3D POWER_SUPPLY_TYPE_BATTERY) {
> +		dev_dbg(cw_dev, "Skipping power supply %s since it is a battery\n",
> +			dev_name(dev));
> +		return 0; // Bail out, not a charger
> +	}
> +	if (!supply->desc->get_property(supply, POWER_SUPPLY_PROP_ONLINE,
> +					&val)) {
> +		return val.intval;
> +	}
> +	dev_dbg(cw_dev, "Skipping power supply %s since it does not "
> +		"have an online property\n", dev_name(dev));
> +	return 0;
> +}
> +
> +#ifdef CONFIG_OF
> +static int device_parent_match_of_node(struct device *dev, const void *n=
p)
> +{
> +	while (dev) {
> +		if (dev->of_node =3D=3D np) {
> +			return 1;
> +		}
> +		dev =3D dev->parent;
> +	}
> +	return 0;
> +}
> +#endif
> +
> +static int get_charge_state(struct cw_battery *cw_bat)
> +{
> +	struct device *cw_dev =3D &cw_bat->client->dev;
> +#ifdef CONFIG_OF
> +	int i =3D 0, online =3D 0;
> +	struct device_node *supply_of;
> +
> +	if (!cw_dev->of_node) {
> +		dev_dbg(cw_dev, "Charger does not have an of node, scanning "
> +			"all supplies\n");
> +#endif
> +		return !!class_for_each_device(power_supply_class, NULL,
> +					       cw_dev, check_charger_online);
> +#ifdef CONFIG_OF
> +	}
> +	do {
> +		struct device *supply_dev;
> +
> +		dev_dbg(cw_dev, "Scanning linked supplies of %s\n",
> +			cw_dev->of_node->name);
> +		supply_of =3D of_parse_phandle(cw_dev->of_node, "power-supplies",
> +					     i++);
> +		if (!supply_of) {
> +			dev_dbg(cw_dev, "Got empty of node, scan done\n");
> +			break;
> +		}
> +		dev_dbg(cw_dev, "Got power supply %s\n", supply_of->name);
> +		supply_dev =3D class_find_device(power_supply_class, NULL,
> +					       supply_of,
> +					       device_parent_match_of_node);
> +		if (supply_dev) {
> +			online =3D check_charger_online(supply_dev, NULL);
> +			dev_dbg(supply_dev, "Charger online: %d\n", online);
> +			put_device(supply_dev);
> +		} else {
> +			dev_warn(cw_dev, "Failed to get device for device "
> +				 "node %s\n", supply_of->name);
> +		}
> +		of_node_put(supply_of);
> +	} while (!online);
> +	return online;
> +#endif
> +}

All of the above should not be needed when of_node is set properly.

> +static int cw_por(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +	unsigned char reset_val;
> +
> +	reset_val =3D CW2015_MODE_SLEEP;
> +	ret =3D cw_write(cw_bat->client, CW2015_REG_MODE, &reset_val);
> +	if (ret < 0)
> +		return ret;
> +	reset_val =3D CW2015_MODE_NORMAL;
> +	msleep(20);
> +	ret =3D cw_write(cw_bat->client, CW2015_REG_MODE, &reset_val);
> +	if (ret < 0)
> +		return ret;
> +	ret =3D cw_init(cw_bat);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static int cw_get_capacity(struct cw_battery *cw_bat)
> +{
> +	int cw_capacity;
> +	int ret;
> +	unsigned char reg_val[2];
> +
> +	static int reset_loop;
> +	static int charging_loop;
> +	static int discharging_loop;
> +	static int jump_flag;
> +	static int charging_5_loop;
> +	int sleep_cap;
> +
> +	ret =3D cw_read_word(cw_bat->client, CW2015_REG_SOC, reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	cw_capacity =3D reg_val[0];
> +
> +	if ((cw_capacity < 0) || (cw_capacity > 100)) {
> +		cw_printk("Error:  cw_capacity =3D %d\n", cw_capacity);
> +		reset_loop++;
> +		if (reset_loop >
> +		    (CW2015_BATTERY_CAPACITY_ERROR / cw_bat->monitor_sec)) {
> +			cw_por(cw_bat);
> +			reset_loop =3D 0;
> +		}
> +		return cw_bat->capacity;
> +	}
> +	reset_loop =3D 0;
> +
> +	/* case 1 : aviod swing */
> +	if (((cw_bat->charger_mode > 0) &&
> +	     (cw_capacity <=3D cw_bat->capacity - 1) &&
> +	     (cw_capacity > cw_bat->capacity - 9)) ||
> +	    ((cw_bat->charger_mode =3D=3D 0) &&
> +	     (cw_capacity =3D=3D (cw_bat->capacity + 1)))) {
> +		if (!(cw_capacity =3D=3D 0 && cw_bat->capacity <=3D 2))
> +			cw_capacity =3D cw_bat->capacity;
> +	}
> +
> +	/* case 2 : aviod no charge full */
> +	if ((cw_bat->charger_mode > 0) &&
> +	    (cw_capacity >=3D 95) && (cw_capacity <=3D cw_bat->capacity)) {
> +		cw_printk("Chaman join no charge full\n");
> +		charging_loop++;
> +		if (charging_loop >
> +		    (CW2015_BATTERY_UP_MAX_CHANGE / cw_bat->monitor_sec)) {
> +			cw_capacity =3D (cw_bat->capacity + 1) <=3D 100 ?
> +				      (cw_bat->capacity + 1) : 100;
> +			charging_loop =3D 0;
> +			jump_flag =3D 1;
> +		} else {
> +			cw_capacity =3D cw_bat->capacity;
> +		}
> +	}
> +
> +	/* case 3 : avoid battery level jump to CW_BAT */
> +	if ((cw_bat->charger_mode =3D=3D 0) &&
> +	    (cw_capacity <=3D cw_bat->capacity) &&
> +	    (cw_capacity >=3D 90) && (jump_flag =3D=3D 1)) {
> +		cw_printk("Chaman join no charge full discharging\n");
> +#ifdef CONFIG_PM
> +		if (cw_bat->suspend_resume_mark =3D=3D 1) {
> +			cw_bat->suspend_resume_mark =3D 0;
> +			sleep_cap =3D (cw_bat->after.tv_sec +
> +				     discharging_loop *
> +				     (cw_bat->monitor_sec / 1000)) /
> +				     (CW2015_BATTERY_DOWN_MAX_CHANGE / 1000);
> +			cw_printk("sleep_cap =3D %d\n", sleep_cap);
> +
> +			if (cw_capacity >=3D cw_bat->capacity - sleep_cap) {
> +				return cw_capacity;
> +			}
> +			if (!sleep_cap)
> +				discharging_loop =3D discharging_loop +
> +					1 + cw_bat->after.tv_sec /
> +					(cw_bat->monitor_sec / 1000);
> +			else
> +				discharging_loop =3D 0;
> +			cw_printk("discharging_loop =3D %d\n",
> +				  discharging_loop);
> +			return cw_bat->capacity - sleep_cap;
> +		}
> +#endif
> +		discharging_loop++;
> +		if (discharging_loop >
> +		    (CW2015_BATTERY_DOWN_MAX_CHANGE / cw_bat->monitor_sec)) {
> +			if (cw_capacity >=3D cw_bat->capacity - 1)
> +				jump_flag =3D 0;
> +			else
> +				cw_capacity =3D cw_bat->capacity - 1;
> +
> +			discharging_loop =3D 0;
> +		} else {
> +			cw_capacity =3D cw_bat->capacity;
> +		}
> +	}
> +
> +	/* case 4 : avoid battery level is 0% when long time charging */
> +	if ((cw_bat->charger_mode > 0) && (cw_capacity =3D=3D 0)) {
> +		charging_5_loop++;
> +		if (charging_5_loop >
> +		    CW2015_BATTERY_CHARGING_ZERO / cw_bat->monitor_sec) {
> +			cw_por(cw_bat);
> +			charging_5_loop =3D 0;
> +		}
> +	} else if (charging_5_loop !=3D 0) {
> +		charging_5_loop =3D 0;
> +	}
> +#ifdef CONFIG_PM
> +	if (cw_bat->suspend_resume_mark =3D=3D 1)
> +		cw_bat->suspend_resume_mark =3D 0;
> +#endif
> +	return cw_capacity;
> +}
> +
> +static int cw_get_voltage(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +	u8 reg_val[2];
> +	u16 value16, value16_1, value16_2, value16_3;
> +	int voltage;
> +	int res1, res2;
> +
> +	ret =3D cw_read_word(cw_bat->client, CW2015_REG_VCELL, reg_val);
> +	if (ret < 0)
> +		return ret;
> +	value16 =3D (reg_val[0] << 8) + reg_val[1];
> +
> +	ret =3D cw_read_word(cw_bat->client, CW2015_REG_VCELL, reg_val);
> +	if (ret < 0)
> +		return ret;
> +	value16_1 =3D (reg_val[0] << 8) + reg_val[1];
> +
> +	ret =3D cw_read_word(cw_bat->client, CW2015_REG_VCELL, reg_val);
> +	if (ret < 0)
> +		return ret;
> +	value16_2 =3D (reg_val[0] << 8) + reg_val[1];
> +
> +	if (value16 > value16_1) {
> +		value16_3 =3D value16;
> +		value16 =3D value16_1;
> +		value16_1 =3D value16_3;
> +	}
> +
> +	if (value16_1 > value16_2) {
> +		value16_3 =3D value16_1;
> +		value16_1 =3D value16_2;
> +		value16_2 =3D value16_3;
> +	}
> +
> +	if (value16 > value16_1) {
> +		value16_3 =3D value16;
> +		value16 =3D value16_1;
> +		value16_1 =3D value16_3;
> +	}

If you want to get the average, just add all numbers and divide by 3.
That's much easier to read and the numbers are int16 anyways, so
three of them easily fit into a normal 32 bit integer.

> +	voltage =3D value16_1 * 312 / 1024;
> +
> +	if (cw_bat->plat_data.divider_high &&
> +	    cw_bat->plat_data.divider_low) {
> +		res1 =3D cw_bat->plat_data.divider_high;
> +		res2 =3D cw_bat->plat_data.divider_low;
> +		voltage =3D voltage * (res1 + res2) / res2;
> +	}
> +
> +	dev_dbg(&cw_bat->client->dev, "the cw201x voltage=3D%d,reg_val=3D%x %x\=
n",
> +		voltage, reg_val[0], reg_val[1]);
> +	return voltage;
> +}
> +
> +/*This function called when get RRT from cw2015*/
> +static int cw_get_time_to_empty(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +	u8 reg_val;
> +	u16 value16;
> +
> +	ret =3D cw_read(cw_bat->client, CW2015_REG_RRT_ALERT, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	value16 =3D reg_val;
> +
> +	ret =3D cw_read(cw_bat->client, CW2015_REG_RRT_ALERT + 1, &reg_val);
> +	if (ret < 0)
> +		return ret;
> +
> +	value16 =3D ((value16 << 8) + reg_val) & CW2015_MASK_SOC;

why not just cw_read_word?

> +	return value16;
> +}
> +
> +static void cw_update_charge_status(struct cw_battery *cw_bat)
> +{
> +	int cw_charger_mode;
> +
> +	cw_charger_mode =3D get_charge_state(cw_bat);
> +	if (cw_bat->charger_mode !=3D cw_charger_mode) {
> +		cw_bat->charger_mode =3D cw_charger_mode;
> +		cw_bat->bat_change =3D 1;
> +		if (cw_charger_mode)
> +			cw_bat->charge_count++;
> +	}
> +}
> +
> +static void cw_update_capacity(struct cw_battery *cw_bat)
> +{
> +	int cw_capacity;
> +
> +	cw_capacity =3D cw_get_capacity(cw_bat);
> +	if ((cw_capacity >=3D 0) && (cw_capacity <=3D 100) &&
> +	    (cw_bat->capacity !=3D cw_capacity)) {
> +		cw_bat->capacity =3D cw_capacity;
> +		cw_bat->bat_change =3D 1;
> +	}
> +}
> +
> +static void cw_update_vol(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +
> +	ret =3D cw_get_voltage(cw_bat);
> +	if ((ret >=3D 0) && (cw_bat->voltage !=3D ret))
> +		cw_bat->voltage =3D ret;
> +}
> +
> +static void cw_update_status(struct cw_battery *cw_bat)
> +{
> +	int status;
> +
> +	if (cw_bat->charger_mode > 0) {
> +		if (cw_bat->capacity >=3D 100)
> +			status =3D POWER_SUPPLY_STATUS_FULL;
> +		else
> +			status =3D POWER_SUPPLY_STATUS_CHARGING;
> +	} else {
> +		status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	}
> +
> +	if (cw_bat->status !=3D status) {
> +		cw_bat->status =3D status;
> +		cw_bat->bat_change =3D 1;
> +	}
> +}
> +
> +static void cw_update_time_to_empty(struct cw_battery *cw_bat)
> +{
> +	int ret;
> +
> +	ret =3D cw_get_time_to_empty(cw_bat);
> +	if ((ret >=3D 0) && (cw_bat->time_to_empty !=3D ret)) {
> +		cw_bat->time_to_empty =3D ret;
> +		cw_bat->bat_change =3D 1;
> +	}
> +}
> +
> +static void cw_bat_work(struct work_struct *work)
> +{
> +	struct delayed_work *delay_work;
> +	struct cw_battery *cw_bat;
> +	int ret;
> +	u8 reg_val;
> +	int i =3D 0;
> +
> +	delay_work =3D container_of(work, struct delayed_work, work);
> +	cw_bat =3D
> +		container_of(delay_work, struct cw_battery, battery_delay_work);
> +
> +	/* Add for battery swap start */
> +	ret =3D cw_read(cw_bat->client, CW2015_REG_MODE, &reg_val);
> +	if (ret < 0) {
> +		cw_bat->bat_mode =3D MODE_VIRTUAL;
> +		cw_bat->bat_change =3D 1;
> +	} else {
> +		if ((reg_val & CW2015_MODE_SLEEP_MASK) =3D=3D CW2015_MODE_SLEEP) {
> +			for (i =3D 0; i < 5; i++) {
> +				if (cw_por(cw_bat) =3D=3D 0)
> +					break;
> +			}
> +		}
> +		cw_update_capacity(cw_bat);
> +		cw_update_vol(cw_bat);
> +		cw_update_charge_status(cw_bat);
> +		cw_update_status(cw_bat);
> +		cw_update_time_to_empty(cw_bat);
> +	}
> +	/* Add for battery swap end */
> +	cw_printk("charger_mod =3D %d\n", cw_bat->charger_mode);
> +	cw_printk("status =3D %d\n", cw_bat->status);
> +	cw_printk("capacity =3D %d\n", cw_bat->capacity);
> +	cw_printk("voltage =3D %d\n", cw_bat->voltage);

You can remove the above. Either the data is still the same,
or power_supply_changed is being called anyways.

> +
> +#ifdef CONFIG_PM
> +	if (cw_bat->suspend_resume_mark =3D=3D 1)
> +		cw_bat->suspend_resume_mark =3D 0;
> +#endif
> +
> +	if (cw_bat->bat_change =3D=3D 1) {
> +		power_supply_changed(cw_bat->rk_bat);
> +		cw_bat->bat_change =3D 0;
> +	}
> +	queue_delayed_work(cw_bat->battery_workqueue,
> +			   &cw_bat->battery_delay_work,
> +			   msecs_to_jiffies(cw_bat->monitor_sec));
> +}
> +
> +static bool cw_battery_valid_time_to_empty(struct cw_battery *cw_bat)
> +{
> +	return cw_bat->time_to_empty > 0 &&
> +		cw_bat->time_to_empty < CW2015_MASK_SOC &&
> +		cw_bat->status =3D=3D POWER_SUPPLY_STATUS_DISCHARGING;
> +}
> +
> +static int cw_battery_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	int ret =3D 0;
> +	struct cw_battery *cw_bat;
> +
> +	cw_bat =3D power_supply_get_drvdata(psy);
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		val->intval =3D cw_bat->capacity;
> +		if (cw_bat->bat_mode =3D=3D MODE_VIRTUAL)
> +			val->intval =3D CW2015_VIRTUAL_SOC;
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D cw_bat->status;
> +		if (cw_bat->bat_mode =3D=3D MODE_VIRTUAL)
> +			val->intval =3D CW2015_VIRTUAL_STATUS;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		val->intval =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;

No need to expose the health property, if its
fixed to GOOD anyways.

> +	case POWER_SUPPLY_PROP_PRESENT:
> +		val->intval =3D cw_bat->voltage <=3D 0 ? 0 : 1;
> +		if (cw_bat->bat_mode =3D=3D MODE_VIRTUAL)
> +			val->intval =3D CW2015_VIRTUAL_PRESET;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		val->intval =3D cw_bat->voltage * 1000;
> +		if (cw_bat->bat_mode =3D=3D MODE_VIRTUAL)
> +			val->intval =3D CW2015_VIRTUAL_VOLTAGE * 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW:
> +		if (cw_battery_valid_time_to_empty(cw_bat)) {
> +			val->intval =3D cw_bat->time_to_empty;
> +		} else {
> +			val->intval =3D 0;
> +		}
> +		if (cw_bat->bat_mode =3D=3D MODE_VIRTUAL)
> +			val->intval =3D CW2015_VIRTUAL_TIME2EMPTY;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_COUNTER:
> +		val->intval =3D cw_bat->charge_count;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		val->intval =3D cw_bat->plat_data.design_capacity * 1000;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_TEMP:
> +		val->intval =3D CW2015_VIRTUAL_TEMPERATURE;
> +		break;
> +
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		if (cw_battery_valid_time_to_empty(cw_bat)) {
> +			// calculate remaining capacity
> +			val->intval =3D cw_bat->plat_data.design_capacity * 1000;
> +			val->intval =3D val->intval * cw_bat->capacity / 100;
> +
> +			// estimate current based on time to empty (in minutes)
> +			val->intval =3D 60 * val->intval / cw_bat->time_to_empty;
> +		} else {
> +			val->intval =3D 0;
> +		}
> +
> +		if (cw_bat->bat_mode =3D=3D MODE_VIRTUAL)
> +			val->intval =3D CW2015_VIRTUAL_CURRENT;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +	return ret;
> +}
> +
> +static enum power_supply_property cw_battery_properties[] =3D {
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_COUNTER,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static const struct power_supply_desc cw2015_bat_desc =3D {
> +	.name		=3D "cw2015-battery",
> +	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties	=3D cw_battery_properties,
> +	.num_properties	=3D ARRAY_SIZE(cw_battery_properties),
> +	.get_property	=3D cw_battery_get_property,
> +};
> +
> +#ifdef CONFIG_OF
> +static int cw2015_parse_dt(struct cw_battery *cw_bat)
> +{
> +	struct device *dev =3D &cw_bat->client->dev;
> +	struct device_node *node =3D dev->of_node;
> +	struct property *prop;
> +	int length;
> +	u32 value;
> +	int ret;
> +	struct cw_bat_platform_data *data =3D &cw_bat->plat_data;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	memset(data, 0, sizeof(*data));
> +
> +	/* determine the number of config info */
> +	prop =3D of_find_property(node, PREFIX"bat-config-info", &length);
> +	if (!prop)
> +		return -EINVAL;
> +
> +	length /=3D sizeof(u32);
> +
> +	if (length > 0) {
> +		size_t size =3D sizeof(*data->cw_bat_config_info) * length;
> +
> +		data->cw_bat_config_info =3D devm_kzalloc(dev, size, GFP_KERNEL);
> +		if (!data->cw_bat_config_info)
> +			return -ENOMEM;
> +
> +		ret =3D of_property_read_u32_array(node, PREFIX"bat-config-info",
> +						 data->cw_bat_config_info,
> +						 length);
> +		if (ret < 0)
> +			return ret;
> +	}

In its current state it does not look like data for DT. What
information is stored in this "config info"?

> +	cw_bat->bat_mode =3D MODE_BATTERY;
> +	cw_bat->monitor_sec =3D CW2015_DEFAULT_MONITOR_SEC *
> +			      CW2015_TIMER_MS_COUNTS;
> +
> +	prop =3D of_find_property(node, PREFIX"voltage-divider", &length);
> +	if (prop) {
> +		length /=3D sizeof(u32);
> +		if (length !=3D 2) {
> +			dev_err(dev, "Length of voltage divider array must be "
> +				"2, not %u\n", length);
> +			return -EINVAL;
> +		}
> +		ret =3D of_property_read_u32_index(node, PREFIX"voltage-divider",
> +						 0, &data->divider_high);
> +		if (ret) {
> +			dev_err(dev, "Failed to read value of high side "
> +				"voltage divider resistor: %d\n", ret);
> +			return ret;
> +		}
> +		ret =3D of_property_read_u32_index(node, PREFIX"voltage-divider",
> +						 1, &data->divider_low);
> +		if (ret) {
> +			dev_err(dev, "Failed to read value of low side "
> +				"voltage divider resistor: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret =3D of_property_read_u32(node, PREFIX"divider-res2", &value);
> +	if (ret < 0)
> +		value =3D 0;
> +	data->divider_low =3D value;
> +
> +	ret =3D of_property_read_u32(node, PREFIX"virtual-power", &value);
> +	if (ret < 0)
> +		value =3D 0;
> +	cw_bat->bat_mode =3D value;

of_property_read_bool

> +	ret =3D of_property_read_u32(node, PREFIX"monitor-interval", &value);
> +	if (ret < 0)
> +		dev_err(dev, "monitor-interval missing!\n");
> +	else
> +		cw_bat->monitor_sec =3D value * CW2015_TIMER_MS_COUNTS;
> +
> +	ret =3D of_property_read_u32(node, PREFIX"design-capacity", &value);
> +	if (ret < 0) {
> +		dev_err(dev, "design-capacity missing!\n");
> +		data->design_capacity =3D 2000;
> +	} else {
> +		data->design_capacity =3D value;
> +	}
> +
> +	of_property_read_u8(node, PREFIX"alert-level", &cw_bat->alert_level);
> +	if (cw_bat->alert_level > 100) {
> +		dev_err(dev, "invalid alert_level, clamping to 100 %%\n");
> +		cw_bat->alert_level =3D 100;
> +	}

This does not belong into DT.

> +
> +	return 0;
> +}
> +#else
> +static int cw2015_parse_dt(struct cw_battery *cw_bat)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
> +static int cw_bat_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct cw_battery *cw_bat;
> +	struct power_supply_config psy_cfg =3D {0};
> +
> +	cw_bat =3D devm_kzalloc(&client->dev, sizeof(*cw_bat), GFP_KERNEL);
> +	if (!cw_bat) {
> +		return -ENOMEM;
> +	}
> +
> +	i2c_set_clientdata(client, cw_bat);
> +	cw_bat->client =3D client;
> +
> +	ret =3D cw2015_parse_dt(cw_bat);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"failed to find cw2015 platform data\n");
> +		return ret;
> +	}
> +
> +	cw_bat->capacity =3D 1;
> +	cw_bat->voltage =3D 0;
> +	cw_bat->status =3D 0;
> +	cw_bat->suspend_resume_mark =3D 0;
> +	cw_bat->charger_mode =3D CW2015_NO_CHARGING;
> +	cw_bat->bat_change =3D 0;
> +
> +	ret =3D cw_init(cw_bat);
> +	if (ret) {
> +		pr_err("%s cw_init error\n", __func__);

dev_err()

> +		return ret;
> +	}
> +
> +	psy_cfg.drv_data =3D cw_bat;

psy_cfg.of_node =3D dev->of_node;

> +	cw_bat->rk_bat =3D devm_power_supply_register(&client->dev,
> +		&cw2015_bat_desc, &psy_cfg);
> +	if (IS_ERR(cw_bat->rk_bat)) {
> +		dev_err(&cw_bat->client->dev,
> +			"power supply register rk_bat error\n");
> +		return -1;
> +	}
> +
> +	cw_bat->battery_workqueue =3D create_singlethread_workqueue("rk_battery=
");
> +	INIT_DELAYED_WORK(&cw_bat->battery_delay_work, cw_bat_work);
> +	queue_delayed_work(cw_bat->battery_workqueue,
> +			   &cw_bat->battery_delay_work, msecs_to_jiffies(10));
> +
> +	dev_info(&cw_bat->client->dev,
> +		 "cw2015/cw2013 driver probe success\n");

drop the above or reduce to dev_dbg().

> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int cw_bat_suspend(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct cw_battery *cw_bat =3D i2c_get_clientdata(client);
> +
> +	ktime_get_boottime_ts64(&cw_bat->suspend_time_before);
> +	cancel_delayed_work(&cw_bat->battery_delay_work);
> +	return 0;
> +}
> +
> +static int cw_bat_resume(struct device *dev)
> +{
> +	struct i2c_client *client =3D to_i2c_client(dev);
> +	struct cw_battery *cw_bat =3D i2c_get_clientdata(client);
> +
> +	cw_bat->suspend_resume_mark =3D 1;
> +	ktime_get_boottime_ts64(&cw_bat->after);
> +	cw_bat->after =3D timespec64_sub(cw_bat->after,
> +				     cw_bat->suspend_time_before);
> +	queue_delayed_work(cw_bat->battery_workqueue,
> +			   &cw_bat->battery_delay_work, msecs_to_jiffies(2));
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops cw_bat_pm_ops =3D {
> +	.suspend  =3D cw_bat_suspend,
> +	.resume   =3D cw_bat_resume,
> +};
> +#endif
> +
> +static int cw_bat_remove(struct i2c_client *client)
> +{
> +	struct cw_battery *cw_bat =3D i2c_get_clientdata(client);
> +
> +	dev_dbg(&cw_bat->client->dev, "%s\n", __func__);
> +	cancel_delayed_work(&cw_bat->battery_delay_work);

cancel_delayed_work_sync()

> +	return 0;
> +}
> +
> +static const struct i2c_device_id cw_bat_id_table[] =3D {
> +	{ "cw201x", 0 },
> +	{ "cw2013", 0 },
> +	{ "cw2015", 0 },
> +	{}
> +};
> +
> +static const struct of_device_id cw2015_of_match[] =3D {
> +	{ .compatible =3D PREFIX"cw201x" },

The above can be dropped?

> +	{ .compatible =3D PREFIX"cw2013" },
> +	{ .compatible =3D PREFIX"cw2015" },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, cw2015_of_match);
> +
> +static struct i2c_driver cw_bat_driver =3D {
> +	.driver =3D {
> +		.name =3D PREFIX"cw201x",

The driver name is usually not prefixed. Any reason for this?

> +#ifdef CONFIG_PM
> +		.pm =3D &cw_bat_pm_ops,
> +#endif
> +	},
> +	.probe =3D cw_bat_probe,
> +	.remove =3D cw_bat_remove,
> +	.id_table =3D cw_bat_id_table,
> +};
> +
> +static int __init cw_bat_init(void)
> +{
> +	return i2c_add_driver(&cw_bat_driver);
> +}
> +
> +static void __exit cw_bat_exit(void)
> +{
> +	i2c_del_driver(&cw_bat_driver);
> +}
> +
> +module_init(cw_bat_init);
> +module_exit(cw_bat_exit);

module_i2c_driver()

> +
> +MODULE_AUTHOR("xhc <xhc@rock-chips.com>");
> +MODULE_AUTHOR("Tobias Schramm <t.schramm@manjaro.org>");
> +MODULE_DESCRIPTION("cw2015/cw2013 battery driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/power/cw2015_battery.h b/include/linux/power/c=
w2015_battery.h
> new file mode 100644
> index 000000000000..77c8ce17799f
> --- /dev/null
> +++ b/include/linux/power/cw2015_battery.h
> @@ -0,0 +1,122 @@
> +/*
> + * Fuel gauge driver for CellWise 2013 / 2015
> + *
> + * Copyright (C) 2012, RockChip
> + * Copyright (C) 2019, Tobias Schramm
> + *
> + * Authors: xuhuicong <xhc@rock-chips.com>
> + * Authors: Tobias Schramm <tobias@t-sys.eu>
> + *
> + * Based on rk30_adc_battery.c
> +
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +
> +#ifndef CW2015_BATTERY_H
> +#define CW2015_BATTERY_H
> +
> +#define CW2015_SIZE_BATINFO    64
> +
> +#define CW2015_GPIO_HIGH  1
> +#define CW2015_GPIO_LOW   0

both are unused -> drop

> +
> +#define CW2015_READ_TRIES 30
> +
> +#define CW2015_REG_VERSION             0x0
> +#define CW2015_REG_VCELL               0x2
> +#define CW2015_REG_SOC                 0x4
> +#define CW2015_REG_RRT_ALERT           0x6
> +#define CW2015_REG_CONFIG              0x8
> +#define CW2015_REG_MODE                0xA
> +#define CW2015_REG_BATINFO             0x10
> +
> +#define CW2015_MODE_SLEEP_MASK         (0x3<<6)
> +#define CW2015_MODE_SLEEP              (0x3<<6)
> +#define CW2015_MODE_NORMAL             (0x0<<6)
> +#define CW2015_MODE_QUICK_START        (0x3<<4)
> +#define CW2015_MODE_RESTART            (0xf<<0)
> +
> +#define CW2015_CONFIG_UPDATE_FLG       (0x01<<1)
> +#define CW2015_ATHD(x)                 ((x)<<3)
> +#define CW2015_MASK_ATHD               (0x1f<<3)
> +#define CW2015_MASK_SOC                (0x1fff)
> +
> +#define CW2015_I2C_SPEED			100000
> +#define CW2015_BATTERY_UP_MAX_CHANGE		(420 * 1000)
> +#define CW2015_BATTERY_DOWN_MAX_CHANGE		(120 * 1000)
> +#define CW2015_BATTERY_DOWN_CHANGE		60
> +#define CW2015_BATTERY_DOWN_MIN_CHANGE_RUN	30
> +#define CW2015_BATTERY_DOWN_MIN_CHANGE_SLEEP	1800
> +#define CW2015_BATTERY_JUMP_TO_ZERO		(30 * 1000)
> +#define CW2015_BATTERY_CAPACITY_ERROR		(40 * 1000)
> +#define CW2015_BATTERY_CHARGING_ZERO		(1800 * 1000)
> +
> +#define CW2015_DOUBLE_SERIES_BATTERY	0
> +
> +#define CW2015_CHARGING_ON		1
> +#define CW2015_NO_CHARGING		0
> +
> +#define CW2015_BATTERY_DOWN_MAX_CHANGE_RUN_AC_ONLINE 3600
> +
> +#define CW2015_NO_STANDARD_AC_BIG_CHARGE_MODE 1
> +/* #define CW2015_SYSTEM_SHUTDOWN_VOLTAGE  3400000 */
> +#define CW2015_BAT_LOW_INTERRUPT    1
> +
> +#define CW2015_USB_CHARGER_MODE        1
> +#define CW2015_AC_CHARGER_MODE         2
> +#define   CW2015_QUICKSTART         0
> +
> +#define CW2015_TIMER_MS_COUNTS			1000
> +#define CW2015_DEFAULT_MONITOR_SEC		8
> +
> +/* virtual params */
> +#define CW2015_VIRTUAL_CURRENT			1000
> +#define CW2015_VIRTUAL_VOLTAGE			3888
> +#define CW2015_VIRTUAL_SOC			66
> +#define CW2015_VIRTUAL_PRESET			1
> +#define CW2015_VIRTUAL_TEMPERATURE		188
> +#define CW2015_VIRTUAL_TIME2EMPTY		60
> +#define CW2015_VIRTUAL_STATUS			POWER_SUPPLY_STATUS_CHARGING
> +
> +enum bat_mode {
> +	MODE_BATTERY =3D 0,
> +	MODE_VIRTUAL,
> +};

Please remove the complete MODE_VIRTUAL thing. It does not belong
into this driver. If you need a virtual battery, then you can
use CONFIG_TEST_POWER.

> +struct cw_bat_platform_data {
> +	u32 divider_high;
> +	u32 divider_low;
> +	u32 *cw_bat_config_info;
> +	int design_capacity;
> +};

Drop cw_bat_platform_data. It can be introduced if there is a user.
Right now the code would fail without DT data anyways. Afterwards
all content from the header should become part of the C code.

> +
> +struct cw_battery {
> +	struct i2c_client *client;
> +	struct workqueue_struct *battery_workqueue;
> +	struct delayed_work battery_delay_work;
> +	struct cw_bat_platform_data plat_data;

You can read the DT values directly into cw_battery struct
instead of using an additional one. This will keep the variable
names a bit shorter.

> +
> +	struct power_supply *rk_bat;
> +
> +#ifdef CONFIG_PM
> +	struct timespec64 suspend_time_before;
> +	struct timespec64 after;
> +	int suspend_resume_mark;
> +#endif
> +	int charger_mode;
> +	int capacity;
> +	int voltage;
> +	int status;
> +	int time_to_empty;
> +	int alt;
> +	u32 monitor_sec;
> +	u32 bat_mode;
> +	int bat_change;
> +	int charge_count;
> +	u8 alert_level;
> +};
> +
> +#endif
> --=20
> 2.24.1
>=20

--glbgt24tgkkdzbex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4dIhQACgkQ2O7X88g7
+poxXA//aAIC/tHO7NVg6OaI5egeDMjWUHXU/ZVfE1OOnCDt/o8Bl5Us938koGi9
MwOMCr54qegKCknnSndVVIe5SWAYNIA4e9Vx5NGFvbYl8scjKj+HWhjWHEQGNL35
54CuzUlFBLhZ+gTjlqFhsgmxjzC6Ps9b250kr8TTj0aplDoc6xeIsne8tCcuRKAK
K6a6WqYdf21nd61zH1wkZmDB7WBV0fGSY/aZgGEpsKclvHs9bzVZgo6NZUZ82x9w
4/RGIQhuCNIFO57wVUIg09PrKpyRzZh6a8XF0rGPURWLp1pnZ3IldpAAeu43FSgk
2pHPqI5y67iHJFPDO8BLpY6y07XmyOofpe+hJO1tYZuPsFqf6L2wHlsm7PxiYSGO
SkFKqu//cwJu74Af8RkNA6JxN5+H7RK4XWdgbJtSTAX//Cl7gLjahPGKQlfU2e3P
V6M/PscaKfbLwCLVGNzr6LB1Td/JdCZkfjfPq3umkCMH+UwOHsOY/j1+WwiSEhTF
aCP9pNT2rr66aN51y4Xm05XTuuxlnyQxHxlzfuXKT81AgiQ6hixwIgyEVBV366Xd
EPwPkuVX3HmAhev9hYDrFmoE7DEcjGbIBA/iQscjKXCRtTZ+m3gfH0eXQ3wbGhXY
9m3TqWQJaDLllotxZtKRgvQlS6qQnjcLu97j+0qEpxqr5m/EeNo=
=i4uz
-----END PGP SIGNATURE-----

--glbgt24tgkkdzbex--
