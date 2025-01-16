Return-Path: <linux-pm+bounces-20517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E627A12F80
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 01:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 597157A30C5
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 00:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656DD79EA;
	Thu, 16 Jan 2025 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="LaULdIk9"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DCAA50;
	Thu, 16 Jan 2025 00:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736986629; cv=pass; b=RYfzZr9FH8s97p44V1hvrT/+s3DCMZ/B3GSpK+fguHUz/fe+vbVd90o9vj2GHy8p/RlNyxfDi3CJ4fGMDuos/6FdIAlaLiTsTakthDXvPkQIUdwvpDgnnxy9bJoa0uuEanJtYJvWig7hVXvcSnS6lGpGRkee6JJqqowYaWDh7Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736986629; c=relaxed/simple;
	bh=kPeKxrn3D68XszAgdRVmLbrT5mprSJAA1CK/xcMxfbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ba0fUvvV8SjUYjxZYt8xxwwC/tU8iFfhUzs3afgcM2OM+ec+a76d66Tws06O3g5TlB9vtPj4AJQJNKe43sI1ZpE9/iZ+okm+GbaY2cclmK3nggA+3LEFCU+FsagBDbHMS2fZh6pfiOtkV6p2kLOzcPkhK7QO4t1015CIEG8RGuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=LaULdIk9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1736986607; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=j28h/6KnPO3WthPo85EoFGizjP3vmtW6bhx8sK7Ui59j5Fxc74ECToSXZvXoqVhpcoCS4/oV/Xlw4KL11l0kyrx6F5wyEBIf8FwtapPCcRPznLr17jIvxiEU9XQyo0DGjjC0QqQ7MY9Btech4tULXcZRwIE9bN9Iw8o5uxL8tXU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1736986607; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dWkjk5WvbCL6pZ8UCD4K3/I4zHSKPFYfe2VGwPLMuXA=; 
	b=ZeV78dw2JSUItFiw0qaxP0AePUOOaIpQAJ3CfGsHar8HVxUbhXzbF9LsqVAtJQr7LsGNjAYYstmJiNiyzUzb7HZzlSmTgRdHr9PKwP1lgw3pODR+p1j5hw1qpRyHEioCYPEuqUyrF0/KS+qCjCa/PcNx3rUXfTdwh9/sxE24+44=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736986607;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=dWkjk5WvbCL6pZ8UCD4K3/I4zHSKPFYfe2VGwPLMuXA=;
	b=LaULdIk9BMaoj3xZ6/kkaFi3ri5+hSHJqrA4WJvd32ZckZElORuxA85B4Tfu5s/7
	7ldXbdfUNwFCpuu2Lc6kNfvDnT2TE86Dq+l2mGKhEsL2cPAKoldMUWfwGOKQYZUbeTG
	DM/ehDMuxQiJPGX5a7y5cvP/Fps6pYTsYX4qN2Oc=
Received: by mx.zohomail.com with SMTPS id 1736986604215464.50901622161575;
	Wed, 15 Jan 2025 16:16:44 -0800 (PST)
Received: by mercury (Postfix, from userid 1000)
	id EDEBC1060350; Thu, 16 Jan 2025 01:16:38 +0100 (CET)
Date: Thu, 16 Jan 2025 01:16:38 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
	Purism Kernel Team <kernel@puri.sm>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v14 06/10] power: supply: max77705: Add charger driver
 for Maxim 77705
Message-ID: <i6vrezzvaieutxf2cq7hd5vhkbn5so7nlw36hja5iqihv7irch@wpvyxgqkdglz>
References: <20250108-starqltechn_integration_upstream-v14-0-f6e84ec20d96@gmail.com>
 <20250108-starqltechn_integration_upstream-v14-6-f6e84ec20d96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jzi37uj4ttavukbw"
Content-Disposition: inline
In-Reply-To: <20250108-starqltechn_integration_upstream-v14-6-f6e84ec20d96@gmail.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.1/234.845.73
X-ZohoMailClient: External


