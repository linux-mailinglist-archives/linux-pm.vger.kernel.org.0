Return-Path: <linux-pm+bounces-43463-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL+BKR8gpmkuKwAAu9opvQ
	(envelope-from <linux-pm+bounces-43463-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:41:19 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E31E6BCC
	for <lists+linux-pm@lfdr.de>; Tue, 03 Mar 2026 00:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42C9F304564E
	for <lists+linux-pm@lfdr.de>; Mon,  2 Mar 2026 23:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D471533F37F;
	Mon,  2 Mar 2026 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="ImBPrBGU"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AD33E34B;
	Mon,  2 Mar 2026 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772494870; cv=pass; b=Yz7DCCBQ7P1DbZFT4gWHRmW/qtBUU8Mh2nQnAPu+WZvLFfK8JYXyAj8oZ/E/bvCydREVZDNy1Om3csvS9NNeadGRVG4PUzm+wiV7j717PWsdZ7YkEQBatL/0hkgHQMoeFlU4azM4kyVZP4vRw4rg+8SBzwPA0ytgvDRaB52kECw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772494870; c=relaxed/simple;
	bh=X2MS23gwXVLH9/fmxXaZZ6WDt7fI4QFWMizV5e6ZNEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3f+NEGZEs00k1YI9ksjSGkzCaHIyCDhY97Rf/cEnC4TiwceeiJmClAIHIEvbKIJA5RL6GJZv/M6mFAP0UzJh3UlDlgYFbtgNAinpeFXA62A9pzfc3qRezzPZFdpOkc3kXDoBOW//wHbHxf8PAtbJ4sqbWjqu3r17ppUdg+h3HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=ImBPrBGU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1772494862; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gCQz5YubUD+EC94cOlmBq0qBgPUZfuLn/hA0vURekxpGclVZTiUlxp38zPJuBAHyGhceQIpU5LbVvmM3kz3O83ZlVZXXuFePHUQ9K85+IkthFg4Io26GLXejF4BQ670H/8E/v/TJwal4zLKngs9vb4LsrKvJtXkVFCbf/u9ZYwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772494862; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PRCIpEq8bIJVGBUfbPMaIa/HoF+ivGzBYmmgXauUqTg=; 
	b=DhKFpYlN3m5bJXF1PmoBD4erEk9+6/GRW3uM9Ozigo83TwXdcXfLIxflp6n6g7qxiZ2r2Luw61XcFoi15WKrZDq9Z+IkJ6SSpJykTdBWUp0B6MhzlF8N98Y6tcvAqaPqCbuXXfE7FAA3hguQ6nP/pIIUif9hkO8lMDraM4npBO8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772494862;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=PRCIpEq8bIJVGBUfbPMaIa/HoF+ivGzBYmmgXauUqTg=;
	b=ImBPrBGUeY2qkTJTtqrgxPTBysJM0bA71pN4/vKvGyV3dC4Qre4bZIlgnWFtiSqU
	BGmOQStuwlz9jd1ZNYSCv+d3vVF+++C65posOhyfsRATyVx8lrwF5EPUqlxnYzMpkiM
	BDfFTLBubzyaLmwlIA6rAY7oqsOlwr37UeHD3jhs=
Received: by mx.zohomail.com with SMTPS id 1772494860931163.0418973643566;
	Mon, 2 Mar 2026 15:41:00 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id BF075180D07; Tue, 03 Mar 2026 00:40:56 +0100 (CET)
Date: Tue, 3 Mar 2026 00:40:56 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] power: supply: add support for S2MU005 battery
 fuel gauge device
Message-ID: <aaYcJLp8c0MuntYG@venus>
References: <20260208-s2mu005-fuelgauge-v2-0-be3af8969291@disroot.org>
 <20260208-s2mu005-fuelgauge-v2-2-be3af8969291@disroot.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ka2np5qq7d5vxwcu"
Content-Disposition: inline
In-Reply-To: <20260208-s2mu005-fuelgauge-v2-2-be3af8969291@disroot.org>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.1.1.4.3/272.480.55
X-ZohoMailClient: External
X-Rspamd-Queue-Id: 4B1E31E6BCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[collabora.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[collabora.com:s=zohomail];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[protonmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-43463-lists,linux-pm=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[collabora.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebastian.reichel@collabora.com,linux-pm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pm,dt];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,collabora.com:dkim,protonmail.com:email]
X-Rspamd-Action: no action


--ka2np5qq7d5vxwcu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] power: supply: add support for S2MU005 battery
 fuel gauge device
MIME-Version: 1.0

Hi,

