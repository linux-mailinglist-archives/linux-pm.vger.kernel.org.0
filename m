Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADD51C294C
	for <lists+linux-pm@lfdr.de>; Sun,  3 May 2020 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgECBQw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 2 May 2020 21:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726571AbgECBQw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 May 2020 21:16:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5BC061A0C;
        Sat,  2 May 2020 18:16:51 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 2D767270E41
Received: by earth.universe (Postfix, from userid 1000)
        id C13383C08C7; Sun,  3 May 2020 03:16:47 +0200 (CEST)
Date:   Sun, 3 May 2020 03:16:47 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Ricardo Rivera-Matos <r-rivera-matos@ti.com>
Subject: Re: [PATCH v5 3/3] power: supply: bq25150 introduce the bq25150
Message-ID: <20200503011647.p6iqhdigvzqryqn4@earth.universe>
References: <20200501175118.26226-1-dmurphy@ti.com>
 <20200501175118.26226-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twslmmpn4aonubnb"
Content-Disposition: inline
In-Reply-To: <20200501175118.26226-4-dmurphy@ti.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--twslmmpn4aonubnb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 01, 2020 at 12:51:18PM -0500, Dan Murphy wrote:
> From: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
>=20
> Introduce the bq2515x family of chargers.
>=20
> Description:
> The BQ2515X family of devices are highly integrated battery management
> ICs that integrate the most common functions for wearbale devices
> namely a charger, an output voltage rail, ADC for battery and system
> monitoring, and a push-button controller.
>=20
> Datasheets:
> 	bq25150 - http://www.ti.com/lit/ds/symlink/bq25150.pdf
> 	bq25155 - http://www.ti.com/lit/ds/symlink/bq25155.pdf
>=20
> Signed-off-by: Ricardo Rivera-Matos <r-rivera-matos@ti.com>
> ---
>  drivers/power/supply/Kconfig           |    8 +
>  drivers/power/supply/Makefile          |    1 +
>  drivers/power/supply/bq2515x_charger.c | 1170 ++++++++++++++++++++++++
>  3 files changed, 1179 insertions(+)
>  create mode 100644 drivers/power/supply/bq2515x_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index f3424fdce341..7732c5586fc2 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -589,6 +589,14 @@ config CHARGER_BQ24735
>  	help
>  	  Say Y to enable support for the TI BQ24735 battery charger.
> =20
> +config CHARGER_BQ2515X
> +	tristate "TI BQ2515X battery charger family"
> +	depends on I2C
> +	depends on GPIOLIB || COMPILE_TEST
> +	select REGMAP_I2C
> +	help
> +	  Say Y to enable support for the TI BQ2515X battery charger.
> +
>  config CHARGER_BQ25890
>  	tristate "TI BQ25890 battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 6c7da920ea83..8fcc175a7e22 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_CHARGER_BQ2415X)	+=3D bq2415x_charger.o
>  obj-$(CONFIG_CHARGER_BQ24190)	+=3D bq24190_charger.o
>  obj-$(CONFIG_CHARGER_BQ24257)	+=3D bq24257_charger.o
>  obj-$(CONFIG_CHARGER_BQ24735)	+=3D bq24735-charger.o
> +obj-$(CONFIG_CHARGER_BQ2515X)	+=3D bq2515x_charger.o
>  obj-$(CONFIG_CHARGER_BQ25890)	+=3D bq25890_charger.o
>  obj-$(CONFIG_CHARGER_SMB347)	+=3D smb347-charger.o
>  obj-$(CONFIG_CHARGER_TPS65090)	+=3D tps65090-charger.o
> diff --git a/drivers/power/supply/bq2515x_charger.c b/drivers/power/suppl=
y/bq2515x_charger.c
> new file mode 100644
> index 000000000000..c10789235982
> --- /dev/null
> +++ b/drivers/power/supply/bq2515x_charger.c
> @@ -0,0 +1,1170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// BQ2515X Battery Charger Driver
> +// Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com/
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +
> +#define BQ2515X_MANUFACTURER "Texas Instruments"
> +
> +#define BQ2515X_STAT0		0x00
> +#define BQ2515X_STAT1		0x01
> +#define BQ2515X_STAT2		0x02
> +#define BQ2515X_FLAG0		0x03
> +#define BQ2515X_FLAG1		0x04
> +#define BQ2515X_FLAG2		0x05
> +#define BQ2515X_FLAG3		0x06
> +#define BQ2515X_MASK0		0x07
> +#define BQ2515X_MASK1		0x08
> +#define BQ2515X_MASK2		0x09
> +#define BQ2515X_MASK3		0x0a
> +#define BQ2515X_VBAT_CTRL	0x12
> +#define BQ2515X_ICHG_CTRL	0x13
> +#define BQ2515X_PCHRGCTRL	0x14
> +#define BQ2515X_TERMCTRL	0x15
> +#define BQ2515X_BUVLO		0x16
> +#define BQ2515X_CHARGERCTRL0	0x17
> +#define BQ2515X_CHARGERCTRL1	0x18
> +#define BQ2515X_ILIMCTRL	0x19
> +#define BQ2515X_LDOCTRL		0x1d
> +#define BQ2515X_MRCTRL		0x30
> +#define BQ2515X_ICCTRL0		0x35
> +#define BQ2515X_ICCTRL1		0x36
> +#define BQ2515X_ICCTRL2		0x37
> +#define BQ2515X_ADCCTRL0	0x40
> +#define BQ2515X_ADCCTRL1	0x41
> +#define BQ2515X_ADC_VBAT_M	0x42
> +#define BQ2515X_ADC_VBAT_L	0x43
> +#define BQ2515X_ADC_TS_M	0x44
> +#define BQ2515X_ADC_TS_L	0x45
> +#define BQ2515X_ADC_ICHG_M	0x46
> +#define BQ2515X_ADC_ICHG_L	0x47
> +#define BQ2515X_ADC_ADCIN_M	0x48
> +#define BQ2515X_ADC_ADCIN_L	0x49
> +#define BQ2515X_ADC_VIN_M	0x4a
> +#define BQ2515X_ADC_VIN_L	0x4b
> +#define BQ2515X_ADC_PMID_M	0x4c
> +#define BQ2515X_ADC_PMID_L	0x4d
> +#define BQ2515X_ADC_IIN_M	0x4e
> +#define BQ2515X_ADC_IIN_L	0x4f
> +#define BQ2515X_ADC_COMP1_M	0x52
> +#define BQ2515X_ADC_COMP1_L	0X53
> +#define BQ2515X_ADC_COMP2_M	0X54
> +#define BQ2515X_ADC_COMP2_L	0x55
> +#define BQ2515X_ADC_COMP3_M	0x56
> +#define BQ2515X_ADC_COMP3_L	0x57
> +#define BQ2515X_ADC_READ_EN	0x58
> +#define BQ2515X_TS_FASTCHGCTRL	0x61
> +#define BQ2515X_TS_COLD		0x62
> +#define BQ2515X_TS_COOL		0x63
> +#define BQ2515X_TS_WARM		0x64
> +#define BQ2515X_TS_HOT		0x65
> +#define BQ2515X_DEVICE_ID	0x6f
> +
> +#define BQ2515X_DEFAULT_ICHG_UA		10000
> +#define BQ25150_DEFAULT_ILIM_UA		100000
> +#define BQ25155_DEFAULT_ILIM_UA		500000
> +#define BQ2515X_DEFAULT_VBAT_REG_UV	4200000
> +#define BQ2515X_DEFAULT_IPRECHARGE_UA	2500
> +
> +#define BQ2515X_DIVISOR				65536
> +#define BQ2515X_VBAT_BASE_VOLT			3600000
> +#define BQ2515X_VBAT_REG_MAX			4600000
> +#define BQ2515X_VBAT_REG_MIN			3600000
> +#define BQ2515X_VBAT_STEP_UV			10000
> +#define BQ2515X_UV_FACTOR			1000000
> +#define BQ2515X_ICHG_DIVISOR			52429
> +#define BQ2515X_ICHG_CURR_STEP_THRESH_UA	318750
> +#define BQ2515X_ICHG_MIN_UA			0
> +#define BQ2515X_ICHG_MAX_UA			500000
> +#define BQ2515X_ICHG_RNG_1B0_UA			1250
> +#define BQ2515X_ICHG_RNG_1B1_UA			2500
> +#define BQ2515X_VLOWV_SEL_1B0_UV		3000000
> +#define BQ2515X_VLOWV_SEL_1B1_UV		2800000
> +#define BQ2515X_PRECHRG_ICHRG_RNGE_1875_UA	18750
> +#define BQ2515X_PRECHRG_ICHRG_RNGE_3750_UA	37500
> +#define BQ2515X_TWAKE2_MIN_US			1700000
> +#define BQ2515X_TWAKE2_MAX_US			2300000
> +
> +#define BQ2515X_ILIM_150MA	0x2
> +#define BQ2515X_ILIM_MASK	0x7
> +#define BQ2515X_HEALTH_MASK	0xf
> +#define BQ2515X_ICHGRNG_MASK	0x80
> +#define BQ2515X_STAT0_MASK	0x0f
> +#define BQ2515X_STAT1_MASK	0x1f
> +#define BQ2515X_PRECHARGE_MASK	0x1f
> +
> +#define BQ2515X_TS_HOT_STAT		BIT(0)
> +#define BQ2515X_TS_WARM_STAT		BIT(1)
> +#define BQ2515X_TS_COOL_STAT		BIT(2)
> +#define BQ2515X_TS_COLD_STAT		BIT(3)
> +#define BQ2515X_SAFETY_TIMER_EXP	BIT(5)
> +
> +#define BQ2515X_VIN_GOOD		BIT(0)
> +#define BQ2515X_CHRG_DONE		BIT(5)
> +#define BQ2515X_CV_CHRG_MODE		BIT(6)
> +
> +#define BQ2515X_VIN_OVP_FAULT_STAT	BIT(7)
> +
> +#define BQ2515X_WATCHDOG_DISABLE	BIT(4)
> +
> +#define BQ2515X_ICHARGE_RANGE		BIT(7)
> +
> +#define BQ2515X_VLOWV_SEL		BIT(5)
> +
> +#define BQ2515X_CHARGER_DISABLE		BIT(0)
> +
> +#define BQ2515X_HWRESET_14S_WD		BIT(1)
> +
> +static const int bq2515x_ilim_lvl_values[] =3D {
> +	50000, 100000, 150000, 200000, 300000, 400000, 500000, 600000
> +};
> +
> +/**
> + * struct bq2515x_init_data -
> + * @icgh: fast charge current
> + * @vreg: charge voltage
> + * @ilim: input current limit
> + * @iprecharge: precharge current
> + */
> +struct bq2515x_init_data {
> +	int ichg;
> +	int vreg;
> +	int ilim;
> +	int iprecharge;
> +};
> +
> +enum bq2515x_id {
> +	BQ25150,
> +	BQ25155,
> +};
> +
> +/**
> + * struct bq2515x_device -
> + * @mains: mains properties
> + * @battery: battery properties
> + * @client: i2c client structure
> + * @regmap: register map structure
> + * @dev: device structure
> + * @lock: thread lock structure

lock is unused and leaks (i.e. it is initialized,
but not free'd in all error cases, also not free'd
in device removal). Just remove it.

> + * @id: enumeration of device ids
> + *
> + * @reset_gpio: manual reset (MR) pin
> + * @lp_gpio: low power mode pin
> + * @ac_detect_gpio: power good (PG) pin
> + * @ce_gpio: charge enable (CE) pin
> + *
> + * @model_name: string value describing device model
> + * @device_id: value of device_id
> + * @mains_online: boolean value indicating power supply online
> + *
> + * @bq2515x_init_data init_data: charger initialization data structure
> + */
> +struct bq2515x_device {
> +	struct power_supply *mains;
> +	struct power_supply *battery;
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +	enum bq2515x_id id;
> +
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *lp_gpio;
> +	struct gpio_desc *ac_detect_gpio;
> +	struct gpio_desc *ce_gpio;
> +
> +	char model_name[I2C_NAME_SIZE];
> +	int device_id;
> +	bool mains_online;
> +
> +	struct bq2515x_init_data init_data;
> +};
> +
> +static struct reg_default bq25150_reg_defs[] =3D {
> +	{BQ2515X_FLAG0, 0x0},
> +	{BQ2515X_FLAG1, 0x0},
> +	{BQ2515X_FLAG2, 0x0},
> +	{BQ2515X_FLAG3, 0x0},
> +	{BQ2515X_MASK0, 0x0},
> +	{BQ2515X_MASK1, 0x0},
> +	{BQ2515X_MASK2, 0x71},
> +	{BQ2515X_MASK3, 0x0},
> +	{BQ2515X_VBAT_CTRL, 0x3C},
> +	{BQ2515X_ICHG_CTRL, 0x8},
> +	{BQ2515X_PCHRGCTRL, 0x2},
> +	{BQ2515X_TERMCTRL, 0x14},
> +	{BQ2515X_BUVLO, 0x0},
> +	{BQ2515X_CHARGERCTRL0, 0x82},
> +	{BQ2515X_CHARGERCTRL1, 0x42},
> +	{BQ2515X_ILIMCTRL, 0x1},
> +	{BQ2515X_LDOCTRL, 0xB0},
> +	{BQ2515X_MRCTRL, 0x2A},
> +	{BQ2515X_ICCTRL0, 0x10},
> +	{BQ2515X_ICCTRL1, 0x0},
> +	{BQ2515X_ICCTRL2, 0x0},
> +	{BQ2515X_ADCCTRL0, 0x2},
> +	{BQ2515X_ADCCTRL1, 0x40},
> +	{BQ2515X_ADC_COMP1_M, 0x23},
> +	{BQ2515X_ADC_COMP1_L, 0x20},
> +	{BQ2515X_ADC_COMP2_M, 0x38},
> +	{BQ2515X_ADC_COMP2_L, 0x90},
> +	{BQ2515X_ADC_COMP3_M, 0x0},
> +	{BQ2515X_ADC_COMP3_L, 0x0},
> +	{BQ2515X_ADC_READ_EN, 0x0},
> +	{BQ2515X_TS_FASTCHGCTRL, 0x34},
> +	{BQ2515X_TS_COLD, 0x7C},
> +	{BQ2515X_TS_COOL, 0x6D},
> +	{BQ2515X_TS_WARM, 0x38},
> +	{BQ2515X_TS_HOT, 0x27},
> +	{BQ2515X_DEVICE_ID, 0x20},
> +};
> +
> +static struct reg_default bq25155_reg_defs[] =3D {
> +	{BQ2515X_FLAG0, 0x0},
> +	{BQ2515X_FLAG1, 0x0},
> +	{BQ2515X_FLAG2, 0x0},
> +	{BQ2515X_FLAG3, 0x0},
> +	{BQ2515X_MASK0, 0x0},
> +	{BQ2515X_MASK1, 0x0},
> +	{BQ2515X_MASK2, 0x71},
> +	{BQ2515X_MASK3, 0x0},
> +	{BQ2515X_VBAT_CTRL, 0x3C},
> +	{BQ2515X_ICHG_CTRL, 0x8},
> +	{BQ2515X_PCHRGCTRL, 0x2},
> +	{BQ2515X_TERMCTRL, 0x14},
> +	{BQ2515X_BUVLO, 0x0},
> +	{BQ2515X_CHARGERCTRL0, 0x82},
> +	{BQ2515X_CHARGERCTRL1, 0xC2},
> +	{BQ2515X_ILIMCTRL, 0x6},
> +	{BQ2515X_LDOCTRL, 0xB0},
> +	{BQ2515X_MRCTRL, 0x2A},
> +	{BQ2515X_ICCTRL0, 0x10},
> +	{BQ2515X_ICCTRL1, 0x0},
> +	{BQ2515X_ICCTRL2, 0x40},
> +	{BQ2515X_ADCCTRL0, 0x2},
> +	{BQ2515X_ADCCTRL1, 0x40},
> +	{BQ2515X_ADC_COMP1_M, 0x23},
> +	{BQ2515X_ADC_COMP1_L, 0x20},
> +	{BQ2515X_ADC_COMP2_M, 0x38},
> +	{BQ2515X_ADC_COMP2_L, 0x90},
> +	{BQ2515X_ADC_COMP3_M, 0x0},
> +	{BQ2515X_ADC_COMP3_L, 0x0},
> +	{BQ2515X_ADC_READ_EN, 0x0},
> +	{BQ2515X_TS_FASTCHGCTRL, 0x34},
> +	{BQ2515X_TS_COLD, 0x7C},
> +	{BQ2515X_TS_COOL, 0x6D},
> +	{BQ2515X_TS_WARM, 0x38},
> +	{BQ2515X_TS_HOT, 0x27},
> +	{BQ2515X_DEVICE_ID, 0x35},
> +};
> +
> +static bool bq2515x_is_ps_online(struct bq2515x_device *bq2515x)
> +{
> +	return bq2515x->mains_online;
> +}
> +
> +static int bq2515x_wake_up(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int val;
> +
> +	/* Read the STAT register if we can read it then the device is out
> +	 * of ship mode.  If the register cannot be read then attempt to wake
> +	 * it up and enable the ADC.
> +	 */
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT0, &val);
> +	if (!ret)
> +		return ret;
> +
> +	/* Need to toggle LP and bring device out of ship mode. The device
> +	 * will exit the ship mode when the MR pin is held low for at least
> +	 * t_WAKE2 as shown in section 8.3.7.1 of the datasheet.
> +	 */
> +	if (bq2515x->lp_gpio)
> +		gpiod_set_value_cansleep(bq2515x->lp_gpio, 0);