--jzi37uj4ttavukbw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v14 06/10] power: supply: max77705: Add charger driver
 for Maxim 77705
MIME-Version: 1.0

Hi,

On Wed, Jan 08, 2025 at 05:13:50PM +0300, Dzmitry Sankouski wrote:
> Add driver for Maxim 77705 switch-mode charger.
> It providing power supply class information to userspace.
>=20
> The driver is configured through DTS (battery and system related
> settings).
>=20
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes in v12:
> - add missing new line
> - reorder max77705_charger_enable and max77705_charger_disable action
> - convert driver from platform to i2c, adjust commit msg accordingly
>=20
> Changes in v11:
> - remove multiple blank lines
> - return dev_err_probe
> - fit on one line where possible;
>=20
> Changes in v10:
> - never blank line between call and its error check
> - replace remove function with devm_add_action_or_reset
> - remove unused inline functions from header
> - use dev_err_probe for error handling
>=20
> Changes in v9:
> - move power supply registration before interrupts to prevent
>   NULL exceptions when handling interrupts
>=20
> Changes for v8:
> - join lines, where fits 100 chars
> - change comment style C++ -> C
> - remove author from 'based on' file header statement
> Changes for v6:
> - add i2c init in driver
> - replace remove_new back on remove
> - handle IS_ERR(i2c_chg)
> Changes for v5:
> - remove const modifier from max77705_charger_irq_chip
>   because it's modified with irq_drv_data in probe function
> - fix license to GPL 2.0 only, where old vendor code used
>   GPL 2.0 only
> - move power header to power include dir
> - use same hardware name in Kconfig and module descriptions
>=20
> Changes for v4:
> - start from scratch
> - change word delimiters in filenames to '_'
> - use GENMASK in header
> - remove debugfs code
> - migrate to regmap_add_irq_chip
> - fix property getters to follow the same style

Please add output from tools/testing/selftests/power_supply/test_power_supp=
ly_properties.sh
below the fold in the next round. It looks to me, like some properties are
wrongly scaled to mA/mV instead of uA/uV.

