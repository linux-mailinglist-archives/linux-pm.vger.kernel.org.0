Return-Path: <linux-pm+bounces-34748-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDC1B5A05F
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 20:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 232174E2BFD
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC369285CBD;
	Tue, 16 Sep 2025 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="TpT3jHpc"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54672288C3B;
	Tue, 16 Sep 2025 18:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758046567; cv=pass; b=myEAm3VLcexuesifeguytfd5HdIqc69M9Fogw/YcVqlqSFVP/m3f7AiVvkYTZLFyjycyZ5ySgneYyqG1DtmC1Qt/yVoTfDcnMz1EQ/RYzB4tE4Skt7aWN8+2cvrQhW/N79fEu38U0zAtP432dId7i4RlXj8pkwEmAhphGMsVCY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758046567; c=relaxed/simple;
	bh=wBch0sbMvwNBAiQk76P3NDhnURv7zOAXAnXCE2qyfu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuWkphTCzckwfBgs/aNtu98voSrJFBATLerX13SCWRtHocFok/iO1/mpy1SDGQGT62Rgz4mplAcMvmjOVXN9DkW7DGlJZQAOepxUXRZdCNgbqTDA7MNc2o8kCrReyB6E51UEpwHTE2o9oN1ywHeF7/fAm20YYN/Gojk/hHOisP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=TpT3jHpc; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758046520; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AUqyOSYpzLwvUeajweHkLSg05nlb7cZLUAgzUhj0hGDWTnziNBE2xj1yQbgV3SGeRbEn2Qen5u7LxsHAoetXtaBEI39PzkbCLvULy4E61nLi8klG44A3wMbJn7wHHKBB9+TA4cgRl+Ssxm04ucK/4ZryXsFO0KgFKQ10yRLKD8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758046520; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MN6VDWKpLLyMgH8II3lMSXABk7Vvp31vi6T9CwQgaxo=; 
	b=WFRQhbbpEaJM0vvaeCht2++onCYOHpLX0A89wrROJZqyztBOIn+Or1A1sGGRuw/yYBK+cJiHm1M8E1sSL79cDPuJNs6Wp9wNKNf1vLdHJHcpp0yR2mlv+9kyWYzjKzKSOi1E70Gazw2PX2HJBZUQos3GHxpB2cUmol45JQXQQ3k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758046520;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=MN6VDWKpLLyMgH8II3lMSXABk7Vvp31vi6T9CwQgaxo=;
	b=TpT3jHpcv1uNZH3cB3wFeaSuEzPpUA/gVmKb7hssoEkz3foShYB3u8itlIqcpuTn
	v1DjOXJ0g75XBx0y8+eLITfqAODcFajDdcHVzGDaaDBYXjtfXRiFUt729ZHu3+iWxNS
	ToBrMHLkSHy92Ws87hSPXXtrhaD3g/YJIt4CFnec=
Received: by mx.zohomail.com with SMTPS id 1758046517531677.9619479622007;
	Tue, 16 Sep 2025 11:15:17 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id CA336180733; Tue, 16 Sep 2025 20:15:04 +0200 (CEST)
Date: Tue, 16 Sep 2025 20:15:04 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: samuel.kayode@savoirfairelinux.com
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Li <Frank.li@nxp.com>, imx@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pm@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>, Abel Vesa <abelvesa@linux.com>, 
	Robin Gong <b38343@freescale.com>, Robin Gong <yibin.gong@nxp.com>, 
	Enric Balletbo i Serra <eballetbo@gmail.com>, Sean Nyekjaer <sean@geanix.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v10 5/6] power: supply: pf1550: add battery charger
 support
Message-ID: <2haqo27ggqkrmdpwlq3ajphuilnbiqpdeouewkwewuagc7jd5a@xbjzi66whzpl>
References: <20250820-pf1550-v10-0-4c0b6e4445e3@savoirfairelinux.com>
 <20250820-pf1550-v10-5-4c0b6e4445e3@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z3jqxina4zvlvmw5"
