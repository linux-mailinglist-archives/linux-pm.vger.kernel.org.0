Return-Path: <linux-pm+bounces-41664-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ODrNS2/emnw+AEAu9opvQ
	(envelope-from <linux-pm+bounces-41664-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 03:00:13 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D1DAAF7F
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 03:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3674B30059A6
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 02:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A442DCBFA;
	Thu, 29 Jan 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ghruuMaT"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF1932939A;
	Thu, 29 Jan 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769652006; cv=pass; b=HYrNXaREox9Ef1nHE1V2wDSjWGBW5KVR/geHdM8Kn3uHuPCCyG9+k8ReMzl+38EbRwy6IZgPwhnHUMgl4rbkx7sSoSotm9djex2lNEYXPo557mEia7Irw21y/rNma6Ne192ingt0yzzH44LYPiacnFDJIi5U86iiJnGurZe0sW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769652006; c=relaxed/simple;
	bh=dNEMvvA7Po74dPo+VkXMBYfoEJKz7EwcUzE1RrpHAmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxEUYNUZd7z+LjvuGpyfYhAMxhJevifpXIGjatOWx+ITGRLA6xJrC0rzAzlUoQ3YPxoJAdOZlVTdtwwiOSDuwyQmCtgg2oAvWQ+TjjQnhMVnN8jL0OdLumzeU+n8/GbTlP0gzlrsrSUuza13P3Mlvi85nITR1aAA+Wps/2Z6qNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ghruuMaT; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1769651984; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gfhdkELQ+r9VRoig5g3ceCRoO1KM5yCJmcdLfFEmlesal5zAlHZzEuahO0j9+2GrMmgb7SajG/OKuFFtYPb35h09xsS+Lbih0iesuTxP9HeNkUUgQHYOAHixk3T7pyKdjR6x5RK99QGKRoTtdgnOr40SaoaeM0Sbo0nltWTklb8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769651984; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=T3aKX84kGxI1xxaoYSc/3afEikkxjamWfp3cnXS6LCk=; 
	b=CcM7ghj+dKBRdqKOF2CNoG/agmkPmj+s7IVPUzOU9Xm6u0NK1RrLBKHr5mMmGfAuaOc0tlhWl7GFZHqNl2IJopqTjTtxxmVCCxLbEYUQcfMSp4sjrmcBv72x7niaRAwuPgerZ3bjzoa/rV8uORRyY5jAqbBWRyOTbxFCa8+ma2o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769651984;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=T3aKX84kGxI1xxaoYSc/3afEikkxjamWfp3cnXS6LCk=;
	b=ghruuMaTCTutArmV7+GMqjzzbh85cW0vDGhdzK7XuFEUNJ+9MEO+V6iA9DObp7rB
	8VKaDuIbz26pI/WimZTSHuKDlw050W1CiKCbLqJiX2jMiJZwfsy2/Sz2qtQogv/8+q6
	BCo0xgtObeWNMfkxuqgnv9txqDWCzAE5yMW20ChE=
Received: by mx.zohomail.com with SMTPS id 176965198298465.12795747038842;
	Wed, 28 Jan 2026 17:59:42 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id 7941818060F; Thu, 29 Jan 2026 02:59:39 +0100 (CET)
Date: Thu, 29 Jan 2026 02:59:39 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] power: supply: add support for S2MU005 battery fuel
 gauge device
Message-ID: <aXq7NohfIy3c5AWL@venus>
References: <20260126-s2mu005-fuelgauge-v1-0-68a146ed0819@disroot.org>
 <20260126-s2mu005-fuelgauge-v1-2-68a146ed0819@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rsep7zu3ekqtwnyl"
Content-Disposition: inline
In-Reply-To: <20260126-s2mu005-fuelgauge-v1-2-68a146ed0819@disroot.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/269.648.70
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41664-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:email,collabora.com:dkim]
X-Rspamd-Queue-Id: 78D1DAAF7F
X-Rspamd-Action: no action