On Sun, Feb 08, 2026 at 11:22:31PM +0530, Kaustabh Chakraborty wrote:
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
>  drivers/power/supply/Kconfig           |   9 +
>  drivers/power/supply/Makefile          |   1 +
>  drivers/power/supply/s2mu005-battery.c | 306 +++++++++++++++++++++++++++=
++++++
>  3 files changed, 316 insertions(+)
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

This is missing some dependencies, which will trigger build issues
with random config:

	depends on I2C
	select REGMAP_I2C

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
> index 0000000000000..f0e414407d3b5
> --- /dev/null
> +++ b/drivers/power/supply/s2mu005-battery.c
> @@ -0,0 +1,306 @@
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

why?

> +#include <linux/mutex.h>
> +#include <linux/of.h>

unused. You only use of_device_id from <include/linux/mod_devicetable.h>

> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +#include <linux/units.h>
> +
> +#define S2MU005_FG_REG_STATUS		0x00
> +#define S2MU005_FG_REG_IRQ		0x02
> +#define S2MU005_FG_REG_RVBAT		0x04
> +#define S2MU005_FG_REG_RCURCC		0x06
> +#define S2MU005_FG_REG_RSOC		0x08
> +#define S2MU005_FG_REG_MONOUT		0x0a
> +#define S2MU005_FG_REG_MONOUTSEL	0x0c
> +#define S2MU005_FG_REG_RBATCAP		0x0e
> +#define S2MU005_FG_REG_RZADJ		0x12
> +#define S2MU005_FG_REG_RBATZ0		0x16
> +#define S2MU005_FG_REG_RBATZ1		0x18
> +#define S2MU005_FG_REG_IRQLVL		0x1a
> +#define S2MU005_FG_REG_START		0x1e
> +
> +#define S2MU005_FG_MONOUTSEL_AVGCURRENT		0x26
> +#define S2MU005_FG_MONOUTSEL_AVGVOLTAGE		0x27
> +
> +struct s2mu005_fg {
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct power_supply *psy;
> +	struct mutex monout_mutex;
> +};
> +
> +static const struct regmap_config s2mu005_fg_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +};
> +
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
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, S2MU005_FG_REG_RVBAT, &val);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read voltage register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*value =3D (val * MICRO) >> 13;
> +
> +	return 0;
> +}
> +
> +static int s2mu005_fg_get_voltage_avg(struct s2mu005_fg *priv, int *valu=
e)
> +{
> +	struct regmap *regmap =3D priv->regmap;
> +	u32 val;
> +	int ret;
> +
> +	mutex_lock(&priv->monout_mutex);
> +
> +	ret =3D regmap_write(regmap, S2MU005_FG_REG_MONOUTSEL,
> +			   S2MU005_FG_MONOUTSEL_AVGVOLTAGE);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to enable average voltage monitoring (%d)\n=
",
> +			ret);
> +		goto unlock;
> +	}
> +
> +	ret =3D regmap_read(regmap, S2MU005_FG_REG_MONOUT, &val);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
> +		goto unlock;
> +	}
> +
> +	*value =3D (val * MICRO) >> 12;
> +
> +unlock:
> +	mutex_unlock(&priv->monout_mutex);
> +
> +	return ret;
> +}
> +static int s2mu005_fg_get_current_now(struct s2mu005_fg *priv, int *valu=
e)
> +{
> +	struct regmap *regmap =3D priv->regmap;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, S2MU005_FG_REG_RCURCC, &val);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*value =3D -((s16)val * MICRO) >> 12;
> +
> +	return 0;
> +}
> +
> +static int s2mu005_fg_get_current_avg(struct s2mu005_fg *priv, int *valu=
e)
> +{
> +	struct regmap *regmap =3D priv->regmap;
> +	u32 val;
> +	int ret;
> +
> +	mutex_lock(&priv->monout_mutex);
> +
> +	ret =3D regmap_write(regmap, S2MU005_FG_REG_MONOUTSEL,
> +			   S2MU005_FG_MONOUTSEL_AVGCURRENT);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to enable average current monitoring (%d)\n=
",
> +			ret);
> +		goto unlock;
> +	}
> +
> +	ret =3D regmap_read(regmap, S2MU005_FG_REG_MONOUT, &val);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read current register (%d)\n", ret);
> +		goto unlock;
> +	}
> +
> +	*value =3D -((s16)val * MICRO) >> 12;
> +
> +unlock:
> +	mutex_unlock(&priv->monout_mutex);
> +
> +	return ret;
> +}
> +
> +static int s2mu005_fg_get_capacity(struct s2mu005_fg *priv, int *value)
> +{
> +	struct regmap *regmap =3D priv->regmap;
> +	u32 val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, S2MU005_FG_REG_RSOC, &val);
> +	if (ret < 0) {
> +		dev_err(priv->dev, "failed to read capacity register (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*value =3D (val * CENTI) >> 14;
> +
> +	return 0;
> +}
> +
> +static int s2mu005_fg_get_status(struct s2mu005_fg *priv, int *value)
> +{
> +	int current_now, current_avg, capacity;
> +	int ret;
> +
> +	ret =3D s2mu005_fg_get_current_now(priv, &current_now);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D s2mu005_fg_get_current_avg(priv, &current_avg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Verify both current values reported to reduce inaccuracies due to
> +	 * internal hysteresis.
> +	 */
> +	if (current_now < 0 && current_avg < 0) {
> +		*value =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +	} else if (current_now =3D=3D 0) {
> +		*value =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +	} else {
> +		*value =3D POWER_SUPPLY_STATUS_CHARGING;
> +
> +		ret =3D s2mu005_fg_get_capacity(priv, &capacity);
> +		if (!ret && capacity > 98)
> +			*value =3D POWER_SUPPLY_STATUS_FULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static const enum power_supply_property s2mu005_fg_properties[] =3D {
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_STATUS,
> +};
> +
> +static int s2mu005_fg_get_property(struct power_supply *psy,
> +				   enum power_supply_property psp,
> +				   union power_supply_propval *val)
> +{
> +	struct s2mu005_fg *priv =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		return s2mu005_fg_get_voltage_now(priv, &val->intval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_AVG:
> +		return s2mu005_fg_get_voltage_avg(priv, &val->intval);
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		return s2mu005_fg_get_current_now(priv, &val->intval);
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		return s2mu005_fg_get_current_avg(priv, &val->intval);
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		return s2mu005_fg_get_capacity(priv, &val->intval);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return s2mu005_fg_get_status(priv, &val->intval);
> +	default:
> +		return -EINVAL;
> +	}
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
> +	int ret;
> +
> +	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
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

psy_cfg.fwnode =3D dev_fwnode(dev);

> +	priv->psy =3D devm_power_supply_register(priv->dev, psy_desc, &psy_cfg);
> +	if (IS_ERR(priv->psy))
> +		return dev_err_probe(dev, PTR_ERR(priv->psy),
> +				     "failed to register power supply subsystem\n");
> +
> +	ret =3D devm_mutex_init(dev, &priv->monout_mutex);
> +	if (ret)
> +		dev_err_probe(dev, ret, "failed to initialize MONOUT mutex\n");
> +
> +	ret =3D devm_request_threaded_irq(priv->dev, client->irq, NULL,
> +					s2mu005_handle_irq, IRQF_ONESHOT,
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
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, s2mu005_fg_of_match_table);
> +
> +static struct i2c_driver s2mu005_fg_i2c_driver =3D {
> +	.probe =3D s2mu005_fg_i2c_probe,
> +	.driver =3D {
> +		.name =3D "s2mu005-fuel-gauge",
> +		.of_match_table =3D s2mu005_fg_of_match_table,
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

--ka2np5qq7d5vxwcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmmmIAAACgkQ2O7X88g7
+poWcw/8CfUo3LuTjAhUhvSzrYmsDq6tznwYvxbFjXGueZtMDi68g0g4U5/HDksQ
hK4PzttHOBjgUddcumophLJNOGAPDrGX5sc5CMXlDz4Ew7Nab+LSIldjN4U2726M
S5aMCmvxZGFniA2N8LtWlVFO0FUCGpj22cyv24W/3N6vzl9+d4apnnZdKVZqFqSU
gJjbvzYWL9jU48qsZb+kdwyyF9qAUDY0f38k/4Da0tcFZOSHoD/YKZ2KnPE8I4C0
owYcZBYv/QRdmvKad5BpTcJRJmxNLU0BWBliBzwNytA8R6ai5lvr9t2/k4HYJHZA
wdjvehwYsiVZkJgu9CqYE7qHxkId8KyB/aytoAqt9YFYb8mG6Si95cZnErnXbPFp
YZQHB+4A2NfMMqBxoGEWhk3yP00NDgelb+gSyg+sdT5CjKUNQuSJYJWatGRUmhdD
YBrhyaMK8ZME49LmgNfnOaDf4onUDmEdfcL9/gWtaIdat/A213KZTgHkYuRUnBFX
Jr5OKaU14r8rDLuF8iax2b29u+9dqrSvJ+pOph2q+XIHf75nnZbP5+WAgmod+DlJ
lJ0keOpwSJMlrfQZm83KRC8UOsK9j27b4OJD3lQ590HJJF4G8RIT90qZJT5+mEaS
FZ8aUS+CvX2/dqvtPEghTu4Xt3KRtLFmmVdUR0BfsiAJQmG0AZM=
=3kRk
-----END PGP SIGNATURE-----

--ka2np5qq7d5vxwcu--