Content-Disposition: inline
In-Reply-To: <20250820-pf1550-v10-5-4c0b6e4445e3@savoirfairelinux.com>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--z3jqxina4zvlvmw5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 5/6] power: supply: pf1550: add battery charger
 support
MIME-Version: 1.0

Hi,

On Wed, Aug 20, 2025 at 04:44:40PM -0400, Samuel Kayode via B4 Relay wrote:
> From: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
>=20
> Add support for the battery charger for pf1550 PMIC.
>=20
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Sean Nyekjaer <sean@geanix.com>
> Signed-off-by: Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> ---
> v9:
> - Fix thermal regulation temperature ranges
> - Fix default thermal regulation temperature
> - Drop unused `data` variable in reg_init
> - Select charger operation mode based on application - suggested by Sean
> v8:
> - Drop PF1550_CHARGER_NAME
> - Drop unnecessary POWER_SUPPLY_STATUS_CHARGING s
> - Replace POWER_SUPPLY_HEALTH_DEAD with POWER_SUPPLY_HEALTH_NO_BATTERY
> - Drop check for charger in delayed_work s
> - Use dev_warn when battery is over-voltage
> - Define two power supplies: charger and battery
> - Use devm_delayed_work_autocancel to automate cleanup and fix race
>   condition
> v7:
> - Use reverse christmas tree order
> - Drop unecessary 0 in id table's driver data field
> - Store virqs to avoid reinvoking platform_get_irq in the interrupt
>   service routine
> - Drop manufacturer and model global variables
> v6:
> - Drop lock entirely
> - Reverse christmas tree order for variables defined in probe as
>   suggested by Frank
> - return pf1550_reg_init
> v5:
> - Drop lock for battery and charger delayed_work
> - More conservative locking in vbus delayed_work
> - Apply lock when setting power supply type during register initialization
> v4:
> - Finish handling of some interrupts in threaded irq handler
> - Use platform_get_irq
> v3:
> - Use struct power_supply_get_battery_info to get constant charge
>   voltage if specified
> - Use virqs mapped in MFD driver
> v2:
> - Address feedback from Enric Balletbo Serra
> ---
>  drivers/power/supply/Kconfig          |  11 +
>  drivers/power/supply/Makefile         |   1 +
>  drivers/power/supply/pf1550-charger.c | 636 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 648 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad6bf96b71ed570a37c006b5f9433..6d0c872edac1f45da314632e6=
71af1aeda4c87b8 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -471,6 +471,17 @@ config CHARGER_88PM860X
>  	help
>  	  Say Y here to enable charger for Marvell 88PM860x chip.
> =20
> +config CHARGER_PF1550
> +	tristate "NXP PF1550 battery charger driver"
> +	depends on MFD_PF1550
> +	help
> +	  Say Y to enable support for the NXP PF1550 battery charger.
> +	  The device is a single cell Li-Ion/Li-Polymer battery charger for
> +	  portable application.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called pf1550-charger.
> +
>  config BATTERY_RX51
>  	tristate "Nokia RX-51 (N900) battery driver"
>  	depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 4f5f8e3507f80da02812f0d08c2d81ddff0a272f..7f68380099c59dab71b731201=
50612a23e16a745 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -64,6 +64,7 @@ obj-$(CONFIG_CHARGER_RT9467)	+=3D rt9467-charger.o
>  obj-$(CONFIG_CHARGER_RT9471)	+=3D rt9471.o
>  obj-$(CONFIG_BATTERY_TWL4030_MADC)	+=3D twl4030_madc_battery.o
>  obj-$(CONFIG_CHARGER_88PM860X)	+=3D 88pm860x_charger.o
> +obj-$(CONFIG_CHARGER_PF1550)	+=3D pf1550-charger.o
>  obj-$(CONFIG_BATTERY_RX51)	+=3D rx51_battery.o
>  obj-$(CONFIG_AB8500_BM)		+=3D ab8500_bmdata.o ab8500_charger.o ab8500_fg=
=2Eo ab8500_btemp.o ab8500_chargalg.o
>  obj-$(CONFIG_CHARGER_CPCAP)	+=3D cpcap-charger.o
> diff --git a/drivers/power/supply/pf1550-charger.c b/drivers/power/supply=
/pf1550-charger.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..2c43cc086a18239b46c73553d=
73a85a60ba7c41e
> --- /dev/null
> +++ b/drivers/power/supply/pf1550-charger.c
> @@ -0,0 +1,636 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * charger driver for the PF1550
> + *
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Robin Gong <yibin.gong@freescale.com>
> + *
> + * Portions Copyright (c) 2025 Savoir-faire Linux Inc.
> + * Samuel Kayode <samuel.kayode@savoirfairelinux.com>
> + */
> +
> +#include <linux/devm-helpers.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/pf1550.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +
> +#define PF1550_DEFAULT_CONSTANT_VOLT	4200000
> +#define PF1550_DEFAULT_MIN_SYSTEM_VOLT	3500000
> +#define PF1550_DEFAULT_THERMAL_TEMP	95
> +#define PF1550_CHARGER_IRQ_NR		5
> +
> +struct pf1550_charger {
> +	struct device *dev;
> +	const struct pf1550_ddata *pf1550;
> +	struct power_supply *charger;
> +	struct power_supply *battery;
> +	struct delayed_work vbus_sense_work;
> +	struct delayed_work chg_sense_work;
> +	struct delayed_work bat_sense_work;
> +	int virqs[PF1550_CHARGER_IRQ_NR];
> +
> +	u32 constant_volt;
> +	u32 min_system_volt;
> +	u32 thermal_regulation_temp;
> +};
> +
> +static int pf1550_get_charger_state(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &=3D PF1550_CHG_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_CHG_PRECHARGE:
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +	case PF1550_CHG_CONSTANT_VOL:
> +	case PF1550_CHG_EOC:
> +		*val =3D POWER_SUPPLY_STATUS_CHARGING;
> +		break;
> +	case PF1550_CHG_DONE:
> +		*val =3D POWER_SUPPLY_STATUS_FULL;
> +		break;
> +	case PF1550_CHG_TIMER_FAULT:
> +	case PF1550_CHG_SUSPEND:
> +		*val =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		break;
> +	case PF1550_CHG_OFF_INV:
> +	case PF1550_CHG_OFF_TEMP:
> +	case PF1550_CHG_LINEAR_ONLY:
> +		*val =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_STATUS_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_charge_type(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, PF1550_CHARG_REG_CHG_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &=3D PF1550_CHG_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_CHG_SNS_MASK:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
> +		break;
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +	case PF1550_CHG_CONSTANT_VOL:
> +	case PF1550_CHG_EOC:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
> +		break;
> +	case PF1550_CHG_DONE:
> +	case PF1550_CHG_TIMER_FAULT:
> +	case PF1550_CHG_SUSPEND:
> +	case PF1550_CHG_OFF_INV:
> +	case PF1550_CHG_BAT_OVER:
> +	case PF1550_CHG_OFF_TEMP:
> +	case PF1550_CHG_LINEAR_ONLY:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_NONE;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_CHARGE_TYPE_UNKNOWN;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Supported health statuses:
> + *  - POWER_SUPPLY_HEALTH_DEAD
> + *  - POWER_SUPPLY_HEALTH_GOOD
> + *  - POWER_SUPPLY_HEALTH_OVERVOLTAGE
> + *  - POWER_SUPPLY_HEALTH_UNKNOWN
> + */
> +static int pf1550_get_battery_health(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &=3D PF1550_BAT_SNS_MASK;
> +
> +	switch (data) {
> +	case PF1550_BAT_NO_DETECT:
> +		*val =3D POWER_SUPPLY_HEALTH_NO_BATTERY;
> +		break;
> +	case PF1550_BAT_NO_VBUS:
> +	case PF1550_BAT_LOW_THAN_PRECHARG:
> +	case PF1550_BAT_CHARG_FAIL:
> +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> +		*val =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case PF1550_BAT_OVER_VOL:
> +		*val =3D POWER_SUPPLY_HEALTH_OVERVOLTAGE;
> +		break;
> +	default:
> +		*val =3D POWER_SUPPLY_HEALTH_UNKNOWN;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_present(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, PF1550_CHARG_REG_BATT_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	data &=3D PF1550_BAT_SNS_MASK;
> +	*val =3D (data =3D=3D PF1550_BAT_NO_DETECT) ? 0 : 1;
> +
> +	return 0;
> +}
> +
> +static int pf1550_get_online(struct regmap *regmap, int *val)
> +{
> +	unsigned int data;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, PF1550_CHARG_REG_VBUS_SNS, &data);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val =3D (data & PF1550_VBUS_VALID) ? 1 : 0;
> +
> +	return 0;
> +}
> +
> +static void pf1550_chg_bat_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg =3D container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  bat_sense_work);
> +	unsigned int data;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_BATT_SNS, &data))=
 {
> +		dev_err(chg->dev, "Read BATT_SNS error.\n");
> +		return;
> +	}
> +
> +	switch (data & PF1550_BAT_SNS_MASK) {
> +	case PF1550_BAT_NO_VBUS:
> +		dev_dbg(chg->dev, "No valid VBUS input.\n");
> +		break;
> +	case PF1550_BAT_LOW_THAN_PRECHARG:
> +		dev_dbg(chg->dev, "VBAT < VPRECHG.LB.\n");
> +		break;
> +	case PF1550_BAT_CHARG_FAIL:
> +		dev_dbg(chg->dev, "Battery charging failed.\n");
> +		break;
> +	case PF1550_BAT_HIGH_THAN_PRECHARG:
> +		dev_dbg(chg->dev, "VBAT > VPRECHG.LB.\n");
> +		break;
> +	case PF1550_BAT_OVER_VOL:
> +		dev_dbg(chg->dev, "VBAT > VBATOV.\n");
> +		break;
> +	case PF1550_BAT_NO_DETECT:
> +		dev_dbg(chg->dev, "Battery not detected.\n");
> +		break;
> +	default:
> +		dev_err(chg->dev, "Unknown value read:%x\n",
> +			data & PF1550_CHG_SNS_MASK);
> +	}
> +}
> +
> +static void pf1550_chg_chg_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg =3D container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  chg_sense_work);
> +	unsigned int data;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_SNS, &data)) {
> +		dev_err(chg->dev, "Read CHG_SNS error.\n");
> +		return;
> +	}
> +
> +	switch (data & PF1550_CHG_SNS_MASK) {
> +	case PF1550_CHG_PRECHARGE:
> +		dev_dbg(chg->dev, "In pre-charger mode.\n");
> +		break;
> +	case PF1550_CHG_CONSTANT_CURRENT:
> +		dev_dbg(chg->dev, "In fast-charge constant current mode.\n");
> +		break;
> +	case PF1550_CHG_CONSTANT_VOL:
> +		dev_dbg(chg->dev, "In fast-charge constant voltage mode.\n");
> +		break;
> +	case PF1550_CHG_EOC:
> +		dev_dbg(chg->dev, "In EOC mode.\n");
> +		break;
> +	case PF1550_CHG_DONE:
> +		dev_dbg(chg->dev, "In DONE mode.\n");
> +		break;
> +	case PF1550_CHG_TIMER_FAULT:
> +		dev_info(chg->dev, "In timer fault mode.\n");
> +		break;
> +	case PF1550_CHG_SUSPEND:
> +		dev_info(chg->dev, "In thermistor suspend mode.\n");
> +		break;
> +	case PF1550_CHG_OFF_INV:
> +		dev_info(chg->dev, "Input invalid, charger off.\n");
> +		break;
> +	case PF1550_CHG_BAT_OVER:
> +		dev_warn(chg->dev, "Battery over-voltage.\n");
> +		break;
> +	case PF1550_CHG_OFF_TEMP:
> +		dev_info(chg->dev, "Temp high, charger off.\n");
> +		break;
> +	case PF1550_CHG_LINEAR_ONLY:
> +		dev_dbg(chg->dev, "In Linear mode, not charging.\n");
> +		break;
> +	default:
> +		dev_err(chg->dev, "Unknown value read:%x\n",
> +			data & PF1550_CHG_SNS_MASK);
> +	}
> +}
> +
> +static void pf1550_chg_vbus_work(struct work_struct *work)
> +{
> +	struct pf1550_charger *chg =3D container_of(to_delayed_work(work),
> +						  struct pf1550_charger,
> +						  vbus_sense_work);
> +	unsigned int data;
> +
> +	if (regmap_read(chg->pf1550->regmap, PF1550_CHARG_REG_VBUS_SNS, &data))=
 {
> +		dev_err(chg->dev, "Read VBUS_SNS error.\n");
> +		return;
> +	}
> +
> +	if (data & PF1550_VBUS_UVLO) {
> +		dev_dbg(chg->dev, "VBUS detached.\n");
> +		power_supply_changed(chg->battery);
> +	}
> +	if (data & PF1550_VBUS_IN2SYS)
> +		dev_dbg(chg->dev, "VBUS_IN2SYS_SNS.\n");
> +	if (data & PF1550_VBUS_OVLO)
> +		dev_dbg(chg->dev, "VBUS_OVLO_SNS.\n");
> +	if (data & PF1550_VBUS_VALID) {
> +		dev_dbg(chg->dev, "VBUS attached.\n");
> +		power_supply_changed(chg->charger);
> +	}
> +}
> +
> +static irqreturn_t pf1550_charger_irq_handler(int irq, void *data)
> +{
> +	struct pf1550_charger *chg =3D data;
> +	struct device *dev =3D chg->dev;
> +	int i, irq_type =3D -1;
> +
> +	for (i =3D 0; i < PF1550_CHARGER_IRQ_NR; i++)
> +		if (irq =3D=3D chg->virqs[i])
> +			irq_type =3D i;
> +
> +	switch (irq_type) {
> +	case PF1550_CHARG_IRQ_BAT2SOCI:
> +		dev_info(dev, "BAT to SYS Overcurrent interrupt.\n");
> +		break;
> +	case PF1550_CHARG_IRQ_BATI:
> +		schedule_delayed_work(&chg->bat_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_CHGI:
> +		schedule_delayed_work(&chg->chg_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_VBUSI:
> +		schedule_delayed_work(&chg->vbus_sense_work,
> +				      msecs_to_jiffies(10));
> +		break;
> +	case PF1550_CHARG_IRQ_THMI:
> +		dev_info(dev, "Thermal interrupt.\n");
> +		break;
> +	default:
> +		dev_err(dev, "unknown interrupt occurred.\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static enum power_supply_property pf1550_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};

static enum power_supply_property pf1550_charger_props[] =3D {
	POWER_SUPPLY_PROP_ONLINE,
	POWER_SUPPLY_PROP_MODEL_NAME,
	POWER_SUPPLY_PROP_MANUFACTURER,
};

static enum power_supply_property pf1550_battery_props[] =3D {
	POWER_SUPPLY_PROP_STATUS,
	POWER_SUPPLY_PROP_CHARGE_TYPE,
	POWER_SUPPLY_PROP_HEALTH,
	POWER_SUPPLY_PROP_PRESENT,
	POWER_SUPPLY_PROP_MODEL_NAME,
	POWER_SUPPLY_PROP_MANUFACTURER,
};

> +
> +static int pf1550_charger_get_property(struct power_supply *psy,
> +				       enum power_supply_property psp,
> +				       union power_supply_propval *val)
> +{
> +	struct pf1550_charger *chg =3D power_supply_get_drvdata(psy);
> +	struct regmap *regmap =3D chg->pf1550->regmap;
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		ret =3D pf1550_get_charger_state(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_TYPE:
> +		ret =3D pf1550_get_charge_type(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		ret =3D pf1550_get_battery_health(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret =3D pf1550_get_present(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D pf1550_get_online(regmap, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		val->strval =3D "PF1550";
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D "NXP";
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct power_supply_desc pf1550_charger_desc =3D {
> +	.name =3D "pf1550-charger",
> +	.type =3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties =3D pf1550_charger_props,
> +	.num_properties =3D ARRAY_SIZE(pf1550_charger_props),
> +	.get_property =3D pf1550_charger_get_property,
> +};
> +
> +static const struct power_supply_desc pf1550_battery_desc =3D {
> +	.name =3D "pf1550-battery",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D pf1550_charger_props,
> +	.num_properties =3D ARRAY_SIZE(pf1550_charger_props),

	.properties =3D pf1550_battery_props,
	.num_properties =3D ARRAY_SIZE(pf1550_battery_props),

Otherwise LGTM.

Greetings,

-- Sebastian

> +	.get_property =3D pf1550_charger_get_property,
> +};
> +
> +static int pf1550_set_constant_volt(struct pf1550_charger *chg,
> +				    unsigned int uvolt)
> +{
> +	unsigned int data;
> +
> +	if (uvolt >=3D 3500000 && uvolt <=3D 4440000)
> +		data =3D 8 + (uvolt - 3500000) / 20000;
> +	else
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for constant voltage\n");
> +
> +	dev_dbg(chg->dev, "Charging constant voltage: %u (0x%x)\n", uvolt,
> +		data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_BATT_REG,
> +				  PF1550_CHARG_REG_BATT_REG_CHGCV_MASK, data);
> +}
> +
> +static int pf1550_set_min_system_volt(struct pf1550_charger *chg,
> +				      unsigned int uvolt)
> +{
> +	unsigned int data;
> +
> +	switch (uvolt) {
> +	case 3500000:
> +		data =3D 0x0;
> +		break;
> +	case 3700000:
> +		data =3D 0x1;
> +		break;
> +	case 4300000:
> +		data =3D 0x2;
> +		break;
> +	default:
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for minimum system voltage\n");
> +	}
> +
> +	data <<=3D PF1550_CHARG_REG_BATT_REG_VMINSYS_SHIFT;
> +
> +	dev_dbg(chg->dev, "Minimum system regulation voltage: %u (0x%x)\n",
> +		uvolt, data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_BATT_REG,
> +				  PF1550_CHARG_REG_BATT_REG_VMINSYS_MASK, data);
> +}
> +
> +static int pf1550_set_thermal_regulation_temp(struct pf1550_charger *chg,
> +					      unsigned int cells)
> +{
> +	unsigned int data;
> +
> +	switch (cells) {
> +	case 80:
> +		data =3D 0x0;
> +		break;
> +	case 95:
> +		data =3D 0x1;
> +		break;
> +	case 110:
> +		data =3D 0x2;
> +		break;
> +	case 125:
> +		data =3D 0x3;
> +		break;
> +	default:
> +		return dev_err_probe(chg->dev, -EINVAL,
> +				     "Wrong value for thermal temperature\n");
> +	}
> +
> +	data <<=3D PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_SHIFT;
> +
> +	dev_dbg(chg->dev, "Thermal regulation loop temperature: %u (0x%x)\n",
> +		cells, data);
> +
> +	return regmap_update_bits(chg->pf1550->regmap,
> +				  PF1550_CHARG_REG_THM_REG_CNFG,
> +				  PF1550_CHARG_REG_THM_REG_CNFG_REGTEMP_MASK,
> +				  data);
> +}
> +
> +/*
> + * Sets charger registers to proper and safe default values.
> + */
> +static int pf1550_reg_init(struct pf1550_charger *chg)
> +{
> +	struct power_supply_battery_info *info;
> +	struct device *dev =3D chg->dev;
> +	int ret;
> +
> +	/* Unmask charger interrupt, mask DPMI and reserved bit */
> +	ret =3D  regmap_write(chg->pf1550->regmap, PF1550_CHARG_REG_CHG_INT_MAS=
K,
> +			    PF1550_CHG_INT_MASK);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Error unmask charger interrupt\n");
> +
> +	ret =3D pf1550_set_constant_volt(chg, chg->constant_volt);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pf1550_set_min_system_volt(chg, chg->min_system_volt);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D pf1550_set_thermal_regulation_temp(chg,
> +						 chg->thermal_regulation_temp);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The PF1550 charger has 3 modes of operation. By default, the charger
> +	 * is in mode 1; it remains off. Appropriate for applications not using
> +	 * a battery. The other supported mode is mode 2, the charger is turned
> +	 * on to charge a battery when present.
> +	 */
> +	if (power_supply_get_battery_info(chg->charger, &info)) {
> +		ret =3D regmap_write(chg->pf1550->regmap,
> +				   PF1550_CHARG_REG_CHG_OPER,
> +				   PF1550_CHG_BAT_ON);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "Error turn on charger\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void pf1550_dt_parse_dev_info(struct pf1550_charger *chg)
> +{
> +	struct power_supply_battery_info *info;
> +	struct device *dev =3D chg->dev;
> +
> +	if (device_property_read_u32(dev->parent, "nxp,min-system-microvolt",
> +				     &chg->min_system_volt))
> +		chg->min_system_volt =3D PF1550_DEFAULT_MIN_SYSTEM_VOLT;
> +
> +	if (device_property_read_u32(dev->parent,
> +				     "nxp,thermal-regulation-celsius",
> +				     &chg->thermal_regulation_temp))
> +		chg->thermal_regulation_temp =3D PF1550_DEFAULT_THERMAL_TEMP;
> +
> +	if (power_supply_get_battery_info(chg->charger, &info))
> +		chg->constant_volt =3D PF1550_DEFAULT_CONSTANT_VOLT;
> +	else
> +		chg->constant_volt =3D info->constant_charge_voltage_max_uv;
> +}
> +
> +static int pf1550_charger_probe(struct platform_device *pdev)
> +{
> +	const struct pf1550_ddata *pf1550 =3D dev_get_drvdata(pdev->dev.parent);
> +	struct power_supply_config psy_cfg =3D {};
> +	struct pf1550_charger *chg;
> +	int i, irq, ret;
> +
> +	chg =3D devm_kzalloc(&pdev->dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return -ENOMEM;
> +
> +	chg->dev =3D &pdev->dev;
> +	chg->pf1550 =3D pf1550;
> +
> +	if (!chg->pf1550->regmap)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get regmap\n");
> +
> +	platform_set_drvdata(pdev, chg);
> +
> +	ret =3D devm_delayed_work_autocancel(chg->dev, &chg->vbus_sense_work,
> +					   pf1550_chg_vbus_work);
> +	if (ret)
> +		return dev_err_probe(chg->dev, ret,
> +				     "failed to add vbus sense work\n");
> +
> +	ret =3D devm_delayed_work_autocancel(chg->dev, &chg->chg_sense_work,
> +					   pf1550_chg_chg_work);
> +	if (ret)
> +		return dev_err_probe(chg->dev, ret,
> +				     "failed to add charger sense work\n");
> +
> +	ret =3D devm_delayed_work_autocancel(chg->dev, &chg->bat_sense_work,
> +					   pf1550_chg_bat_work);
> +	if (ret)
> +		return dev_err_probe(chg->dev, ret,
> +				     "failed to add battery sense work\n");
> +
> +	for (i =3D 0; i < PF1550_CHARGER_IRQ_NR; i++) {
> +		irq =3D platform_get_irq(pdev, i);
> +		if (irq < 0)
> +			return irq;
> +
> +		chg->virqs[i] =3D irq;
> +
> +		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						pf1550_charger_irq_handler,
> +						IRQF_NO_SUSPEND,
> +						"pf1550-charger", chg);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "failed irq request\n");
> +	}
> +
> +	psy_cfg.drv_data =3D chg;
> +
> +	chg->charger =3D devm_power_supply_register(&pdev->dev,
> +						  &pf1550_charger_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(chg->charger))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->charger),
> +				     "failed: power supply register\n");
> +
> +	chg->battery =3D devm_power_supply_register(&pdev->dev,
> +						  &pf1550_battery_desc,
> +						  &psy_cfg);
> +	if (IS_ERR(chg->battery))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(chg->battery),
> +				     "failed: power supply register\n");
> +
> +	pf1550_dt_parse_dev_info(chg);
> +
> +	return pf1550_reg_init(chg);
> +}
> +
> +static const struct platform_device_id pf1550_charger_id[] =3D {
> +	{ "pf1550-charger", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(platform, pf1550_charger_id);
> +
> +static struct platform_driver pf1550_charger_driver =3D {
> +	.driver =3D {
> +		.name	=3D "pf1550-charger",
> +	},
> +	.probe		=3D pf1550_charger_probe,
> +	.id_table	=3D pf1550_charger_id,
> +};
> +module_platform_driver(pf1550_charger_driver);
> +
> +MODULE_AUTHOR("Robin Gong <yibin.gong@freescale.com>");
> +MODULE_DESCRIPTION("PF1550 charger driver");
> +MODULE_LICENSE("GPL");
>=20
> --=20
> 2.50.1
>=20
>=20

--z3jqxina4zvlvmw5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJqSUACgkQ2O7X88g7
+poZ3xAApUst260d8X8CwL+o+l/w/TKWGg202/2J9suh/ALKPORi/wv7aVJ1Ris3
wCUnpg2cj0V27rUustU7iTPOTw9eS/x30g8jADkafFsuA/Y+2Xh+Q9WQBOeOfFeP
/HUuDoL23uh5mV05V8QKb8y/IlQN8i3x96NWQILpuJPoCQ4N7bomyOMirKgeXP3q
UvONIVWYIzgRejENDhxk7zGDBj4gCksR0ngD9u/5kzXHG7/R8sGtXLwcTng6OTGL
+1f4MOnpSgOBJ3KBLE07f96mN6sJru3fLCyevWHDwVDCN1vyhbQPrmGS1kZ/7hsl
2q86U0NiWE8pLnxOPac6/YsLpMRUVSkgRmxdJxJRIpeZU1/43tUhpthjs22Is6JS
FBREsA0ajkFPj1wpvDMV228y86chi4+bcMZaDB81Fz1FX1g71nERl9U92dMLmwbG
KVnhGcpgvWtohlGxKbXpk6iWfINLEpAbisKBg5zHGT36FnX17NZWLcD9+y3X6mSG
k0MF+5CapIQvVDDpI36cLWgm5FhNAjc5VY5P1b7ZiBPIsFwmXS0VmmUNEwfBbxW/
Ixu2PE34FTQM5YNxhNXVqmAzZnSolcKKaLCVUA4laF88tbYBfnN8DNJ+dtBwGsa7
6uWpsMdu7PFULF/0fLMoJLDyWE+VJDoEPQfKegA7NpmmsdEs6Xg=
=h6Aa
-----END PGP SIGNATURE-----

--z3jqxina4zvlvmw5--