>  drivers/power/supply/Kconfig            |   6 ++
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77705_charger.c | 576 ++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++
>  include/linux/power/max77705_charger.h  | 194 ++++++++++++++++++++++++++=
+++++++++++++++++++++
>  4 files changed, 777 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 7b18358f194a..c120d8ed870f 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -583,6 +583,12 @@ config CHARGER_MAX77693
>  	help
>  	  Say Y to enable support for the Maxim MAX77693 battery charger.
> =20
> +config CHARGER_MAX77705
> +	tristate "Maxim MAX77705 battery charger driver"
> +	depends on MFD_MAX77705
> +	help
> +	  Say Y to enable support for the Maxim MAX77705 battery charger.
> +
>  config CHARGER_MAX77976
>  	tristate "Maxim MAX77976 battery charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index b55cc48a4c86..a4669383d53e 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_CHARGER_MAX14577)	+=3D max14577_charger.o
>  obj-$(CONFIG_CHARGER_DETECTOR_MAX14656)	+=3D max14656_charger_detector.o
>  obj-$(CONFIG_CHARGER_MAX77650)	+=3D max77650-charger.o
>  obj-$(CONFIG_CHARGER_MAX77693)	+=3D max77693_charger.o
> +obj-$(CONFIG_CHARGER_MAX77705)	+=3D max77705_charger.o
>  obj-$(CONFIG_CHARGER_MAX77976)	+=3D max77976_charger.o
>  obj-$(CONFIG_CHARGER_MAX8997)	+=3D max8997_charger.o
>  obj-$(CONFIG_CHARGER_MAX8998)	+=3D max8998_charger.o
> diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supp=
ly/max77705_charger.c
> new file mode 100644
> index 000000000000..563b41420c7c
> --- /dev/null
> +++ b/drivers/power/supply/max77705_charger.c
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Based on max77650-charger.c
> + *
> + * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.org>
> + *
> + * Battery charger driver for MAXIM 77705 charger/power-supply.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/max77693-common.h>
> +#include <linux/mfd/max77705-private.h>
> +#include <linux/power/max77705_charger.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +static const char *max77705_charger_model		=3D "max77705";
> +static const char *max77705_charger_manufacturer	=3D "Maxim Integrated";
> +
> +static const struct regmap_config max77705_chg_regmap_config =3D {
> +	.reg_base =3D MAX77705_CHG_REG_BASE,
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D MAX77705_CHG_REG_SAFEOUT_CTRL,
> +};
> +
> +static enum power_supply_property max77705_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE,
> +	POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT,
> +	POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT,
> +};
> +
> +static int max77705_chgin_irq(void *irq_drv_data)
> +{
> +	struct max77705_charger_data *charger =3D irq_drv_data;
> +
> +	queue_work(charger->wqueue, &charger->chgin_work);
> +
> +	return 0;
> +}
> +
> +static const struct regmap_irq max77705_charger_irqs[] =3D {
> +	{ .mask =3D MAX77705_BYP_IM,   },
> +	{ .mask =3D MAX77705_INP_LIMIT_IM,   },
> +	{ .mask =3D MAX77705_BATP_IM,   },
> +	{ .mask =3D MAX77705_BAT_IM,   },
> +	{ .mask =3D MAX77705_CHG_IM,   },
> +	{ .mask =3D MAX77705_WCIN_IM,   },
> +	{ .mask =3D MAX77705_CHGIN_IM,   },
> +	{ .mask =3D MAX77705_AICL_IM,   },
> +};
> +
> +static struct regmap_irq_chip max77705_charger_irq_chip =3D {
> +	.name			=3D "max77705-charger",
> +	.status_base		=3D MAX77705_CHG_REG_INT,
> +	.mask_base		=3D MAX77705_CHG_REG_INT_MASK,
> +	.handle_post_irq	=3D max77705_chgin_irq,
> +	.num_regs		=3D 1,
> +	.irqs			=3D max77705_charger_irqs,
> +	.num_irqs		=3D ARRAY_SIZE(max77705_charger_irqs),
> +};
> +
> +static int max77705_charger_enable(struct max77705_charger_data *chg)
> +{
> +	int rv;
> +
> +	rv =3D regmap_update_bits(chg->regmap, MAX77705_CHG_REG_CNFG_09,
> +				MAX77705_CHG_EN_MASK, MAX77705_CHG_EN_MASK);
> +	if (rv)
> +		dev_err(chg->dev, "unable to enable the charger: %d\n", rv);
> +
> +	return rv;
> +}
> +
> +static void max77705_charger_disable(void *data)
> +{
> +	struct max77705_charger_data *chg =3D data;
> +	int rv;
> +
> +	rv =3D regmap_update_bits(chg->regmap,
> +				MAX77705_CHG_REG_CNFG_09,
> +				MAX77705_CHG_EN_MASK,
> +				MAX77705_CHG_DISABLE);
> +	if (rv)
> +		dev_err(chg->dev, "unable to disable the charger: %d\n", rv);
> +}
> +
> +static int max77705_get_online(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, MAX77705_CHG_REG_INT_OK, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D !!(data & MAX77705_CHGIN_OK);
> +
> +	return 0;
> +}
> +
> +static int max77705_check_battery(struct max77705_charger_data *charger,=
 int *val)