gpiod_set_value_cansleep is nop when NULL is supplied as gpio,
so can drop the if.

> +	if (bq2515x->lp_gpio) {
> +		gpiod_set_value_cansleep(bq2515x->reset_gpio, 0);
> +		usleep_range(BQ2515X_TWAKE2_MIN_US, BQ2515X_TWAKE2_MAX_US);
> +		gpiod_set_value_cansleep(bq2515x->reset_gpio, 1);
> +	}

The if is wrong (lp_gpio instead of reset_gpio). Also you can just
remove it.

> +	return regmap_write(bq2515x->regmap, BQ2515X_ADC_READ_EN, BIT(3));
> +}
> +
> +static int bq2515x_update_ps_status(struct bq2515x_device *bq2515x)
> +{
> +	bool dc =3D false;
> +	unsigned int val;
> +	int ret;
> +
> +	if (bq2515x->ac_detect_gpio)
> +		val =3D gpiod_get_value_cansleep(bq2515x->ac_detect_gpio);
> +

empty line can be removed.

> +	else {
> +		ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT0, &val);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	dc =3D val & BQ2515X_VIN_GOOD;
> +
> +	ret =3D bq2515x->mains_online !=3D dc;
> +
> +	bq2515x->mains_online =3D dc;
> +
> +	return ret;
> +}
> +
> +static int bq2515x_disable_watchdog_timers(struct bq2515x_device *bq2515=
x)
> +{
> +	int ret;
> +
> +	ret =3D regmap_update_bits(bq2515x->regmap, BQ2515X_CHARGERCTRL0,
> +			BQ2515X_WATCHDOG_DISABLE, BQ2515X_WATCHDOG_DISABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	return regmap_update_bits(bq2515x->regmap, BQ2515X_ICCTRL2,
> +						BQ2515X_HWRESET_14S_WD, 0);
> +}
> +
> +static int bq2515x_get_battery_voltage_now(struct bq2515x_device *bq2515=
x)
> +{
> +	int ret;
> +	int vbat_msb;
> +	int vbat_lsb;
> +	uint32_t vbat_measurement;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))
> +		bq2515x_wake_up(bq2515x);
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_VBAT_M, &vbat_msb);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_VBAT_L, &vbat_lsb);
> +	if (ret)
> +		return ret;
> +
> +	vbat_measurement =3D (vbat_msb << 8) | vbat_lsb;
> +
> +	return vbat_measurement * (BQ2515X_UV_FACTOR / BQ2515X_DIVISOR) * 6;
> +}
> +
> +static int bq2515x_get_battery_current_now(struct bq2515x_device *bq2515=
x)
> +{
> +	int ret;
> +	int ichg_msb;
> +	int ichg_lsb;
> +	uint32_t ichg_measurement;
> +	u16 ichg_multiplier =3D BQ2515X_ICHG_RNG_1B0_UA;
> +	unsigned int ichg_reg_code, reg_code;
> +	unsigned int icharge_range =3D 0, pchrgctrl;
> +	unsigned int buvlo, vlowv_sel, vlowv =3D BQ2515X_VLOWV_SEL_1B0_UV;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))
> +		return -ENODATA;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_ICHG_M, &ichg_msb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ADC_ICHG_L, &ichg_lsb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ichg_measurement =3D (ichg_msb << 8) | ichg_lsb;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_BUVLO, &buvlo);
> +	if (ret < 0)
> +		return ret;
> +
> +	vlowv_sel =3D buvlo & BQ2515X_VLOWV_SEL;
> +
> +	if (vlowv_sel)
> +		vlowv =3D BQ2515X_VLOWV_SEL_1B1_UV;
> +
> +	if (bq2515x_get_battery_voltage_now(bq2515x) < vlowv) {
> +		ret =3D regmap_read(bq2515x->regmap, BQ2515X_PCHRGCTRL,
> +								&pchrgctrl);
> +		if (ret < 0)
> +			return ret;
> +		reg_code =3D pchrgctrl & BQ2515X_PRECHARGE_MASK;
> +	} else {
> +		ret =3D regmap_read(bq2515x->regmap, BQ2515X_ICHG_CTRL,
> +							&ichg_reg_code);
> +		if (ret < 0)
> +			return ret;
> +		reg_code =3D ichg_reg_code;
> +	}
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_PCHRGCTRL, &pchrgctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	icharge_range =3D pchrgctrl & BQ2515X_ICHARGE_RANGE;
> +
> +	if (icharge_range)
> +		ichg_multiplier =3D BQ2515X_ICHG_RNG_1B1_UA;
> +
> +	return reg_code * (ichg_multiplier * ichg_measurement
> +						/ BQ2515X_ICHG_DIVISOR);
> +}
> +
> +static bool bq2515x_get_charge_disable(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int ce_pin =3D 0;
> +	int icctrl2;
> +	int charger_disable;
> +
> +	if (bq2515x->ce_gpio)
> +		ce_pin =3D gpiod_get_value_cansleep(bq2515x->ce_gpio);

gpiod_get_value_cansleep will return 0 if NULL is supplied,
so you can remove the if.

> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ICCTRL2, &icctrl2);
> +	if (ret < 0)
> +		return ret;
> +
> +	charger_disable =3D icctrl2 & BQ2515X_CHARGER_DISABLE;
> +
> +	if (charger_disable || ce_pin)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int bq2515x_set_charge_disable(struct bq2515x_device *bq2515x, in=
t val)
> +{
> +	if (bq2515x->ce_gpio)
> +		gpiod_set_value_cansleep(bq2515x->ce_gpio, val);

Here the if can also be removed.

> +
> +	return regmap_update_bits(bq2515x->regmap, BQ2515X_ICCTRL2,
> +					BQ2515X_CHARGER_DISABLE, val);
> +}
> +
> +static int bq2515x_get_const_charge_current(struct bq2515x_device *bq251=
5x)
> +{
> +	int ret;
> +	u16 ichg_multiplier =3D BQ2515X_ICHG_RNG_1B0_UA;
> +	unsigned int ichg_reg_code;
> +	unsigned int pchrgctrl;
> +	unsigned int icharge_range;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ICHG_CTRL, &ichg_reg_code);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_PCHRGCTRL, &pchrgctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	icharge_range =3D pchrgctrl & BQ2515X_ICHARGE_RANGE;
> +
> +	if (icharge_range)
> +		ichg_multiplier =3D BQ2515X_ICHG_RNG_1B1_UA;
> +
> +	return ichg_reg_code * ichg_multiplier;
> +}
> +
> +static int bq2515x_set_const_charge_current(struct bq2515x_device *bq251=
5x,
> +								int val)
> +{
> +	int ret;
> +	unsigned int ichg_reg_code;
> +	u16 ichg_multiplier =3D BQ2515X_ICHG_RNG_1B0_UA;
> +	unsigned int icharge_range =3D 0;
> +
> +	if (val > BQ2515X_ICHG_MAX_UA || val < BQ2515X_ICHG_MIN_UA)
> +		return -EINVAL;
> +
> +	if (val > BQ2515X_ICHG_CURR_STEP_THRESH_UA) {
> +		ichg_multiplier =3D BQ2515X_ICHG_RNG_1B1_UA;
> +		icharge_range =3D BQ2515X_ICHARGE_RANGE;
> +	}
> +
> +	bq2515x_set_charge_disable(bq2515x, 1);
> +
> +	ret =3D regmap_update_bits(bq2515x->regmap, BQ2515X_PCHRGCTRL,
> +					BQ2515X_ICHARGE_RANGE, icharge_range);
> +	if (ret < 0)
> +		return ret;
> +
> +	ichg_reg_code =3D val / ichg_multiplier;
> +
> +	ret =3D regmap_write(bq2515x->regmap, BQ2515X_ICHG_CTRL, ichg_reg_code);
> +	if (ret < 0)
> +		return ret;
> +
> +	return bq2515x_set_charge_disable(bq2515x, 0);
> +}
> +
> +static int bq2515x_get_precharge_current(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	unsigned int pchrgctrl;
> +	unsigned int icharge_range;
> +	u16 precharge_multiplier =3D BQ2515X_ICHG_RNG_1B0_UA;
> +	unsigned int precharge_reg_code;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_PCHRGCTRL, &pchrgctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	icharge_range =3D pchrgctrl & BQ2515X_ICHARGE_RANGE;
> +
> +	if (icharge_range)
> +		precharge_multiplier =3D BQ2515X_ICHG_RNG_1B1_UA;
> +
> +	precharge_reg_code =3D pchrgctrl & BQ2515X_PRECHARGE_MASK;
> +
> +	return precharge_reg_code * precharge_multiplier;
> +}
> +
> +static int bq2515x_set_precharge_current(struct bq2515x_device *bq2515x,
> +					int val)
> +{
> +	int ret;
> +	unsigned int pchrgctrl;
> +	unsigned int icharge_range;
> +	unsigned int precharge_reg_code;
> +	u16 precharge_multiplier =3D BQ2515X_ICHG_RNG_1B0_UA;
> +	u16 precharge_max_ua =3D BQ2515X_PRECHRG_ICHRG_RNGE_1875_UA;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_PCHRGCTRL, &pchrgctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	icharge_range =3D pchrgctrl & BQ2515X_ICHARGE_RANGE;
> +
> +	if (icharge_range) {
> +		precharge_max_ua =3D BQ2515X_PRECHRG_ICHRG_RNGE_3750_UA;
> +		precharge_multiplier =3D BQ2515X_ICHG_RNG_1B1_UA;
> +	}
> +	if (val > precharge_max_ua || val < BQ2515X_ICHG_MIN_UA)
> +		return -EINVAL;
> +
> +	precharge_reg_code =3D val / precharge_multiplier;
> +
> +	ret =3D bq2515x_set_charge_disable(bq2515x, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_update_bits(bq2515x->regmap, BQ2515X_PCHRGCTRL,
> +				BQ2515X_PRECHARGE_MASK, precharge_reg_code);
> +	if (ret < 0)
> +		return ret;
> +
> +	return bq2515x_set_charge_disable(bq2515x, 0);
> +}
> +
> +static int bq2515x_charging_status(struct bq2515x_device *bq2515x,
> +				   union power_supply_propval *val)
> +{
> +	bool status0_no_fault;
> +	bool status1_no_fault;
> +	bool ce_status;
> +	bool charge_done;
> +	unsigned int status;
> +	int ret;
> +
> +	if (!bq2515x_is_ps_online(bq2515x)) {
> +		val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		return 0;
> +	}
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT0, &status);
> +	if (ret)
> +		return ret;
> +
> +	/**
> +	 * The code block below is used to determine if any faults from the
> +	 * STAT0 register are disbaling charging or if the charge has completed
> +	 * according to the CHARGE_DONE_STAT bit.
> +	 */
> +	if (((status & BQ2515X_STAT0_MASK) =3D=3D true) &
> +			((status & BQ2515X_CHRG_DONE) =3D=3D false)) {
> +		status0_no_fault =3D true;
> +		charge_done =3D false;
> +	} else if (status & BQ2515X_CHRG_DONE) {
> +		charge_done =3D true;
> +		status0_no_fault =3D false;
> +	} else {
> +		status0_no_fault =3D false;
> +		charge_done =3D false;
> +	}
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT1, &status);
> +	if (ret)
> +		return ret;
> +	/**
> +	 *The code block below is used to determine if any faults from the
> +	 * STAT1 register are disbaling charging
> +	 */
> +	if ((status & BQ2515X_STAT1_MASK) =3D=3D false)
> +		status1_no_fault =3D true;
> +	else
> +		status1_no_fault =3D false;
> +
> +	ce_status =3D (!bq2515x_get_charge_disable(bq2515x));
> +
> +	/**
> +	 *If there are no faults and charging is enabled, then status is
> +	 *charging. Otherwise, if charging is complete, then status is full.
> +	 *Otherwise, if a fault exists or charging is disbaled, then status is
> +	 *not charging
> +	 */
> +	if (status0_no_fault & status1_no_fault & ce_status)
> +		val->intval =3D POWER_SUPPLY_STATUS_CHARGING;
> +	else if (charge_done)
> +		val->intval =3D POWER_SUPPLY_STATUS_FULL;
> +	else if (!(status0_no_fault & status1_no_fault & ce_status))
> +		val->intval =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +	return ret;
> +}
> +
> +static int bq2515x_get_batt_reg(struct bq2515x_device *bq2515x)
> +{
> +	int vbat_reg_code;
> +	int ret;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_VBAT_CTRL, &vbat_reg_code);
> +	if (ret)
> +		return ret;
> +
> +	return BQ2515X_VBAT_BASE_VOLT + vbat_reg_code * BQ2515X_VBAT_STEP_UV;
> +}
> +
> +static int bq2515x_set_batt_reg(struct bq2515x_device *bq2515x, int val)
> +{
> +	int vbat_reg_code;
> +
> +	if (val > BQ2515X_VBAT_REG_MAX || val < BQ2515X_VBAT_REG_MIN)
> +		return -EINVAL;
> +
> +	vbat_reg_code =3D (val - BQ2515X_VBAT_BASE_VOLT) / BQ2515X_VBAT_STEP_UV;
> +
> +	return regmap_write(bq2515x->regmap, BQ2515X_VBAT_CTRL, vbat_reg_code);
> +}
> +
> +static int bq2515x_get_ilim_lvl(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +	int ilimctrl;
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_ILIMCTRL, &ilimctrl);
> +	if (ret)
> +		return ret;
> +
> +	return bq2515x_ilim_lvl_values[ilimctrl & BQ2515X_ILIM_MASK];
> +}
> +
> +static int bq2515x_set_ilim_lvl(struct bq2515x_device *bq2515x, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(bq2515x_ilim_lvl_values); i++) {
> +		if (val =3D=3D bq2515x_ilim_lvl_values[i])
> +			break;
> +
> +		if (val > bq2515x_ilim_lvl_values[i - 1] &&
> +		    val < bq2515x_ilim_lvl_values[i]) {
> +			if (val - bq2515x_ilim_lvl_values[i - 1] <
> +			    bq2515x_ilim_lvl_values[i] - val) {
> +				i =3D i - 1;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return regmap_write(bq2515x->regmap, BQ2515X_ILIMCTRL, i);
> +}
> +
> +static int bq2515x_power_supply_property_is_writeable(struct power_suppl=
y *psy,
> +					enum power_supply_property prop)
> +{
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int bq2515x_charger_get_health(struct bq2515x_device *bq2515x,
> +				      union power_supply_propval *val)
> +{
> +	int health =3D POWER_SUPPLY_HEALTH_GOOD;
> +	int ret;
> +	unsigned int stat1;
> +	unsigned int flag3;
> +
> +	if (!bq2515x_is_ps_online(bq2515x))
> +		bq2515x_wake_up(bq2515x);
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_FLAG3, &flag3);
> +	if (ret)
> +		return ret;
> +
> +	if (flag3 & BQ2515X_SAFETY_TIMER_EXP) {
> +		health =3D POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> +		goto ret_health;
> +	}
> +
> +	if (stat1 & BQ2515X_VIN_OVP_FAULT_STAT) {
> +		health =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		goto ret_health;
> +	}
> +
> +	ret =3D regmap_read(bq2515x->regmap, BQ2515X_STAT1, &stat1);
> +	if (ret)
> +		return ret;
> +
> +	if (stat1 & BQ2515X_HEALTH_MASK) {
> +		switch (stat1 & BQ2515X_HEALTH_MASK) {
> +		case BQ2515X_TS_HOT_STAT:
> +			health =3D POWER_SUPPLY_HEALTH_HOT;
> +			break;
> +		case BQ2515X_TS_WARM_STAT:
> +			health =3D POWER_SUPPLY_HEALTH_WARM;
> +			break;
> +		case BQ2515X_TS_COOL_STAT:
> +			health =3D POWER_SUPPLY_HEALTH_COOL;
> +			break;
> +		case BQ2515X_TS_COLD_STAT:
> +			health =3D POWER_SUPPLY_HEALTH_COLD;
> +			break;
> +		default:
> +			health =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +			break;
> +		}
> +	}
> +=09
> +	goto ret_health;
> +
> +ret_health:
> +	val->intval =3D health;
> +	return 0;
> +}
> +
> +static int bq2515x_mains_set_property(struct power_supply *psy,
> +		enum power_supply_property prop,
> +		const union power_supply_propval *val)
> +{
> +	struct bq2515x_device *bq2515x =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq2515x_set_ilim_lvl(bq2515x, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D bq2515x_set_batt_reg(bq2515x, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D bq2515x_set_const_charge_current(bq2515x, val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret =3D bq2515x_set_precharge_current(bq2515x, val->intval);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bq2515x_mains_get_property(struct power_supply *psy,
> +				     enum power_supply_property prop,
> +				     union power_supply_propval *val)
> +{
> +	struct bq2515x_device *bq2515x =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	switch (prop) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D bq2515x->mains_online;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D bq2515x_get_const_charge_current(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_PRECHARGE_CURRENT:
> +		ret =3D bq2515x_get_precharge_current(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D bq2515x_get_ilim_lvl(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		ret =3D bq2515x_get_batt_reg(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D bq2515x->model_name;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D BQ2515X_MANUFACTURER;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX:
> +		val->intval =3D BQ2515X_VBAT_REG_MAX;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_MIN:
> +		val->intval =3D BQ2515X_VBAT_REG_MIN;
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT_MAX:
> +		val->intval =3D BQ2515X_ICHG_MAX_UA;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bq2515x_battery_get_property(struct power_supply *psy,
> +				       enum power_supply_property prop,
> +				       union power_supply_propval *val)
> +{
> +	struct bq2515x_device *bq2515x =3D power_supply_get_drvdata(psy);
> +	int ret;
> +
> +	ret =3D bq2515x_update_ps_status(bq2515x);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (prop) {
> +
> +	case POWER_SUPPLY_PROP_STATUS:
> +		if (!bq2515x_is_ps_online(bq2515x)) {
> +			val->intval =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +			break;
> +		}
> +
> +		ret =3D bq2515x_charging_status(bq2515x, val);
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D bq2515x_get_battery_voltage_now(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D bq2515x_get_battery_current_now(bq2515x);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D ret;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D bq2515x_charger_get_health(bq2515x, val);
> +		if (ret)
> +			val->intval =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static enum power_supply_property bq2515x_battery_properties[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +};
> +
> +static enum power_supply_property bq2515x_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_PRECHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_VOLTAGE_MIN,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static struct power_supply_desc bq2515x_mains_desc =3D {
> +	.name			=3D "bq2515x-mains",
> +	.type			=3D POWER_SUPPLY_TYPE_MAINS,
> +	.get_property		=3D bq2515x_mains_get_property,
> +	.set_property		=3D bq2515x_mains_set_property,
> +	.properties		=3D bq2515x_charger_properties,
> +	.num_properties		=3D ARRAY_SIZE(bq2515x_charger_properties),
> +	.property_is_writeable =3D bq2515x_power_supply_property_is_writeable,
> +
> +};
> +
> +static struct power_supply_desc bq2515x_battery_desc =3D {
> +	.name			=3D "bq2515x-battery",
> +	.type			=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.get_property		=3D bq2515x_battery_get_property,
> +	.properties		=3D bq2515x_battery_properties,
> +	.num_properties		=3D ARRAY_SIZE(bq2515x_battery_properties),
> +};
> +
> +static int bq2515x_power_supply_register(struct bq2515x_device *bq2515x)
> +{
> +	struct power_supply_config psy_cfg =3D { .drv_data =3D bq2515x, };
> +
> +	bq2515x->mains =3D devm_power_supply_register(bq2515x->dev,
> +						    &bq2515x_mains_desc,
> +						    &psy_cfg);
> +	if (IS_ERR(bq2515x->mains))
> +		return -EINVAL;
> +
> +	bq2515x->battery =3D devm_power_supply_register(bq2515x->dev,
> +						      &bq2515x_battery_desc,
> +						      &psy_cfg);
> +	if (IS_ERR(bq2515x->battery))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int bq2515x_hw_init(struct bq2515x_device *bq2515x)
> +{
> +	int ret =3D 0;
> +
> +	if (bq2515x->init_data.ichg)
> +		ret =3D bq2515x_set_const_charge_current(bq2515x,
> +						bq2515x->init_data.ichg);
> +
> +	if (ret)
> +		goto err_out;
> +
> +	if (bq2515x->init_data.ilim)
> +		ret =3D bq2515x_set_ilim_lvl(bq2515x, bq2515x->init_data.ilim);
> +
> +	if (ret)
> +		goto err_out;
> +
> +	if (bq2515x->init_data.vreg)
> +		ret =3D bq2515x_set_batt_reg(bq2515x, bq2515x->init_data.vreg);
> +
> +	if (ret)
> +		goto err_out;
> +
> +	ret =3D bq2515x_disable_watchdog_timers(bq2515x);
> +
> +	if (ret)
> +		goto err_out;
> +
> +err_out:
> +	return ret;
> +}
> +
> +static int bq2515x_read_properties(struct bq2515x_device *bq2515x)
> +{
> +	int ret;
> +
> +	ret =3D device_property_read_u32(bq2515x->dev,
> +				      "constant-charge-current-max-microamp",
> +				      &bq2515x->init_data.ichg);
> +	if (ret)
> +		bq2515x->init_data.ichg =3D BQ2515X_DEFAULT_ICHG_UA;
> +
> +	ret =3D device_property_read_u32(bq2515x->dev,
> +				      "precharge-current-max-microamp",
> +				      &bq2515x->init_data.iprecharge);
> +	if (ret)
> +		bq2515x->init_data.iprecharge =3D BQ2515X_DEFAULT_IPRECHARGE_UA;
> +
> +	ret =3D device_property_read_u32(bq2515x->dev,
> +				      "input-current-limit-microamp",
> +				      &bq2515x->init_data.ilim);
> +	if (ret)
> +		switch (bq2515x->device_id) {
> +		case BQ25150:
> +			bq2515x->init_data.ilim =3D BQ25150_DEFAULT_ILIM_UA;
> +			break;
> +		case BQ25155:
> +			bq2515x->init_data.ilim =3D BQ25155_DEFAULT_ILIM_UA;
> +			break;
> +		}
> +
> +	ret =3D device_property_read_u32(bq2515x->dev,
> +				      "constant-charge-voltage-max-microvolt",
> +				      &bq2515x->init_data.vreg);
> +	if (ret)
> +		bq2515x->init_data.vreg =3D BQ2515X_DEFAULT_VBAT_REG_UV;

As I wrote in the bindings patch, the *-charge-* properties
should be in a simple-battery node and can be received via
power_supply_get_battery_info(). There are a few example
drivers in mainline tree.

> +	bq2515x->ac_detect_gpio =3D devm_gpiod_get_optional(bq2515x->dev,
> +						   "ac_detect", GPIOD_IN);
> +	if (IS_ERR(bq2515x->ac_detect_gpio))
> +		dev_info(bq2515x->dev, "ac_detect GPIO not defined");

This is incorrect. You are calling devm_gpiod_get_optional,
which returns NULL if the gpio is not defined. If an error
is returned you should return it, since it can be e.g.
EPROBE_DEFER. In any case the system designer configured a
GPIO and expects it to be used, so its better to just return
an the error instead of ignoring it.

> +	bq2515x->reset_gpio =3D devm_gpiod_get_optional(bq2515x->dev,
> +						   "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(bq2515x->reset_gpio)) {
> +		if (PTR_ERR(bq2515x->reset_gpio) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	bq2515x->lp_gpio =3D devm_gpiod_get_optional(bq2515x->dev, "low-power",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(bq2515x->lp_gpio)) {
> +		if (PTR_ERR(bq2515x->lp_gpio) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}
> +
> +	bq2515x->ce_gpio =3D devm_gpiod_get_optional(bq2515x->dev,
> +						   "charge-enable",
> +						   GPIOD_OUT_LOW);
> +	if (IS_ERR(bq2515x->ce_gpio)) {
> +		if (PTR_ERR(bq2515x->ce_gpio) =3D=3D -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +	}

For all of the GPIOs you should also just return PTR_ERR().

> +	return 0;
> +}
> +
> +static bool bq2515x_volatile_register(struct device *dev, unsigned int r=
eg)
> +{
> +	switch (reg) {
> +	case BQ2515X_STAT0 ... BQ2515X_FLAG3:
> +	case BQ2515X_ADC_VBAT_M ... BQ2515X_ADC_IIN_L:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static const struct regmap_config bq25150_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register		=3D BQ2515X_DEVICE_ID,
> +	.reg_defaults		=3D bq25150_reg_defs,
> +	.num_reg_defaults	=3D ARRAY_SIZE(bq25150_reg_defs),
> +	.cache_type		=3D REGCACHE_RBTREE,
> +	.volatile_reg		=3D bq2515x_volatile_register,
> +};
> +
> +static const struct regmap_config bq25155_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +
> +	.max_register		=3D BQ2515X_DEVICE_ID,
> +	.reg_defaults		=3D bq25155_reg_defs,
> +	.num_reg_defaults	=3D ARRAY_SIZE(bq25155_reg_defs),
> +	.cache_type		=3D REGCACHE_RBTREE,
> +	.volatile_reg		=3D bq2515x_volatile_register,
> +};
> +
> +static int bq2515x_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct bq2515x_device *bq;
> +	int ret;
> +
> +	bq =3D devm_kzalloc(dev, sizeof(*bq), GFP_KERNEL);
> +	if (!bq)
> +		return -ENOMEM;
> +
> +	bq->client =3D client;
> +	bq->dev =3D dev;
> +
> +	mutex_init(&bq->lock);
> +
> +	strncpy(bq->model_name, id->name, I2C_NAME_SIZE);
> +
> +	bq->device_id =3D (enum bq2515x_id)of_device_get_match_data(&client->de=
v);
> +
> +	switch (bq->device_id) {
> +	case BQ25150:
> +		bq->regmap =3D devm_regmap_init_i2c(client,
> +&bq25150_regmap_config);
> +		break;
> +	case BQ25155:
> +		bq->regmap =3D devm_regmap_init_i2c(client,
> +&bq25155_regmap_config);
> +		break;
> +	}
> +
> +	if (IS_ERR(bq->regmap)) {
> +		dev_err(dev, "failed to allocate register map\n");
> +		return PTR_ERR(bq->regmap);
> +	}
> +
> +	i2c_set_clientdata(client, bq);
> +
> +	ret =3D bq2515x_read_properties(bq);
> +	if (ret) {
> +		dev_err(dev, "Failed to read device tree properties %d\n",
> +									ret);
> +		goto err_out;
> +	}
> +
> +	ret =3D bq2515x_hw_init(bq);
> +	if (ret) {
> +		dev_err(dev, "Cannot initialize the chip.\n");
> +		goto err_out;
> +	}
> +
> +	return bq2515x_power_supply_register(bq);
> +
> +err_out:
> +	mutex_destroy(&bq->lock);
> +	return ret;
> +}
> +
> +static const struct i2c_device_id bq2515x_i2c_ids[] =3D {
> +	{ "bq25150", BQ25150, },
> +	{ "bq25155", BQ25155, },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bq2515x_i2c_ids);
> +
> +static const struct of_device_id bq2515x_of_match[] =3D {
> +	{ .compatible =3D "ti,bq25150", },
> +	{ .compatible =3D "ti,bq25155", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, bq2515x_of_match);
> +
> +static struct i2c_driver bq2515x_driver =3D {
> +	.driver =3D {
> +		.name =3D "bq2515x-charger",
> +		.of_match_table =3D bq2515x_of_match,
> +	},
> +	.probe =3D bq2515x_probe,
> +	.id_table =3D bq2515x_i2c_ids,
> +};
> +module_i2c_driver(bq2515x_driver);
> +
> +MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> +MODULE_AUTHOR("Ricardo Rivera-Matos <r-rivera-matos@ti.com>");
> +MODULE_DESCRIPTION("BQ2515X charger driver");
> +MODULE_LICENSE("GPL v2");

-- Sebastian

--twslmmpn4aonubnb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl6uG3oACgkQ2O7X88g7
+pq05w/9Gb8BMfm8+hd3vEXzHartmDiA2VAh6VUkMLfFP1s7Ahs/m8MNKO3bNeAS
JbKCsb0GuDW99nKfegO/b68TNaawjGehLL45nL/NFFwvOqaaYjGcM8VEIInFZMez
zKy+K2GsHCWRLVo3pvPwFCgTbipUSPsWn+jt2IbTeEKYPJ2RxWvyFoPcwHeYbHJA
M5hHiNQ0XAlHFINwXNV3kb66DdWovbXlNzwoHbckivr7w4GDvpnlNw7B+N0xYUMr
NXngLxQXERn8Hyt8zhTAadb3RRdZwxFxO8US9uc7YDagxnPyNXu1xw42Ruipjmwa
TRA97EHxwJZhEHNDuzAH/IIGOkKAmBQk7D3DEC0GkXm3aQyjukUiyrJxE+QWXgf/
SCXZ/NIngvFEEtSKCKOQPj3TR7agsleVHLss+AJso3F5HDpjLHaHVYnM+CwBbLOD
R/tqkph4mZZm9OpyXGG22eVnM4vkjpWbsUNRGfDdxCX97MYJbAPcDOVcBkXUF4x9
2K5hJC8euGLuTHyS1EWKBz2Z7JpsQLUFkNm075mnCbROceMly3hKp0mQvh+CgGiQ
2L8kOKjP68n/PFKjP8laK3LL3MimgBvgi8DC6wxxGikqSfVnmZLZtEYW223c7Vvs
h6v1SNd+EjJGN8Yn/rC7u96E3S3A0OmP/Pf9wNPMqipBtJUnAmw=
=dR7I
-----END PGP SIGNATURE-----

--twslmmpn4aonubnb--