--rsep7zu3ekqtwnyl
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] power: supply: add support for S2MU005 battery fuel
 gauge device
MIME-Version: 1.0

Hi,

On Mon, Jan 26, 2026 at 09:09:49PM +0530, Kaustabh Chakraborty wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>=20
> Samsung's S2MU005 PMIC, which contains battery charger functionality
> also includes a battery fuel gauge device, which is separate from the
> PMIC itself, and typically connected to an I2C bus. Add a generic driver
> to support said device.
>=20
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Co-developed-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  drivers/power/supply/Kconfig           |   9 ++
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/s2mu005-battery.c | 234 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 244 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 92f9f7aae92f2..a5777309b1f62 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -229,6 +229,15 @@ config BATTERY_SAMSUNG_SDI
>  	  Say Y to enable support for Samsung SDI battery data.
>  	  These batteries are used in Samsung mobile phones.
> =20
> +config BATTERY_S2MU005
> +	tristate "Samsung S2MU005 PMIC fuel gauge driver"
> +	help
> +	  Say Y to enable support for the Samsung S2MU005 PMIC integrated
> +	  fuel gauge, which works indepenently of the PMIC battery charger
> +	  counterpart, and reports battery metrics.
> +
> +	  This driver, if built as a module, will be called s2mu005-fuel-gauge.
> +
>  config BATTERY_COLLIE
>  	tristate "Sharp SL-5500 (collie) battery"
>  	depends on SA1100_COLLIE && MCP_UCB1200
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4b79d5abc49a7..cd061887c1727 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_BATTERY_PMU)	+=3D pmu_battery.o
>  obj-$(CONFIG_BATTERY_QCOM_BATTMGR)	+=3D qcom_battmgr.o
>  obj-$(CONFIG_BATTERY_OLPC)	+=3D olpc_battery.o
>  obj-$(CONFIG_BATTERY_SAMSUNG_SDI)	+=3D samsung-sdi-battery.o
> +obj-$(CONFIG_BATTERY_S2MU005)	+=3D s2mu005-battery.o
>  obj-$(CONFIG_BATTERY_COLLIE)	+=3D collie_battery.o
>  obj-$(CONFIG_BATTERY_INGENIC)	+=3D ingenic-battery.o
>  obj-$(CONFIG_BATTERY_INTEL_DC_TI) +=3D intel_dc_ti_battery.o
> diff --git a/drivers/power/supply/s2mu005-battery.c b/drivers/power/suppl=
y/s2mu005-battery.c
> new file mode 100644
> index 0000000000000..914308e82683b
> --- /dev/null
> +++ b/drivers/power/supply/s2mu005-battery.c
> @@ -0,0 +1,234 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Battery Fuel Gauge Driver for Samsung S2MU005 PMIC.
> + *
> + * Copyright (C) 2015 Samsung Electronics
> + * Copyright (C) 2023 Yassine Oudjana <y.oudjana@protonmail.com>
> + * Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/of.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#define S2MU005_FG_REG_STATUS		0x00
> +#define S2MU005_FG_REG_IRQ		0x02
> +#define S2MU005_FG_REG_RVBAT		0x04
> +#define S2MU005_FG_REG_RCUR_CC		0x06
> +#define S2MU005_FG_REG_RSOC		0x08
> +#define S2MU005_FG_REG_MONOUT		0x0a
> +#define S2MU005_FG_REG_MONOUT_SEL	0x0c
> +#define S2MU005_FG_REG_RBATCAP		0x0e
> +#define S2MU005_FG_REG_RZADJ		0x12
> +#define S2MU005_FG_REG_RBATZ0		0x16
> +#define S2MU005_FG_REG_RBATZ1		0x18
> +#define S2MU005_FG_REG_IRQ_LVL		0x1a
> +#define S2MU005_FG_REG_START		0x1e
> +
> +struct s2mu005_fg {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct power_supply *psy;
> +};
> +
> +static const struct regmap_config s2mu005_fg_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +};