> +{
> +	unsigned int reg_data;
> +	unsigned int reg_data2;
> +	struct regmap *regmap =3D charger->regmap;
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_INT_OK, &reg_data);
> +
> +	dev_dbg(charger->dev, "CHG_INT_OK(0x%x)\n", reg_data);
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_DETAILS_00, &reg_data2);
> +
> +	dev_dbg(charger->dev, "CHG_DETAILS00(0x%x)\n", reg_data2);
> +
> +	if ((reg_data & MAX77705_BATP_OK) || !(reg_data2 & MAX77705_BATP_DTLS))
> +		*val =3D true;
> +	else
> +		*val =3D false;
> +
> +	return 0;
> +}
> +
> +static int max77705_get_charge_type(struct max77705_charger_data *charge=
r, int *val)
> +{
> +	struct regmap *regmap =3D charger->regmap;
> +	unsigned int reg_data;
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
> +	if (!MAX77705_CHARGER_CHG_CHARGING(reg_data)) {
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		return 0;
> +	}
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_DETAILS_01, &reg_data);
> +	reg_data &=3D MAX77705_CHG_DTLS;
> +
> +	switch (reg_data) {
> +	case 0x0:
> +	case MAX77705_CHARGER_CONSTANT_CURRENT:
> +	case MAX77705_CHARGER_CONSTANT_VOLTAGE:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		return 0;
> +	default:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77705_get_status(struct max77705_charger_data *charger, in=
t *val)
> +{
> +	struct regmap *regmap =3D charger->regmap;
> +	unsigned int reg_data;
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
> +	if (!MAX77705_CHARGER_CHG_CHARGING(reg_data)) {
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		return 0;
> +	}
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_DETAILS_01, &reg_data);
> +	reg_data &=3D MAX77705_CHG_DTLS;
> +
> +	switch (reg_data) {
> +	case 0x0:
> +	case MAX77705_CHARGER_CONSTANT_CURRENT:
> +	case MAX77705_CHARGER_CONSTANT_VOLTAGE:
> +		*val =3D POWER_SUPPLY_STATUS_CHARGING;
> +		return 0;
> +	case MAX77705_CHARGER_END_OF_CHARGE:
> +	case MAX77705_CHARGER_DONE:
> +		*val =3D POWER_SUPPLY_STATUS_FULL;
> +		return 0;
> +	/* those values hard coded as in vendor kernel, because of */
> +	/* failure to determine it's actual meaning. */
> +	case 0x05:
> +	case 0x06:
> +	case 0x07:
> +		*val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		return 0;
> +	case 0x08:
> +	case 0xA:
> +	case 0xB:
> +		*val =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		return 0;
> +	default:
> +		*val =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +		return 0;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77705_get_vbus_state(struct regmap *regmap, int *value)
> +{
> +	int ret;
> +	unsigned int charge_dtls;
> +
> +	ret =3D regmap_read(regmap, MAX77705_CHG_REG_DETAILS_00, &charge_dtls);
> +	if (ret)
> +		return ret;
> +
> +	charge_dtls =3D ((charge_dtls & MAX77705_CHGIN_DTLS) >>
> +			MAX77705_CHGIN_DTLS_SHIFT);
> +
> +	switch (charge_dtls) {
> +	case 0x00:
> +		*value =3D POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
> +		break;
> +	case 0x01:
> +		*value =3D POWER_SUPPLY_HEALTH_UNDERVOLTAGE;
> +		break;
> +	case 0x02:
> +		*value =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +	case 0x03:
> +		*value =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	default:
> +		return 0;
> +	}
> +	return 0;
> +}
> +
> +static int max77705_get_battery_health(struct max77705_charger_data *cha=
rger,
> +					int *value)
> +{
> +	struct regmap *regmap =3D charger->regmap;
> +	unsigned int bat_dtls;
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_DETAILS_01, &bat_dtls);
> +	bat_dtls =3D ((bat_dtls & MAX77705_BAT_DTLS) >> MAX77705_BAT_DTLS_SHIFT=
);
> +
> +	switch (bat_dtls) {
> +	case MAX77705_BATTERY_NOBAT:
> +		dev_dbg(charger->dev, "%s: No battery and the charger is suspended\n",
> +			__func__);
> +		*value =3D POWER_SUPPLY_HEALTH_NO_BATTERY;
> +		break;
> +	case MAX77705_BATTERY_PREQUALIFICATION:
> +		dev_dbg(charger->dev, "%s: battery is okay but its voltage is low(~VPQ=
LB)\n",
> +			__func__);
> +		break;
> +	case MAX77705_BATTERY_DEAD:
> +		dev_dbg(charger->dev, "%s: battery dead\n", __func__);
> +		*value =3D POWER_SUPPLY_HEALTH_DEAD;
> +		break;
> +	case MAX77705_BATTERY_GOOD:
> +	case MAX77705_BATTERY_LOWVOLTAGE:
> +		*value =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case MAX77705_BATTERY_OVERVOLTAGE:
> +		dev_dbg(charger->dev, "%s: battery ovp\n", __func__);
> +		*value =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +	default:
> +		dev_dbg(charger->dev, "%s: battery unknown\n", __func__);
> +		*value =3D POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int max77705_get_health(struct max77705_charger_data *charger, in=
t *val)
> +{
> +	struct regmap *regmap =3D charger->regmap;
> +	int ret, is_online =3D 0;
> +
> +	ret =3D max77705_get_online(regmap, &is_online);
> +	if (ret)
> +		return ret;
> +	if (is_online) {
> +		ret =3D max77705_get_vbus_state(regmap, val);
> +		if (ret || (*val !=3D POWER_SUPPLY_HEALTH_GOOD))
> +			return ret;
> +	}
> +	return max77705_get_battery_health(charger, val);
> +}
> +
> +static int max77705_get_input_current(struct max77705_charger_data *char=
ger,
> +					int *val)
> +{
> +	unsigned int reg_data;
> +	int get_current =3D 0;
> +	struct regmap *regmap =3D charger->regmap;
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_CNFG_09, &reg_data);
> +
> +	reg_data &=3D MAX77705_CHG_CHGIN_LIM_MASK;
> +
> +	if (reg_data <=3D 3)
> +		get_current =3D 100;
> +	else if (reg_data >=3D MAX77705_CHG_CHGIN_LIM_MASK)
> +		get_current =3D MAX77705_CURRENT_CHGIN_MAX;
> +	else
> +		get_current =3D (reg_data + 1) * 25;
> +
> +	*val =3D get_current;
> +
> +	return 0;
> +}
> +
> +static int max77705_get_charge_current(struct max77705_charger_data *cha=
rger,
> +					int *val)
> +{
> +	unsigned int reg_data;
> +	struct regmap *regmap =3D charger->regmap;
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_CNFG_02, &reg_data);
> +	reg_data &=3D MAX77705_CHG_CC;
> +
> +	*val =3D reg_data <=3D 0x2 ? 100 : reg_data * 50;
> +
> +	return 0;
> +}
> +
> +static int max77705_set_float_voltage(struct max77705_charger_data *char=
ger,
> +					int float_voltage)
> +{
> +	int float_voltage_mv;
> +	unsigned int reg_data =3D 0;
> +	struct regmap *regmap =3D charger->regmap;
> +
> +	float_voltage_mv =3D float_voltage / 1000;
> +	reg_data =3D float_voltage_mv <=3D 4000 ? 0x0 :
> +		float_voltage_mv >=3D 4500 ? 0x23 :
> +		(float_voltage_mv <=3D 4200) ? (float_voltage_mv - 4000) / 50 :
> +		(((float_voltage_mv - 4200) / 10) + 0x04);
> +
> +	return regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_04,
> +				MAX77705_CHG_CV_PRM_MASK,
> +				(reg_data << MAX77705_CHG_CV_PRM_SHIFT));
> +}
> +
> +static int max77705_get_float_voltage(struct max77705_charger_data *char=
ger,
> +					int *val)
> +{
> +	unsigned int reg_data =3D 0;
> +	struct regmap *regmap =3D charger->regmap;
> +
> +	regmap_read(regmap, MAX77705_CHG_REG_CNFG_04, &reg_data);
> +	reg_data &=3D MAX77705_CHG_PRM_MASK;
> +	*val =3D reg_data <=3D 0x04 ? reg_data * 50 + 4000 :
> +					(reg_data - 4) * 10 + 4200;
> +
> +	return 0;
> +}
> +
> +static int max77705_chg_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct max77705_charger_data *charger =3D power_supply_get_drvdata(psy);
> +	struct regmap *regmap =3D charger->regmap;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		return max77705_get_online(regmap, &val->intval);
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		return max77705_check_battery(charger, &val->intval);
> +	case POWER_SUPPLY_PROP_STATUS:
> +		return max77705_get_status(charger, &val->intval);
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		return max77705_get_charge_type(charger, &val->intval);
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		return max77705_get_health(charger, &val->intval);
> +	case POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT:
> +		return max77705_get_input_current(charger, &val->intval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT:
> +		return max77705_get_charge_current(charger, &val->intval);
> +	case POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE:
> +		return max77705_get_float_voltage(charger, &val->intval);
> +	case POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN:
> +		val->intval =3D charger->bat_info->voltage_max_design_uv;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D max77705_charger_model;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D max77705_charger_manufacturer;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static const struct power_supply_desc max77705_charger_psy_desc =3D {
> +	.name =3D "max77705-charger",
> +	.type		=3D POWER_SUPPLY_TYPE_USB,
> +	.properties =3D max77705_charger_props,
> +	.num_properties =3D ARRAY_SIZE(max77705_charger_props),
> +	.get_property =3D max77705_chg_get_property,
> +};
> +
> +static void max77705_chgin_isr_work(struct work_struct *work)
> +{
> +	struct max77705_charger_data *charger =3D
> +		container_of(work, struct max77705_charger_data, chgin_work);
> +
> +	power_supply_changed(charger->psy_chg);
> +}
> +
> +static void max77705_charger_initialize(struct max77705_charger_data *ch=
g)
> +{
> +	u8 reg_data;
> +	struct power_supply_battery_info *info;
> +	struct regmap *regmap =3D chg->regmap;
> +
> +	if (power_supply_get_battery_info(chg->psy_chg, &info) < 0)
> +		return;
> +
> +	chg->bat_info =3D info;
> +
> +	/* unlock charger setting protect */
> +	/* slowest LX slope */
> +	reg_data =3D MAX77705_CHGPROT_MASK | MAX77705_SLOWEST_LX_SLOPE;
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_06, reg_data,
> +						reg_data);
> +
> +	/* fast charge timer disable */
> +	/* restart threshold disable */
> +	/* pre-qual charge disable */
> +	reg_data =3D (MAX77705_FCHGTIME_DISABLE << MAX77705_FCHGTIME_SHIFT) |
> +			(MAX77705_CHG_RSTRT_DISABLE << MAX77705_CHG_RSTRT_SHIFT) |
> +			(MAX77705_CHG_PQEN_DISABLE << MAX77705_PQEN_SHIFT);
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_01,
> +						(MAX77705_FCHGTIME_MASK |
> +						MAX77705_CHG_RSTRT_MASK |
> +						MAX77705_PQEN_MASK),
> +						reg_data);
> +
> +	/* OTG off(UNO on), boost off */
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
> +				MAX77705_OTG_CTRL, 0);
> +
> +	/* charge current 450mA(default) */
> +	/* otg current limit 900mA */
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_02,
> +				MAX77705_OTG_ILIM_MASK,
> +				MAX77705_OTG_ILIM_900 << MAX77705_OTG_ILIM_SHIFT);
> +
> +	/* BAT to SYS OCP 4.80A */
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_05,
> +				MAX77705_REG_B2SOVRC_MASK,
> +				MAX77705_B2SOVRC_4_8A << MAX77705_REG_B2SOVRC_SHIFT);
> +	/* top off current 150mA */
> +	/* top off timer 30min */
> +	reg_data =3D (MAX77705_TO_ITH_150MA << MAX77705_TO_ITH_SHIFT) |
> +			(MAX77705_TO_TIME_30M << MAX77705_TO_TIME_SHIFT) |
> +			(MAX77705_SYS_TRACK_DISABLE << MAX77705_SYS_TRACK_DIS_SHIFT);
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_03,
> +			   (MAX77705_TO_ITH_MASK |
> +			   MAX77705_TO_TIME_MASK |
> +			   MAX77705_SYS_TRACK_DIS_MASK), reg_data);
> +
> +	/* cv voltage 4.2V or 4.35V */
> +	/* MINVSYS 3.6V(default) */
> +	if (info->voltage_max_design_uv < 0) {
> +		dev_warn(chg->dev, "missing battery:voltage-max-design-microvolt\n");
> +		max77705_set_float_voltage(chg, 4200000);
> +	} else {
> +		max77705_set_float_voltage(chg, info->voltage_max_design_uv);
> +	}
> +
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12,
> +				MAX77705_VCHGIN_REG_MASK, MAX77705_VCHGIN_4_5);
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12,
> +				MAX77705_WCIN_REG_MASK, MAX77705_WCIN_4_5);
> +
> +	/* Watchdog timer */
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_00,
> +				MAX77705_WDTEN_MASK, 0);
> +
> +	/* Active Discharge Enable */
> +	regmap_update_bits(regmap, MAX77705_PMIC_REG_MAINCTRL1, 1, 1);
> +
> +	/* VBYPSET=3D5.0V */
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_11, MAX77705_VBYPSET_M=
ASK, 0);
> +
> +	/* Switching Frequency : 1.5MHz */
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_08, MAX77705_REG_FSW_M=
ASK,
> +				(MAX77705_CHG_FSW_1_5MHz << MAX77705_REG_FSW_SHIFT));
> +
> +	/* Auto skip mode */
> +	regmap_update_bits(regmap, MAX77705_CHG_REG_CNFG_12, MAX77705_REG_DISKI=
P_MASK,
> +				(MAX77705_AUTO_SKIP << MAX77705_REG_DISKIP_SHIFT));
> +}
> +
> +static int max77705_charger_probe(struct i2c_client *i2c)
> +{
> +	struct power_supply_config pscfg =3D {};
> +	struct max77705_charger_data *chg;
> +	struct device *dev;
> +	struct regmap_irq_chip_data *irq_data;
> +	int ret;
> +
> +	dev =3D &i2c->dev;
> +
> +	chg =3D devm_kzalloc(dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	chg->dev =3D dev;
> +	i2c_set_clientdata(i2c, chg);
> +
> +	chg->regmap =3D devm_regmap_init_i2c(i2c, &max77705_chg_regmap_config);
> +	if (IS_ERR(chg->regmap))
> +		return PTR_ERR(chg->regmap);
> +
> +	ret =3D regmap_update_bits(chg->regmap,
> +				MAX77705_CHG_REG_INT_MASK,
> +				MAX77705_CHGIN_IM, 0);
> +	if (ret)
> +		return ret;
> +
> +	pscfg.of_node =3D dev->of_node;

replace with:

psycfg.fwnode =3D dev_fwnode(dev);

> +	pscfg.drv_data =3D chg;
> +
> +	chg->psy_chg =3D devm_power_supply_register(dev, &max77705_charger_psy_=
desc, &pscfg);
> +	if (IS_ERR(chg->psy_chg))
> +		return PTR_ERR(chg->psy_chg);
> +
> +	max77705_charger_irq_chip.irq_drv_data =3D chg;
> +	ret =3D devm_regmap_add_irq_chip(chg->dev, chg->regmap, i2c->irq,
> +					IRQF_ONESHOT | IRQF_SHARED, 0,
> +					&max77705_charger_irq_chip,
> +					&irq_data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add irq chip\n");
> +
> +	chg->wqueue =3D create_singlethread_workqueue(dev_name(dev));
> +	if (IS_ERR(chg->wqueue))
> +		return dev_err_probe(dev, PTR_ERR(chg->wqueue), "failed to create work=
queue\n");
> +
> +	INIT_WORK(&chg->chgin_work, max77705_chgin_isr_work);

devm_work_autocancel()

> +	max77705_charger_initialize(chg);
> +
> +	ret =3D max77705_charger_enable(chg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable charge\n");
> +	else

You can drop this else and reduce indent of the following line.

> +		return devm_add_action_or_reset(dev, max77705_charger_disable, chg);
> +}
> +
> +static const struct of_device_id max77705_charger_of_match[] =3D {
> +	{ .compatible =3D "maxim,max77705-charger" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max77705_charger_of_match);
> +
> +static struct i2c_driver max77705_charger_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77705-charger",
> +		.of_match_table =3D max77705_charger_of_match,
> +	},
> +	.probe =3D max77705_charger_probe,
> +};
> +module_i2c_driver(max77705_charger_driver);
> +
> +MODULE_AUTHOR("Dzmitry Sankouski <dsankouski@gmail.com>");
> +MODULE_DESCRIPTION("Maxim MAX77705 charger driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/power/max77705_charger.h b/include/linux/power=
/max77705_charger.h
> new file mode 100644
> index 000000000000..cb5cd03e54e2
> --- /dev/null
> +++ b/include/linux/power/max77705_charger.h
> @@ -0,0 +1,194 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Maxim MAX77705 definitions.
> + *
> + * Copyright (C) 2015 Samsung Electronics, Inc.
> + * Copyright (C) 2024 Dzmitry Sankouski <dsankouski@gmail.com>
> + */

Please put all of it at the head of the driver, like any of the
recent power-supply drivers do.

Greetings,

-- Sebastian

--jzi37uj4ttavukbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmeIT+AACgkQ2O7X88g7
+poyxRAAiO47xMpHcpHf8OcQ7/iowBzR5Yb93UnbEEygBHnqPlzyGrr1HYKP+p1M
W1POP4KiSXczOPnBmhGX/1G7ZYuEYuXOTyMyvvP8r8Qh6604ZIEd1dwRpajpqRwz
4heoP2yCO/wCP32z3aBO5xAh+SRcgoCI/8RVjvwNRq52krBwKQZqw+pmYVoYzxDD
a9pEcuT+xWltpqbVYRY4hL4yooBhTK5d2pnXiOb3jbXUg1UBvnwV+GNz3YjLL7D/
DGy6Wp+6BQEYYLEXa/IljaLuT+mc2OchHhD2nAuQ+s3lt2UOIfbJHt5WUm7nJJfF
JB6OuJIIbWfg5DslGkv733uUQLUch+VKoHVmv57LAw4/1vI6jFQ3F8Mn5pE7YrFN
R3OoSzF2omYIOOU3OHZLR7QYBJdICDde0t/bq2/Ypu8o64DExnauOVcSU3dd7OBI
4B2E8xg1xK6V+OaIPZDnx98xsRZNpCnDDxg1q7/CsplthvR4ZJxlOlq2J2nx3Fjp
w4IevWNbva2b0AKmfYYKPVj8xvP12fdaTtARxf9kVW4yuRbK/D/UUXQ7BI/QEivx
DHwVRGGqtpkkDbOy2yKIcXTyU9t26s+jgTbJLjAcSG4+y7pm3TgagCHwt2K6BpBa
jRqUvZ6+IzxtcASVVZPbEl5WB+1ZGOoRqCsFd3Z9AlyzCEVvxN4=
=qvUM
-----END PGP SIGNATURE-----

--jzi37uj4ttavukbw--

