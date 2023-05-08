Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE076FB53B
	for <lists+linux-pm@lfdr.de>; Mon,  8 May 2023 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbjEHQhi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 May 2023 12:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234258AbjEHQhf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 12:37:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2688D6A6A;
        Mon,  8 May 2023 09:37:32 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AB5266032B2;
        Mon,  8 May 2023 17:37:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563850;
        bh=ddUmLa5OsBzy+n3EvpSB4r53x/dHjJEqewcy7PBghac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLzUIr09suHFcpx6sYvlHX5Ithl4fuf6ispGh20kwgYR8X2JRZoiKGrfzZVK4IKj9
         d2LsO6ATBaoyMMKQ9DufFnxeHN7rCg3Ya4wfp6pGvggHgd8UQv7/WYXA5+45j1VqB8
         eQ8BED5rUaeIxgNhFKo7t+CcJlK2M3RIKg5IymPINuxs8zXbgAlHTeZPnv9t/6DS6Z
         ttBYfTYYy2/vkcrp7gHKEHSt0H4ikpHM8s5e+UCQSBjtvY6cFdlyZQF4V0P3tUFmoi
         4xp7/Zr9AVDKpW4C06L50CqNkmu03Vft+z02HbnkIRX1tEzj6fmzimRuIUBBR4sz/Z
         bUQCezLgHqpdA==
Received: by mercury (Postfix, from userid 1000)
        id 849521066F9F; Mon,  8 May 2023 08:50:14 +0200 (CEST)
Date:   Mon, 8 May 2023 08:50:14 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v4 5/8] power: supply: rt5033_charger: Add RT5033 charger
 device driver
Message-ID: <20230508065014.xfftu6vorxgqdh7h@mercury.elektranox.org>
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-6-jahau@rocketmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hdnjxeig33un4pfn"
Content-Disposition: inline
In-Reply-To: <20230506155435.3005-6-jahau@rocketmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


--hdnjxeig33un4pfn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, May 06, 2023 at 05:54:32PM +0200, Jakob Hauser wrote:
> This patch adds device driver of Richtek RT5033 PMIC. The driver supports
> switching charger. rt5033 charger provides three charging modes. The char=
ging
> modes are pre-charge mode, fast charge mode and constant voltage mode. Th=
ey
> vary in charge rate, the charge parameters can be controlled by i2c inter=
face.
>=20
> Cc: Beomho Seo <beomho.seo@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Driver looks mostly good. I still found a couple of small things
though. Please find them inline.

>  drivers/power/supply/Kconfig          |   8 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/rt5033_charger.c | 464 ++++++++++++++++++++++++++
>  3 files changed, 473 insertions(+)
>  create mode 100644 drivers/power/supply/rt5033_charger.c
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index c78be9f322e6..ea11797670ca 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -766,6 +766,14 @@ config BATTERY_RT5033
>  	  The fuelgauge calculates and determines the battery state of charge
>  	  according to battery open circuit voltage.
> =20
> +config CHARGER_RT5033
> +	tristate "RT5033 battery charger support"
> +	depends on MFD_RT5033
> +	help
> +	  This adds support for battery charger in Richtek RT5033 PMIC.
> +	  The device supports pre-charge mode, fast charge mode and
> +	  constant voltage mode.
> +
>  config CHARGER_RT9455
>  	tristate "Richtek RT9455 battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4adbfba02d05..dfc624bbcf1d 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -54,6 +54,7 @@ obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
>  obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
>  obj-$(CONFIG_BATTERY_MAX1721X)	+=3D max1721x_battery.o
>  obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
> +obj-$(CONFIG_CHARGER_RT5033)	+=3D rt5033_charger.o
>  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
>  obj-$(CONFIG_CHARGER_RT9467)	+=3D rt9467-charger.o
>  obj-$(CONFIG_CHARGER_RT9471)	+=3D rt9471.o
> diff --git a/drivers/power/supply/rt5033_charger.c b/drivers/power/supply=
/rt5033_charger.c
> new file mode 100644
> index 000000000000..038530d2f0a0
> --- /dev/null
> +++ b/drivers/power/supply/rt5033_charger.c
> @@ -0,0 +1,464 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Battery charger driver for RT5033
> + *
> + * Copyright (C) 2014 Samsung Electronics, Co., Ltd.
> + * Author: Beomho Seo <beomho.seo@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */

no need for the GPL2 text with SPDX license header

> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/mfd/rt5033-private.h>
> +#include <linux/mfd/rt5033.h>
> +
> +static int rt5033_get_charger_state(struct rt5033_charger *charger)
> +{
> +	struct regmap *regmap =3D charger->rt5033->regmap;
> +	unsigned int reg_data;
> +	int state;
> +
> +	if (!regmap)
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	regmap_read(regmap, RT5033_REG_CHG_STAT, &reg_data);
> +
> +	switch (reg_data & RT5033_CHG_STAT_MASK) {
> +	case RT5033_CHG_STAT_DISCHARGING:
> +		state =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	case RT5033_CHG_STAT_CHARGING:
> +		state =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case RT5033_CHG_STAT_FULL:
> +		state =3D POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case RT5033_CHG_STAT_NOT_CHARGING:
> +		state =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	default:
> +		state =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	}
> +
> +	return state;
> +}
> +
> +static int rt5033_get_charger_type(struct rt5033_charger *charger)
> +{
> +	struct regmap *regmap =3D charger->rt5033->regmap;
> +	unsigned int reg_data;
> +	int state;
> +
> +	regmap_read(regmap, RT5033_REG_CHG_STAT, &reg_data);
> +
> +	switch (reg_data & RT5033_CHG_STAT_TYPE_MASK) {
> +	case RT5033_CHG_STAT_TYPE_FAST:
> +		state =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	case RT5033_CHG_STAT_TYPE_PRE:
> +		state =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	default:
> +		state =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +	}
> +
> +	return state;
> +}
> +
> +static int rt5033_get_charger_current_limit(struct rt5033_charger *charg=
er)
> +{
> +	struct regmap *regmap =3D charger->rt5033->regmap;
> +	unsigned int state, reg_data, data;
> +
> +	regmap_read(regmap, RT5033_REG_CHG_CTRL5, &reg_data);
> +
> +	state =3D (reg_data & RT5033_CHGCTRL5_ICHG_MASK)
> +		 >> RT5033_CHGCTRL5_ICHG_SHIFT;
> +
> +	data =3D RT5033_CHARGER_FAST_CURRENT_MIN +
> +		RT5033_CHARGER_FAST_CURRENT_STEP_NUM * state;
> +
> +	return data;
> +}
> +
> +static int rt5033_get_charger_const_voltage(struct rt5033_charger *charg=
er)
> +{
> +	struct regmap *regmap =3D charger->rt5033->regmap;
> +	unsigned int state, reg_data, data;
> +
> +	regmap_read(regmap, RT5033_REG_CHG_CTRL2, &reg_data);
> +
> +	state =3D (reg_data & RT5033_CHGCTRL2_CV_MASK)
> +		 >> RT5033_CHGCTRL2_CV_SHIFT;
> +
> +	data =3D RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN +
> +		RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM * state;
> +
> +	return data;
> +}
> +
> +static inline int rt5033_init_const_charge(struct rt5033_charger *charge=
r)
> +{
> +	struct rt5033_charger_data *chg =3D charger->chg;
> +	int ret;
> +	unsigned int val;
> +	u8 reg_data;
> +
> +	/* Set constant voltage mode */
> +	if (chg->const_uvolt < RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN ||
> +	    chg->const_uvolt > RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX) {
> +		dev_err(charger->dev,
> +			"Value 'constant-charge-voltage-max-microvolt' out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (chg->const_uvolt =3D=3D RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN)
> +		reg_data =3D 0x00;
> +	else if (chg->const_uvolt =3D=3D RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MAX)
> +		reg_data =3D RT5033_CV_MAX_VOLTAGE;
> +	else {
> +		val =3D chg->const_uvolt;
> +		val -=3D RT5033_CHARGER_CONST_VOLTAGE_LIMIT_MIN;
> +		val /=3D RT5033_CHARGER_CONST_VOLTAGE_STEP_NUM;
> +		reg_data =3D val;
> +	}
> +
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
2,
> +			RT5033_CHGCTRL2_CV_MASK,
> +			reg_data << RT5033_CHGCTRL2_CV_SHIFT);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed regmap update\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set end of charge current */
> +	if (chg->eoc_uamp < RT5033_CHARGER_EOC_MIN ||
> +	    chg->eoc_uamp > RT5033_CHARGER_EOC_MAX) {
> +		dev_err(charger->dev,
> +			"Value 'charge-term-current-microamp' out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (chg->eoc_uamp =3D=3D RT5033_CHARGER_EOC_MIN)
> +		reg_data =3D 0x01;
> +	else if (chg->eoc_uamp =3D=3D RT5033_CHARGER_EOC_MAX)
> +		reg_data =3D 0x07;
> +	else {
> +		val =3D chg->eoc_uamp;
> +		if (val < RT5033_CHARGER_EOC_REF) {
> +			val -=3D RT5033_CHARGER_EOC_MIN;
> +			val /=3D RT5033_CHARGER_EOC_STEP_NUM1;
> +			reg_data =3D 0x01 + val;
> +		} else if (val > RT5033_CHARGER_EOC_REF) {
> +			val -=3D RT5033_CHARGER_EOC_REF;
> +			val /=3D RT5033_CHARGER_EOC_STEP_NUM2;
> +			reg_data =3D 0x04 + val;
> +		} else {
> +			reg_data =3D 0x04;
> +		}
> +	}
> +
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
4,
> +			RT5033_CHGCTRL4_EOC_MASK, reg_data);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed regmap update\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int rt5033_init_fast_charge(struct rt5033_charger *charger)
> +{
> +	struct rt5033_charger_data *chg =3D charger->chg;
> +	int ret;
> +	unsigned int val;
> +	u8 reg_data;
> +
> +	/* Set limit input current */
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
1,
> +			RT5033_CHGCTRL1_IAICR_MASK, RT5033_AICR_2000_MODE);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed regmap update\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set fast-charge mode charging current */
> +	if (chg->fast_uamp < RT5033_CHARGER_FAST_CURRENT_MIN ||
> +	    chg->fast_uamp > RT5033_CHARGER_FAST_CURRENT_MAX) {
> +		dev_err(charger->dev,
> +			"Value 'constant-charge-current-max-microamp' out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (chg->fast_uamp =3D=3D RT5033_CHARGER_FAST_CURRENT_MIN)
> +		reg_data =3D 0x00;
> +	else if (chg->fast_uamp =3D=3D RT5033_CHARGER_FAST_CURRENT_MAX)
> +		reg_data =3D RT5033_CHG_MAX_CURRENT;
> +	else {
> +		val =3D chg->fast_uamp;
> +		val -=3D RT5033_CHARGER_FAST_CURRENT_MIN;
> +		val /=3D RT5033_CHARGER_FAST_CURRENT_STEP_NUM;
> +		reg_data =3D val;
> +	}
> +
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
5,
> +			RT5033_CHGCTRL5_ICHG_MASK,
> +			reg_data << RT5033_CHGCTRL5_ICHG_SHIFT);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed regmap update\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int rt5033_init_pre_charge(struct rt5033_charger *charger)
> +{
> +	struct rt5033_charger_data *chg =3D charger->chg;
> +	int ret;
> +	unsigned int val;
> +	u8 reg_data;
> +
> +	/* Set pre-charge threshold voltage */
> +	if (chg->pre_uvolt < RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN ||
> +	    chg->pre_uvolt > RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MAX) {
> +		dev_err(charger->dev,
> +			"Value 'precharge-upper-limit-microvolt' out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (chg->pre_uvolt =3D=3D RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN)
> +		reg_data =3D 0x00;
> +	else if (chg->pre_uvolt =3D=3D RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MAX)
> +		reg_data =3D 0x0f;
> +	else {
> +		val =3D chg->pre_uvolt;
> +		val -=3D RT5033_CHARGER_PRE_THRESHOLD_LIMIT_MIN;
> +		val /=3D RT5033_CHARGER_PRE_THRESHOLD_STEP_NUM;
> +		reg_data =3D val;
> +	}
> +
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
5,
> +			RT5033_CHGCTRL5_VPREC_MASK, reg_data);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed regmap update\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Set pre-charge mode charging current */
> +	if (chg->pre_uamp < RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN ||
> +	    chg->pre_uamp > RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX) {
> +		dev_err(charger->dev,
> +			"Value 'precharge-current-microamp' out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (chg->pre_uamp =3D=3D RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN)
> +		reg_data =3D 0x00;
> +	else if (chg->pre_uamp =3D=3D RT5033_CHARGER_PRE_CURRENT_LIMIT_MAX)
> +		reg_data =3D RT5033_CHG_MAX_PRE_CURRENT;
> +	else {
> +		val =3D chg->pre_uamp;
> +		val -=3D RT5033_CHARGER_PRE_CURRENT_LIMIT_MIN;
> +		val /=3D RT5033_CHARGER_PRE_CURRENT_STEP_NUM;
> +		reg_data =3D val;
> +	}
> +
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
4,
> +			RT5033_CHGCTRL4_IPREC_MASK,
> +			reg_data << RT5033_CHGCTRL4_IPREC_SHIFT);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed regmap update\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rt5033_charger_reg_init(struct rt5033_charger *charger)
> +{
> +	int ret =3D 0;
> +
> +	/* Enable charging termination */
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
1,
> +			RT5033_CHGCTRL1_TE_EN_MASK, RT5033_TE_ENABLE);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to enable charging termination.\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Disable minimum input voltage regulation (MIVR), this improves
> +	 * the charging performance.
> +	 */
> +	ret =3D regmap_update_bits(charger->rt5033->regmap, RT5033_REG_CHG_CTRL=
4,
> +			RT5033_CHGCTRL4_MIVR_MASK, RT5033_CHARGER_MIVR_DISABLE);
> +	if (ret) {
> +		dev_err(charger->dev, "Failed to disable MIVR.\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D rt5033_init_pre_charge(charger);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rt5033_init_fast_charge(charger);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D rt5033_init_const_charge(charger);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static enum power_supply_property rt5033_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static int rt5033_charger_get_property(struct power_supply *psy,
> +			enum power_supply_property psp,
> +			union power_supply_propval *val)
> +{
> +	struct rt5033_charger *charger =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;

ret is unused.

> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D rt5033_get_charger_state(charger);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		val->intval =3D rt5033_get_charger_type(charger);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval =3D rt5033_get_charger_current_limit(charger);
> +		break;
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		val->intval =3D rt5033_get_charger_const_voltage(charger);
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D RT5033_CHARGER_MODEL;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D RT5033_MANUFACTURER;
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D (rt5033_get_charger_state(charger) =3D=3D
> +				POWER_SUPPLY_STATUS_CHARGING);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct rt5033_charger_data *rt5033_charger_dt_init(
> +						struct rt5033_charger *charger)
> +{
> +	struct rt5033_charger_data *chg;
> +	struct power_supply_battery_info *info;
> +	int ret;
> +
> +	chg =3D devm_kzalloc(charger->dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret =3D power_supply_get_battery_info(charger->psy, &info);
> +	if (ret) {
> +		dev_err(charger->dev, "failed to get battery info\n");
> +		return ERR_PTR(-EINVAL);
> +	}

You can use the battery_info from the power-supply core:

info =3D charger->psy->battery_info;
if (!info)
    return dev_err_probe(charger->dev, -EINVAL, "missing battery info\n");

> +	/* Assign data. Validity will be checked in the init functions. */
> +	chg->pre_uamp =3D info->precharge_current_ua;
> +	chg->fast_uamp =3D info->constant_charge_current_max_ua;
> +	chg->eoc_uamp =3D info->charge_term_current_ua;
> +	chg->pre_uvolt =3D info->precharge_voltage_max_uv;
> +	chg->const_uvolt =3D info->constant_charge_voltage_max_uv;
> +
> +	return chg;
> +}
> +
> +static const struct power_supply_desc rt5033_charger_desc =3D {
> +	.name =3D "rt5033-charger",
> +	.type =3D POWER_SUPPLY_TYPE_USB,
> +	.properties =3D rt5033_charger_props,
> +	.num_properties =3D ARRAY_SIZE(rt5033_charger_props),
> +	.get_property =3D rt5033_charger_get_property,
> +};
> +
> +static int rt5033_charger_probe(struct platform_device *pdev)
> +{
> +	struct rt5033_charger *charger;
> +	struct rt5033_dev *rt5033 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg =3D {};
> +	int ret;
> +
> +	charger =3D devm_kzalloc(&pdev->dev, sizeof(*charger), GFP_KERNEL);
> +	if (!charger)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, charger);
> +	charger->dev =3D &pdev->dev;
> +	charger->rt5033 =3D rt5033;

You are only using the regmap, so just get and store that:

charger->regmap =3D dev_get_regmap(pdev->dev.parent);

> +	psy_cfg.of_node =3D pdev->dev.of_node;
> +	psy_cfg.drv_data =3D charger;
> +
> +	charger->psy =3D devm_power_supply_register(&pdev->dev,
> +						  &rt5033_charger_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(charger->psy)) {
> +		dev_err(&pdev->dev, "failed: power supply register\n");
> +		return PTR_ERR(charger->psy);
> +	}

dev_err_probe()

> +
> +	charger->chg =3D rt5033_charger_dt_init(charger);
> +	if (IS_ERR_OR_NULL(charger->chg))
> +		return -ENODEV;
> +
> +	ret =3D rt5033_charger_reg_init(charger);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id rt5033_charger_id[] =3D {
> +	{ "rt5033-charger", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(platform, rt5033_charger_id);
> +
> +static const struct of_device_id rt5033_charger_of_match[] =3D {
> +	{ .compatible =3D "richtek,rt5033-charger", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, rt5033_charger_of_match);
> +
> +static struct platform_driver rt5033_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "rt5033-charger",
> +		.of_match_table =3D rt5033_charger_of_match,
> +	},
> +	.probe =3D rt5033_charger_probe,
> +	.id_table =3D rt5033_charger_id,
> +};
> +module_platform_driver(rt5033_charger_driver);
> +
> +MODULE_DESCRIPTION("Richtek RT5033 charger driver");
> +MODULE_AUTHOR("Beomho Seo <beomho.seo@samsung.com>");
> +MODULE_LICENSE("GPL v2");

Thanks,

-- Sebastian

--hdnjxeig33un4pfn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRYm6IACgkQ2O7X88g7
+ppMYRAAoFVscs+pEDAHGSAZQs7bJpD+2RrGaRAkOcCmWDSN6pvXtOGseCNt/OrS
L5LfGiERKM6qEzW5nfkFS1LNiWjZgah/THWJqZ/OUlWlZtt5WNyhaRi5g8YF3fIK
YDchUq1zF+sbid/hCBbjmn8x5B/yd8lYHLOLnwVutbSRjfPum4e/1ShnqcYzEK/B
FmH2b/VUYjXIeEvfr9RaPRKxCJGR3oyQXvFAcMvI5TvRNPw/J6UttbGgHTAXvAmM
5ZO9fa5MHzb1j1J8vXplYP7VgywsFucZAZlkD8Yoo/wT3Av9xhaI22WTpR5+MGTn
k/Gn7TInqxWgKvfXkS+n4yiO7zJQj9JJG9EWTvdJwZNzy2gaPYneFFvBOBSmGzQr
E15z4Xj3cXb+28ZlprnwBZNACsoO/mCg3llba5YrBni2YV1QWWzml/oxy2pzaHpw
iKPNXrlNpCVCUt3l1/0KdAIKGf5QMqw/7bPNb7APwNfl1kOTog4hxpPepmyGrYPu
3RbGk5NypY28cTr3YF72esPTcIiAt/ivhK+3DIkgfw02kNuQ8mBdVAZG9PnDCqxn
27S1wievSQ11IILA5qpW63UQbXK8J8py91r8aJ/559taUoLaSRU8Nuf6bDxpq3WT
f62UxYl+jm2OOfyR/4M14r6yfGqvhw7ArqEtWEXuIC3LhUKKDAI=
=CS5o
-----END PGP SIGNATURE-----

--hdnjxeig33un4pfn--