Looks like all register addresses are 2 byte aligned and you are
always using regmap_raw_read to get 16bit values. So just use
=2Eval_bits =3D 16 here?

> +static irqreturn_t s2mu005_handle_irq(int irq, void *data)
> +{
> +	struct s2mu005_fg *priv =3D data;
> +
> +	msleep(100);
> +	power_supply_changed(priv->psy);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int s2mu005_fg_get_voltage_now(struct s2mu005_fg *priv, int *valu=
e)
> +{
> +	struct regmap *regmap =3D priv->regmap;
> +	u16 reg;
> +	int ret;
> +
> +	ret =3D regmap_raw_read(regmap, S2MU005_FG_REG_RVBAT, &reg, sizeof(reg)=
);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read voltage register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*value =3D ((unsigned long)reg * 1000000) >> 13; /* uV */
> +
> +	return 0;
> +}
> +
> +static int s2mu005_fg_get_current_now(struct s2mu005_fg *priv, int *valu=
e)
> +{
> +	struct regmap *regmap =3D priv->regmap;
> +	s16 reg;
> +	int ret;
> +
> +	ret =3D regmap_raw_read(regmap, S2MU005_FG_REG_RCUR_CC, &reg, sizeof(re=
g));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*value =3D -((long)reg * 1000000) >> 12; /* uA */
> +
> +	return 0;
> +}
> +
> +static int s2mu005_fg_get_capacity(struct s2mu005_fg *priv, int *value)
> +{
> +	struct regmap *regmap =3D priv->regmap;
> +	s16 reg;
> +	int ret;
> +
> +	ret =3D regmap_raw_read(regmap, S2MU005_FG_REG_RSOC, &reg, sizeof(reg));
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read capacity register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*value =3D (reg * 100) >> 14; /* percentage */
> +
> +	return 0;
> +}
> +
> +static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value)
> +{
> +	int current_now;
> +	int capacity;
> +	int ret;
> +
> +	ret =3D s2mu005_fg_get_current_now(priv, &current_now);
> +	if (ret)
> +		return ret;
> +
> +	if (current_now <=3D 0) {
> +		*value =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		return 0;
> +	}
> +
> +	ret =3D s2mu005_fg_get_capacity(priv, &capacity);
> +	if (ret)
> +		return ret;
> +
> +	if (capacity < 90)
> +		*value =3D POWER_SUPPLY_STATUS_CHARGING;
> +	else
> +		*value =3D POWER_SUPPLY_STATUS_FULL;

Usually there is some kind of hysteresis that stops charging
when the battery is full and then restarts charging once the
battery drops under a certain capacity. As this code first
checks the current to determine if the battery is discharging
and only then checks if the battery is full - does your code
toggle between FULL and DISCHARGING?

> +	return 0;
> +}
> +
> +static const enum power_supply_property s2mu005_fg_properties[] =3D {
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_STATUS,
> +};
> +
> +static int s2mu005_fg_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	struct s2mu005_fg *priv =3D power_supply_get_drvdata(psy);
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D s2mu005_fg_get_voltage_now(priv, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D s2mu005_fg_get_current_now(priv, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D s2mu005_fg_get_capacity(priv, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D s2mu005_fg_get_status(priv, &val->intval);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct power_supply_desc s2mu005_fg_desc =3D {
> +	.name =3D "s2mu005-fuel-gauge",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D s2mu005_fg_properties,
> +	.num_properties =3D ARRAY_SIZE(s2mu005_fg_properties),
> +	.get_property =3D s2mu005_fg_get_property,
> +};
> +
> +static int s2mu005_fg_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct s2mu005_fg *priv;
> +	struct power_supply_config psy_cfg =3D {};
> +	const struct power_supply_desc *psy_desc;
> +	int flags;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "failed to allocate driver private\n");

Do not print error messages for -ENOMEM.

> +
> +	dev_set_drvdata(dev, priv);
> +	priv->dev =3D dev;
> +
> +	priv->regmap =3D devm_regmap_init_i2c(client, &s2mu005_fg_regmap_config=
);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "failed to initialize regmap\n");
> +
> +	psy_desc =3D device_get_match_data(dev);
> +
> +	psy_cfg.drv_data =3D priv;
> +	priv->psy =3D devm_power_supply_register(priv->dev, psy_desc, &psy_cfg);
> +	if (IS_ERR(priv->psy))
> +		return dev_err_probe(dev, PTR_ERR(priv->psy),
> +				     "failed to register power supply subsystem\n");
> +
> +	flags =3D irq_get_trigger_type(client->irq);

This is not needed. By not specifying the trigger type the irq core
code will do this internally.

> +	ret =3D devm_request_threaded_irq(priv->dev, client->irq, NULL,
> +					s2mu005_handle_irq, IRQF_ONESHOT | flags,
> +					psy_desc->name, priv);
> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to request IRQ\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id s2mu005_fg_of_match_table[] =3D {
> +	{
> +		.compatible =3D "samsung,s2mu005-fuel-gauge",
> +		.data =3D &s2mu005_fg_desc,
> +	}, { },

Please put the terminator into its own line and remove the final ,

> +};
> +MODULE_DEVICE_TABLE(of, s2mu005_fg_of_match_table);
> +
> +static struct i2c_driver s2mu005_fg_i2c_driver =3D {
> +	.probe =3D s2mu005_fg_i2c_probe,
> +	.driver =3D {
> +		.name =3D "s2mu005-fuel-gauge",
> +		.of_match_table =3D of_match_ptr(s2mu005_fg_of_match_table),

Remove of_match_ptr().

> +	},
> +};
> +module_i2c_driver(s2mu005_fg_i2c_driver);
> +
> +MODULE_DESCRIPTION("Samsung S2MU005 PMIC Battery Fuel Gauge Driver");
> +MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
> +MODULE_AUTHOR("Kaustabh Chakraborty <kauschluss@disroot.org>");
> +MODULE_LICENSE("GPL");

Greetings,

-- Sebastian

--rsep7zu3ekqtwnyl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAml6vwgACgkQ2O7X88g7
+pouihAAktRDxmuZDyU1KNjt+7R10pBlcDIt4VaeEpTIBgCp9WlUTREwAQUim1bd
UnFkjQOzXdQO6HqrEsu0AuUjyPfzXG8xmL63G1RMMZsd9fD2V3QaSNBSRFsUIW8Y
dtE1B2PmNz1y3dS7Enbao7T5LaFQ6/dgnkchDlTK6nQv6ThcPM353eQXkmYeG7Ji
w80MGlMp3gUwMUwK8Gw/+kacDMgl7d0UicRCFmZsmbjJRkwjvVTmOYq91xK0O+tL
6oE8vrxQJL6lk3kvy84DdNa6ZgYpJM326VMOgxlJhRhj2Lv4euQ5rUiKGRqTKV3C
5jfuq/ZvBIjSlgKjHKGOvTaIyTMEhWf/WSL9HpH9pDEsDBhtjBdtv1WDTWfC4ROa
cZ5NWZdDwVDxefEq/UTDcox3XJxqqu0Kl8vUkzgIxhuMgsqDgXbymjxef6j5hDpp
ly7O3RZegax+wtp6GpZ3Zl+cqc9D87gXtSYQEt3fDjnRM5DYzhqXlNPWSAVA8wvh
3F6C6yHQu2M+CmwU3mwhhFrWTifS8Jw7MRNKvEn/QMxseL8IgUI+iXT5fgnYYeKT
kvVZRHJq2+PyH+/Mbx98BPNNavpujDF8l7svQSkZXt9SLVBrhLLtF0YERHcHwByI
qG4Hg3+naim9hO0rVYevAsRcWlMJ0y+RipOAW7FCh7cQQGsxHlA=
=BtkD
-----END PGP SIGNATURE-----

--rsep7zu3ekqtwnyl--

