Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EEB10EFC
	for <lists+linux-pm@lfdr.de>; Thu,  2 May 2019 00:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEAWZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 18:25:42 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37390 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbfEAWZl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 18:25:41 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7A519260497
Received: by earth.universe (Postfix, from userid 1000)
        id C81EC3C0D1B; Thu,  2 May 2019 00:25:35 +0200 (CEST)
Date:   Thu, 2 May 2019 00:25:35 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH RESEND v13 7/8] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Message-ID: <20190501222535.yt4ofrlf6wfwfmz7@earth.universe>
References: <cover2.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
 <resend.d5ba82b3d674d237d62a5e1768c9fa81cde2cf4e.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kornhun5qxpqsmiv"
Content-Disposition: inline
In-Reply-To: <resend.d5ba82b3d674d237d62a5e1768c9fa81cde2cf4e.1554371464.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: NeoMutt/20180716
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--kornhun5qxpqsmiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2019 at 02:16:51PM +0300, Matti Vaittinen wrote:
> ROHM BD70528 PMIC includes battery charger block. Support charger
> staus queries and doing few basic settings like input current limit
> and charging current.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> Changelog v13:
> - no changes
>=20
> Changelog v12:
> - Styling fixes only
>=20
>  drivers/power/supply/Kconfig           |   9 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/bd70528-charger.c | 742 +++++++++++++++++++++++++
>  3 files changed, 752 insertions(+)
>  create mode 100644 drivers/power/supply/bd70528-charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index e901b9879e7e..903c97a67bf0 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -660,4 +660,13 @@ config FUEL_GAUGE_SC27XX
>  	 Say Y here to enable support for fuel gauge with SC27XX
>  	 PMIC chips.
> =20
> +config CHARGER_BD70528
> +	tristate "ROHM bd70528 charger driver"
> +	depends on MFD_ROHM_BD70528
> +	default n
> +	help
> +	 Say Y here to enable support for getting battery status
> +	 information and altering charger configurations from charger
> +	 block of the ROHM BD70528 Power Management IC.
> +
>  endif # POWER_SUPPLY
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b731c2a9b695..c60387b04bfa 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -87,3 +87,4 @@ obj-$(CONFIG_AXP288_CHARGER)	+=3D axp288_charger.o
>  obj-$(CONFIG_CHARGER_CROS_USBPD)	+=3D cros_usbpd-charger.o
>  obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
> +obj-$(CONFIG_CHARGER_BD70528)	+=3D bd70528-charger.o
> diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/suppl=
y/bd70528-charger.c
> new file mode 100644
> index 000000000000..c466c7b665ff
> --- /dev/null
> +++ b/drivers/power/supply/bd70528-charger.c
> @@ -0,0 +1,742 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +//
> +// Copyright (C) 2018 ROHM Semiconductors
> +//
> +// power-supply driver for ROHM BD70528 PMIC
> +
> +/*
> + * BD70528 charger HW state machine.
> + *
> + * The thermal shutdown state is not drawn. From any other state but
> + * battery error and suspend it is possible to go to TSD/TMP states
> + * if temperature is out of bounds.
> + *
> + *  CHG_RST =3D H
> + *  or CHG_EN=3DL
> + *  or (DCIN2_UVLO=3DL && DCIN1_UVLO=3DL)
> + *  or (DCIN2_OVLO=3DH & DCIN1_UVKLO=3DL)
> + *
> + *  +--------------+         +--------------+
> + *  |              |         |              |
> + *  |  Any state   +-------> |    Suspend   |
> + *  |              |         |              |
> + *  +--------------+         +------+-------+
> + *                                  |
> + *  CHG_EN =3D H && BAT_DET =3D H &&    |
> + *  No errors (temp, bat_ov, UVLO,  |
> + *  OVLO...)                        |
> + *                                  |
> + *  BAT_OV or             +---------v----------+
> + *  (DBAT && TTRI)        |                    |
> + *      +-----------------+   Trickle Charge   | <---------------+
> + *      |                 |                    |                 |
> + *      |                 +-------+------------+                 |
> + *      |                         |                              |
> + *      |                         |     ^                        |
> + *      |        V_BAT > VTRI_TH  |     |  VBAT < VTRI_TH - 50mV |
> + *      |                         |     |                        |
> + *      |                         v     |                        |
> + *      |                               |                        |
> + *      |     BAT_OV or      +----------+----+                   |
> + *      |     (DBAT && TFST) |               |                   |
> + *      |   +----------------+  Fast Charge  |                   |
> + *      |   |                |               |                   |
> + *      v   v                +----+----------+                   |
> + *                                |                              |
> + *+----------------+   ILIM_DET=3DL |    ^ ILIM_DET                |
> + *|                |   & CV_DET=3DH |    | or CV_DET=3DL             |
> + *|  Battery Error |   & VBAT >   |    | or VBAT < VRECHG_TH     |
> + *|                |   VRECHG_TH  |    | or IBAT  > IFST/x       |
> + *+----------------+   & IBAT <   |    |                         |
> + *                     IFST/x     v    |                         |
> + *       ^                             |                         |
> + *       |                   +---------+-+                       |
> + *       |                   |           |                       |
> + *       +-------------------+  Top OFF  |                       |
> + *  BAT_OV =3D H or            |           |                       |
> + *  (DBAT && TFST)           +-----+-----+                       |
> + *                                 |                             |
> + *           Stay top-off for 15s  |                             |
> + *                                 v                             |
> + *                                                               |
> + *                            +--------+                         |
> + *                            |        |                         |
> + *                            |  Done  +-------------------------+
> + *                            |        |
> + *                            +--------+   VBAT < VRECHG_TH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/rohm-bd70528.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +
> +#define CHG_STAT_SUSPEND	0x0
> +#define CHG_STAT_TRICKLE	0x1
> +#define CHG_STAT_FAST		0x3
> +#define CHG_STAT_TOPOFF		0xe
> +#define CHG_STAT_DONE		0xf
> +#define CHG_STAT_OTP_TRICKLE	0x10
> +#define CHG_STAT_OTP_FAST	0x11
> +#define CHG_STAT_OTP_DONE	0x12
> +#define CHG_STAT_TSD_TRICKLE	0x20
> +#define CHG_STAT_TSD_FAST	0x21
> +#define CHG_STAT_TSD_TOPOFF	0x22
> +#define CHG_STAT_BAT_ERR	0x7f
> +
> +static const char *bd70528_charger_model =3D "BD70528";
> +static const char *bd70528_charger_manufacturer =3D "ROHM Semiconductors=
";
> +
> +#define BD_ERR_IRQ_HND(_name_, _wrn_)					\
> +static irqreturn_t bd0528_##_name_##_interrupt(int irq, void *arg)	\
> +{									\
> +	struct power_supply *psy =3D (struct power_supply *)arg;		\
> +									\
> +	power_supply_changed(psy);					\
> +	dev_err(&psy->dev, (_wrn_));					\
> +									\
> +	return IRQ_HANDLED;						\
> +}
> +
> +#define BD_INFO_IRQ_HND(_name_, _wrn_)					\
> +static irqreturn_t bd0528_##_name_##_interrupt(int irq, void *arg)	\
> +{									\
> +	struct power_supply *psy =3D (struct power_supply *)arg;		\
> +									\
> +	power_supply_changed(psy);					\
> +	dev_dbg(&psy->dev, (_wrn_));					\
> +									\
> +	return IRQ_HANDLED;						\
> +}
> +
> +#define BD_IRQ_HND(_name_) bd0528_##_name_##_interrupt
> +
> +struct bd70528_psy {
> +	struct rohm_regmap_dev chip;
> +	struct power_supply *psy;
> +};
> +
> +BD_ERR_IRQ_HND(BAT_OV_DET, "Battery overvoltage detected\n");
> +BD_ERR_IRQ_HND(DBAT_DET, "Dead battery detected\n");
> +BD_ERR_IRQ_HND(COLD_DET, "Battery cold\n");
> +BD_ERR_IRQ_HND(HOT_DET, "Battery hot\n");
> +BD_ERR_IRQ_HND(CHG_TSD, "Charger thermal shutdown\n");
> +BD_ERR_IRQ_HND(DCIN2_OV_DET, "DCIN2 overvoltage detected\n");
> +
> +BD_INFO_IRQ_HND(BAT_OV_RES, "Battery voltage back to normal\n");
> +BD_INFO_IRQ_HND(COLD_RES, "Battery temperature back to normal\n");
> +BD_INFO_IRQ_HND(HOT_RES, "Battery temperature back to normal\n");
> +BD_INFO_IRQ_HND(BAT_RMV, "Battery removed\n");
> +BD_INFO_IRQ_HND(BAT_DET, "Battery detected\n");
> +BD_INFO_IRQ_HND(DCIN2_OV_RES, "DCIN2 voltage back to normal\n");
> +BD_INFO_IRQ_HND(DCIN2_RMV, "DCIN2 removed\n");
> +BD_INFO_IRQ_HND(DCIN2_DET, "DCIN2 detected\n");
> +BD_INFO_IRQ_HND(DCIN1_RMV, "DCIN1 removed\n");
> +BD_INFO_IRQ_HND(DCIN1_DET, "DCIN1 detected\n");
> +
> +struct irq_name_pair {
> +	const char *n;
> +	irqreturn_t (*h)(int irq, void *arg);
> +};
> +
> +static int bd70528_get_irqs(struct platform_device *pdev,
> +			    struct bd70528_psy *bdpsy)
> +{
> +	int irq, i, ret;
> +	unsigned int mask;
> +	struct irq_name_pair bd70528_chg_irqs[] =3D {
> +		{ .n =3D "bd70528-bat-ov-res", .h =3D BD_IRQ_HND(BAT_OV_RES) },
> +		{ .n =3D "bd70528-bat-ov-det", .h =3D BD_IRQ_HND(BAT_OV_DET) },
> +		{ .n =3D "bd70528-bat-dead", .h =3D BD_IRQ_HND(DBAT_DET) },
> +		{ .n =3D "bd70528-bat-warmed", .h =3D BD_IRQ_HND(COLD_RES) },
> +		{ .n =3D "bd70528-bat-cold", .h =3D BD_IRQ_HND(COLD_DET) },
> +		{ .n =3D "bd70528-bat-cooled", .h =3D BD_IRQ_HND(HOT_RES) },
> +		{ .n =3D "bd70528-bat-hot", .h =3D BD_IRQ_HND(HOT_DET) },
> +		{ .n =3D "bd70528-chg-tshd", .h =3D BD_IRQ_HND(CHG_TSD) },
> +		{ .n =3D "bd70528-bat-removed", .h =3D BD_IRQ_HND(BAT_RMV) },
> +		{ .n =3D "bd70528-bat-detected", .h =3D BD_IRQ_HND(BAT_DET) },
> +		{ .n =3D "bd70528-dcin2-ov-res", .h =3D BD_IRQ_HND(DCIN2_OV_RES) },
> +		{ .n =3D "bd70528-dcin2-ov-det", .h =3D BD_IRQ_HND(DCIN2_OV_DET) },
> +		{ .n =3D "bd70528-dcin2-removed", .h =3D BD_IRQ_HND(DCIN2_RMV) },
> +		{ .n =3D "bd70528-dcin2-detected", .h =3D BD_IRQ_HND(DCIN2_DET) },
> +		{ .n =3D "bd70528-dcin1-removed", .h =3D BD_IRQ_HND(DCIN1_RMV) },
> +		{ .n =3D "bd70528-dcin1-detected", .h =3D BD_IRQ_HND(DCIN1_DET) },
> +	};

static const?

> +	for (i =3D 0; i < ARRAY_SIZE(bd70528_chg_irqs); i++) {
> +		irq =3D platform_get_irq_byname(pdev, bd70528_chg_irqs[i].n);
> +		if (irq < 0) {
> +			dev_err(&pdev->dev, "Bad IRQ information for %s (%d)\n",
> +				bd70528_chg_irqs[i].n, irq);
> +			return irq;
> +		}
> +		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						bd70528_chg_irqs[i].h,
> +						IRQF_ONESHOT,
> +						bd70528_chg_irqs[i].n,
> +						bdpsy->psy);
> +
> +		if (ret)
> +			return ret;
> +	}
> +	/*
> +	 * BD70528 irq controller is not touching the main mask register.
> +	 * So enable the charger block interrupts at main level. We can just
> +	 * leave them enabled as irq-controller should disable irqs
> +	 * from sub-registers when IRQ is disabled or freed.
> +	 */
> +	mask =3D BD70528_REG_INT_BAT1_MASK | BD70528_REG_INT_BAT2_MASK;
> +	ret =3D regmap_update_bits(bdpsy->chip.regmap,
> +				 BD70528_REG_INT_MAIN_MASK, mask, 0);
> +	if (ret)
> +		dev_err(&pdev->dev, "Failed to enable charger IRQs\n");
> +
> +	return ret;
> +}
> +
> +static int bd70528_get_charger_status(struct bd70528_psy *bdpsy, int *va=
l)
> +{
> +	int ret;
> +	unsigned int v;
> +
> +	ret =3D regmap_read(bdpsy->chip.regmap, BD70528_REG_CHG_CURR_STAT, &v);
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev, "Charger state read failure %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	switch (v & BD70528_MASK_CHG_STAT) {
> +	case CHG_STAT_SUSPEND:
> +	/* Maybe we should check the CHG_TTRI_EN? */
> +	case CHG_STAT_OTP_TRICKLE:
> +	case CHG_STAT_OTP_FAST:
> +	case CHG_STAT_OTP_DONE:
> +	case CHG_STAT_TSD_TRICKLE:
> +	case CHG_STAT_TSD_FAST:
> +	case CHG_STAT_TSD_TOPOFF:
> +	case CHG_STAT_BAT_ERR:
> +		*val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case CHG_STAT_DONE:
> +		*val =3D POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case CHG_STAT_TRICKLE:
> +	case CHG_STAT_FAST:
> +	case CHG_STAT_TOPOFF:
> +		*val =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bd70528_get_charge_type(struct bd70528_psy *bdpsy, int *val)
> +{
> +	int ret;
> +	unsigned int v;
> +
> +	ret =3D regmap_read(bdpsy->chip.regmap, BD70528_REG_CHG_CURR_STAT, &v);
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev, "Charger state read failure %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	switch (v & BD70528_MASK_CHG_STAT) {
> +	case CHG_STAT_TRICKLE:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case CHG_STAT_FAST:
> +	case CHG_STAT_TOPOFF:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	case CHG_STAT_DONE:
> +	case CHG_STAT_SUSPEND:
> +	/* Maybe we should check the CHG_TTRI_EN? */
> +	case CHG_STAT_OTP_TRICKLE:
> +	case CHG_STAT_OTP_FAST:
> +	case CHG_STAT_OTP_DONE:
> +	case CHG_STAT_TSD_TRICKLE:
> +	case CHG_STAT_TSD_FAST:
> +	case CHG_STAT_TSD_TOPOFF:
> +	case CHG_STAT_BAT_ERR:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bd70528_get_battery_health(struct bd70528_psy *bdpsy, int *va=
l)
> +{
> +	int ret;
> +	unsigned int v;
> +
> +	ret =3D regmap_read(bdpsy->chip.regmap, BD70528_REG_CHG_BAT_STAT, &v);
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev, "Battery state read failure %d\n",
> +			ret);
> +		return ret;
> +	}
> +	/* No battery? */
> +	if (!(v & BD70528_MASK_CHG_BAT_DETECT))
> +		*val =3D POWER_SUPPLY_HEALTH_DEAD;
> +	else if (v & BD70528_MASK_CHG_BAT_OVERVOLT)
> +		*val =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +	else if (v & BD70528_MASK_CHG_BAT_TIMER)
> +		*val =3D POWER_SUPPLY_HEALTH_SAFETY_TIMER_EXPIRE;
> +	else
> +		*val =3D POWER_SUPPLY_HEALTH_GOOD;
> +
> +	return 0;
> +}
> +
> +static int bd70528_get_online(struct bd70528_psy *bdpsy, int *val)
> +{
> +	int ret;
> +	unsigned int v;
> +
> +	ret =3D regmap_read(bdpsy->chip.regmap, BD70528_REG_CHG_IN_STAT, &v);
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev, "DC1 IN state read failure %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	*val =3D (v & BD70528_MASK_CHG_DCIN1_UVLO) ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +static int bd70528_get_present(struct bd70528_psy *bdpsy, int *val)
> +{
> +	int ret;
> +	unsigned int v;
> +
> +	ret =3D regmap_read(bdpsy->chip.regmap, BD70528_REG_CHG_BAT_STAT, &v);
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev, "Battery state read failure %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	*val =3D (v & BD70528_MASK_CHG_BAT_DETECT) ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +struct linear_range {
> +	int min;
> +	int step;
> +	int vals;
> +	int low_sel;
> +};
> +
> +struct linear_range current_limit_ranges[] =3D {
> +	{
> +		.min =3D 5,
> +		.step =3D 1,
> +		.vals =3D 36,
> +		.low_sel =3D 0,
> +	},
> +	{
> +		.min =3D 40,
> +		.step =3D 5,
> +		.vals =3D 5,
> +		.low_sel =3D 0x23,
> +	},
> +	{
> +		.min =3D 60,
> +		.step =3D 20,
> +		.vals =3D 8,
> +		.low_sel =3D 0x27,
> +	},
> +	{
> +		.min =3D 200,
> +		.step =3D 50,
> +		.vals =3D 7,
> +		.low_sel =3D 0x2e,
> +	}
> +};

static const?

> +/*
> + * BD70528 would support setting and getting own charge current/
> + * voltage for low temperatures. The driver currently only reads
> + * the charge current at room temperature. We do set both though.
> + */
> +struct linear_range warm_charge_curr[] =3D {
> +	{
> +		.min =3D 10,
> +		.step =3D 10,
> +		.vals =3D 20,
> +		.low_sel =3D 0,
> +	},
> +	{
> +		.min =3D 200,
> +		.step =3D 25,
> +		.vals =3D 13,
> +		.low_sel =3D 0x13,
> +	},
> +};

static const?

> +/*
> + * Cold charge current selectors are identical to warm charge current
> + * selectors. The difference is that only smaller currents are available
> + * at cold charge range.
> + */
> +#define MAX_COLD_CHG_CURR_SEL 0x15
> +#define MAX_WARM_CHG_CURR_SEL 0x1f
> +#define MIN_CHG_CURR_SEL 0x0
> +
> +static int find_value_for_selector_low(struct linear_range *r, int selec=
tors,
> +				       unsigned int sel, unsigned int *val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < selectors; i++) {
> +		if (r[i].low_sel <=3D sel && r[i].low_sel + r[i].vals >=3D sel) {
> +			*val =3D r[i].min + (sel - r[i].low_sel) * r[i].step;
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
> +/*
> + * For BD70528 voltage/current limits we happily accept any value which
> + * belongs the range. We could check if value matching the selector is
> + * desired by computing the range min + (sel - sel_low) * range step - b=
ut
> + * I guess it is enough if we use voltage/current which is closest (belo=
w)
> + * the requested?
> + */
> +static int find_selector_for_value_low(struct linear_range *r, int selec=
tors,
> +				       unsigned int val, unsigned int *sel,
> +				       bool *found)
> +{
> +	int i;
> +	int ret =3D -EINVAL;
> +
> +	*found =3D false;
> +	for (i =3D 0; i < selectors; i++) {
> +		if (r[i].min <=3D val) {
> +			if (r[i].min + r[i].step * r[i].vals >=3D val) {
> +				*found =3D true;
> +				*sel =3D r[i].low_sel + (val - r[i].min) /
> +				       r[i].step;
> +				ret =3D 0;
> +				break;
> +			}
> +			/*
> +			 * If the range max is smaller than requested
> +			 * we can set the max supported value from range
> +			 */
> +			*sel =3D r[i].low_sel + r[i].vals;
> +			ret =3D 0;
> +		}
> +	}
> +	return ret;
> +}
> +
> +static int get_charge_current(struct bd70528_psy *bdpsy, int *ma)
> +{
> +	unsigned int sel;
> +	int ret;
> +
> +	ret =3D regmap_read(bdpsy->chip.regmap, BD70528_REG_CHG_CHG_CURR_WARM,
> +			  &sel);
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev,
> +			"Charge current reading failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	sel &=3D BD70528_MASK_CHG_CHG_CURR;
> +
> +	ret =3D find_value_for_selector_low(&warm_charge_curr[0],
> +					  ARRAY_SIZE(warm_charge_curr), sel,
> +					  ma);
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev,
> +			"Unknown charge current value 0x%x\n",
> +			sel);
> +	}
> +
> +	return ret;
> +}
> +
> +static int get_current_limit(struct bd70528_psy *bdpsy, int *ma)
> +{
> +	unsigned int sel;
> +	int ret;
> +
> +	ret =3D regmap_read(bdpsy->chip.regmap, BD70528_REG_CHG_DCIN_ILIM,
> +			  &sel);
> +
> +	if (ret) {
> +		dev_err(bdpsy->chip.dev,
> +			"Input current limit reading failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	sel &=3D BD70528_MASK_CHG_DCIN_ILIM;
> +
> +	ret =3D find_value_for_selector_low(&current_limit_ranges[0],
> +					  ARRAY_SIZE(current_limit_ranges), sel,
> +					  ma);
> +
> +	if (ret) {
> +		/* Unspecified values mean 500 mA */
> +		*ma =3D 500;
> +	}
> +	return 0;
> +}
> +
> +static enum power_supply_property bd70528_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +static int bd70528_charger_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct bd70528_psy *bdpsy =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return bd70528_get_charger_status(bdpsy, &val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		return bd70528_get_charge_type(bdpsy, &val->intval);
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		return bd70528_get_battery_health(bdpsy, &val->intval);
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		return bd70528_get_present(bdpsy, &val->intval);
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		ret =3D get_current_limit(bdpsy, &val->intval);
> +		val->intval *=3D 1000;
> +		return ret;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		ret =3D get_charge_current(bdpsy, &val->intval);
> +		val->intval *=3D 1000;
> +		return ret;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return bd70528_get_online(bdpsy, &val->intval);
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D bd70528_charger_model;
> +		return 0;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D bd70528_charger_manufacturer;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bd70528_prop_is_writable(struct power_supply *psy,
> +				    enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		return 1;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int set_charge_current(struct bd70528_psy *bdpsy, int ma)
> +{
> +	unsigned int reg;
> +	int ret =3D 0, tmpret;
> +	bool found;
> +
> +	if (ma > 500) {
> +		dev_warn(bdpsy->chip.dev,
> +			 "Requested charge current %u exceed maximum (500mA)\n",
> +			 ma);
> +		reg =3D MAX_WARM_CHG_CURR_SEL;
> +		goto set;
> +	}
> +	if (ma < 10) {
> +		dev_err(bdpsy->chip.dev,
> +			"Requested charge current %u smaller than min (10mA)\n",
> +			 ma);
> +		reg =3D MIN_CHG_CURR_SEL;
> +		ret =3D -EINVAL;
> +		goto set;
> +	}
> +
> +	ret =3D find_selector_for_value_low(&warm_charge_curr[0],
> +					  ARRAY_SIZE(warm_charge_curr), ma,
> +					  &reg, &found);
> +	if (ret) {
> +		reg =3D MIN_CHG_CURR_SEL;
> +		goto set;
> +	}
> +	if (!found) {
> +		/* There was a gap in supported values and we hit it */
> +		dev_warn(bdpsy->chip.dev,
> +			 "Unsupported charge current %u mA\n", ma);
> +	}
> +set:
> +
> +	tmpret =3D regmap_update_bits(bdpsy->chip.regmap,
> +				    BD70528_REG_CHG_CHG_CURR_WARM,
> +				    BD70528_MASK_CHG_CHG_CURR, reg);
> +	if (tmpret)
> +		dev_err(bdpsy->chip.dev,
> +			"Charge current write failure (%d)\n", tmpret);
> +
> +	if (reg > MAX_COLD_CHG_CURR_SEL)
> +		reg =3D MAX_COLD_CHG_CURR_SEL;
> +
> +	if (!tmpret)
> +		tmpret =3D regmap_update_bits(bdpsy->chip.regmap,
> +					    BD70528_REG_CHG_CHG_CURR_COLD,
> +					    BD70528_MASK_CHG_CHG_CURR, reg);
> +
> +	if (!ret)
> +		ret =3D tmpret;
> +
> +	return ret;
> +}
> +
> +#define MAX_CURR_LIMIT_SEL 0x34
> +#define MIN_CURR_LIMIT_SEL 0x0
> +
> +static int set_current_limit(struct bd70528_psy *bdpsy, int ma)
> +{
> +	unsigned int reg;
> +	int ret =3D 0, tmpret;
> +	bool found;
> +
> +	if (ma > 500) {
> +		dev_warn(bdpsy->chip.dev,
> +			 "Requested current limit %u exceed maximum (500mA)\n",
> +			 ma);
> +		reg =3D MAX_CURR_LIMIT_SEL;
> +		goto set;
> +	}
> +	if (ma < 5) {
> +		dev_err(bdpsy->chip.dev,
> +			"Requested current limit %u smaller than min (5mA)\n",
> +			ma);
> +		reg =3D MIN_CURR_LIMIT_SEL;
> +		ret =3D -EINVAL;
> +		goto set;
> +	}
> +
> +	ret =3D find_selector_for_value_low(&current_limit_ranges[0],
> +					  ARRAY_SIZE(current_limit_ranges), ma,
> +					  &reg, &found);
> +	if (ret) {
> +		reg =3D MIN_CURR_LIMIT_SEL;
> +		goto set;
> +	}
> +	if (!found) {
> +		/* There was a gap in supported values and we hit it ?*/
> +		dev_warn(bdpsy->chip.dev, "Unsupported current limit %umA\n",
> +			 ma);
> +	}
> +
> +set:
> +	tmpret =3D regmap_update_bits(bdpsy->chip.regmap,
> +				    BD70528_REG_CHG_DCIN_ILIM,
> +				    BD70528_MASK_CHG_DCIN_ILIM, reg);
> +
> +	if (!ret)
> +		ret =3D tmpret;
> +
> +	return ret;
> +}
> +
> +static int bd70528_charger_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{
> +	struct bd70528_psy *bdpsy =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return set_current_limit(bdpsy, val->intval / 1000);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		return set_charge_current(bdpsy, val->intval / 1000);
> +	default:
> +		break;
> +	}
> +	return -EINVAL;
> +}
> +
> +static const struct power_supply_desc bd70528_charger_desc =3D {
> +	.name		=3D "bd70528-charger",
> +	.type		=3D POWER_SUPPLY_TYPE_BATTERY,

charge should use POWER_SUPPLY_TYPE_MAINS (or
POWER_SUPPLY_TYPE_USB for USB chargers).

> +	.properties	=3D bd70528_charger_props,
> +	.num_properties	=3D ARRAY_SIZE(bd70528_charger_props),
> +	.get_property	=3D bd70528_charger_get_property,
> +	.set_property	=3D bd70528_charger_set_property,
> +	.property_is_writeable	=3D bd70528_prop_is_writable,
> +};
> +
> +static int bd70528_power_probe(struct platform_device *pdev)
> +{
> +	struct rohm_regmap_dev *mfd;
> +	struct bd70528_psy *bdpsy;
> +	struct power_supply_config cfg =3D {};
> +
> +	mfd =3D dev_get_drvdata(pdev->dev.parent);
> +	if (!mfd) {
> +		dev_err(&pdev->dev, "No MFD driver data\n");
> +		return -EINVAL;
> +	}

There is absolutley no need for this hack. Just get the regmap
for the parent device and store the regmap and the device pointer
directly in bdpsy.

> +	bdpsy =3D devm_kzalloc(&pdev->dev, sizeof(*bdpsy), GFP_KERNEL);
> +	if (!bdpsy)
> +		return -ENOMEM;
> +	bdpsy->chip =3D *mfd;
> +	bdpsy->chip.dev =3D &pdev->dev;
> +
> +	platform_set_drvdata(pdev, bdpsy);
> +	cfg.drv_data =3D bdpsy;
> +	cfg.of_node =3D pdev->dev.parent->of_node;
> +
> +	bdpsy->psy =3D devm_power_supply_register(&pdev->dev,
> +						&bd70528_charger_desc, &cfg);
> +	if (IS_ERR(bdpsy->psy)) {
> +		dev_err(&pdev->dev, "failed: power supply register\n");
> +		return PTR_ERR(bdpsy->psy);
> +	}
> +
> +	return bd70528_get_irqs(pdev, bdpsy);
> +}
> +
> +static struct platform_driver bd70528_power =3D {
> +	.driver =3D {
> +		.name =3D "bd70528-power"
> +	},
> +	.probe =3D bd70528_power_probe,
> +};
> +
> +module_platform_driver(bd70528_power);
> +
> +MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
> +MODULE_DESCRIPTION("BD70528 power-supply driver");
> +MODULE_LICENSE("GPL");

Otherwise looks ok to me.

-- Sebastian

--kornhun5qxpqsmiv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzKHNwACgkQ2O7X88g7
+ppiDQ/+OgGPMLQP+CEWv8mDagXB+9EwKkFCZ8M5q/YckDgx/iFR3ZesMy1nHL3z
MeFSnrbfKF8IHFkzoOve7DPF0V8JIQ6r4oA9r3yEdail170v5v7iPvyZso0Jrybt
ZkS8W+TVHlNJoWCCxMqvVXhbSf+EykPj6i37I0xc8TeIIGkAvn09lZQflGdU6Zil
q3E6y2e/7ua8DG7T0v/oKZABybCBCX/8C+DtRPzNpjgEn096KtCw6suaPFBVz70N
iG7taR5j/0VavQzgtdm4cCojXa9Z1m7YR52b++0tcVByqQ40/xR2nC8T8VBwtzXM
Qc/bHpoOJL6rMkClrH7seOJX46sEvknHgD6JIgM+t7djYB6ScfToB3JvvEga28eu
xv8/QhDD2CLSXs3xuaIJbcmIuZJpIRWvvDWljtcrgX3JygcoFG0WHyPFlXEoh2tm
A6XU0Y7tEX1BSDxhp1+jJChXbix7UGPce4AsXsT05Aw+KKNY9WoByBy3OtKXGCqA
Gq5/KGOO7FmklH9txvkGy5Za6lQZgzEn/lBTCyaq5nN9B6G2A+f98O9aLleH5re3
Jf8nGxC3IAnqPqTkorH9EO6Ut7a62diHi6ZBXOOar+zZjw5/03Q0x2B3oKEkdSJU
0amjxij6A77Tqvk7uxUx9GafgkrpSXvx8tsamBdu32jzccp1efI=
=WSsA
-----END PGP SIGNATURE-----

--kornhun5qxpqsmiv--
