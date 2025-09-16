Return-Path: <linux-pm+bounces-34745-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B177B59F96
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 19:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71F92A1917
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 17:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96272F5A29;
	Tue, 16 Sep 2025 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="jK2F053m"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40EF253359;
	Tue, 16 Sep 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758044425; cv=pass; b=m9GF307p0ekbezbLciClaxTGT9Jh8Y1R6f+AlFDDvQ079PxwfG0Rga3LkazkhCB+GkWLz2l2/B05G1GUl+WZS7Znq6hozV+l3hTDnCVSzoyTX1Ez1wIwXWy8C1d14TcNNPE0xQmvjP6n0XzDDIZpoa93cls13G2I39dSg7LY3Q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758044425; c=relaxed/simple;
	bh=2ZMO1BTu8i1H+WanmMBe931OkKvn1164J14tUHXHh8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9uhgAI0auuYQ7uRg66k7KboiNV9sXKh/5EcoyPpcljo+UQqr7bAzbfvfCIKBsMlEEzZdrJvoCWPdZyZyRowZvU/tFNBGcUOZunvnsRmFxhfJMn+Hl5Y4BF6PsFS7m++ojoXUymR4TVkIEGaFW+t0ODk9pal2GJ10c882oRGE28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=jK2F053m; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758044411; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VNZXgMTTT8ZCyN6LnvCpbzUIZzgP7jvBIlJRPj3+yxR6GyQcO+I99/yVKvmNGpk93OhHRQznzVtvcb24kig+tbRYkRVRjCTAwNo/vG70hTyX4AV+F7JZmn3juJ2AwxjwcfhVDrE+RyxuJs/fAjqMyKBFmwPSwk4HJ1WiHwZb1KM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758044411; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YEfROqc7ufKPEc9X89kAi/0BYTqg4AOYbLA7MaX7MoI=; 
	b=jpD5GLaZL12rPfh5R58jlTOh5+LvXmXnCQggTESJq5kM3eR7qQko0if+KkU1QsivCeHDomhN2vigJH86c0IvgH/uxFmIZMwf5NwEB/YLx1ZqUPOmr+tCh3gJ4Y8zy2SyrNDknTmB9lh9N3A1701r89CcitcKoqTWSO7y7r0+Sww=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758044410;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=YEfROqc7ufKPEc9X89kAi/0BYTqg4AOYbLA7MaX7MoI=;
	b=jK2F053mT/ZxfeneFC8pyaZJ5f+I4aQPhExRyDFic5loAlKhF9k/5WQbzp3xFPBu
	x2Evc2YJNZceGWfkZHau/sfb3IUyHVm1Lic23knyiVasirXfasBKHX9bHpl/QN8JyRK
	MVIWrO8YO6BK05OP7ul3IIiwsn97zI/6SR9CtE6g=
Received: by mx.zohomail.com with SMTPS id 1758044409192177.09661106026954;
	Tue, 16 Sep 2025 10:40:09 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4A9A1180733; Tue, 16 Sep 2025 19:39:56 +0200 (CEST)
Date: Tue, 16 Sep 2025 19:39:56 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/3] power: supply: Add bd718(15/28/78) charger driver
Message-ID: <kdpvkabvjqcghdlu5hwxiqzh24xfu7w6kyjvli3t2jobgozkid@bleneayeomut>
References: <20250821-bd71828-charger-v3-0-cc74ac4e0fb9@kemnade.info>
 <20250821-bd71828-charger-v3-2-cc74ac4e0fb9@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2xdwud5lf64kpph"
Content-Disposition: inline
In-Reply-To: <20250821-bd71828-charger-v3-2-cc74ac4e0fb9@kemnade.info>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--d2xdwud5lf64kpph
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] power: supply: Add bd718(15/28/78) charger driver
MIME-Version: 1.0

Hi,

On Thu, Aug 21, 2025 at 08:23:35PM +0200, Andreas Kemnade wrote:
> Add charger driver for ROHM BD718(15/28/78) PMIC charger block.
> It is a stripped down version of the driver here:
> https://lore.kernel.org/lkml/dbd97c1b0d715aa35a8b4d79741e433d97c562aa.163=
7061794.git.matti.vaittinen@fi.rohmeurope.com/
>=20
> For the ease of review and to do a step-by-step approach remove all the
> coloumb counter related stuff and do not sneak in BD71827 support. That
> also avoids non-trivial rebasing of the above series.
>=20
> Changes besides that:
> Replace the custom property by a standard one and do not use megaohms
> for the current sense resistor.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> ---
>  drivers/power/supply/Kconfig         |    9 +
>  drivers/power/supply/Makefile        |    1 +
>  drivers/power/supply/bd71828-power.c | 1060 ++++++++++++++++++++++++++++=
++++++
>  3 files changed, 1070 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 79ddb006e2dad..16dddb2355d9b 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -974,6 +974,15 @@ config CHARGER_UCS1002
>  	  Say Y to enable support for Microchip UCS1002 Programmable
>  	  USB Port Power Controller with Charger Emulation.
> =20
> +config CHARGER_BD71828
> +	tristate "Power-supply driver for ROHM BD71828 and BD71815 PMIC"
> +	depends on MFD_ROHM_BD71828
> +	help
> +	  Say Y here to enable support for charger and battery
> +	  in ROHM BD71815, BD71817, ROHM BD71828 power management
> +	  ICs. This driver gets various bits of information about battery
> +	  and charger states.
> +
>  config CHARGER_BD99954
>  	tristate "ROHM bd99954 charger driver"
>  	depends on I2C
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index f943c9150b326..c6520a11f021c 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -113,6 +113,7 @@ obj-$(CONFIG_CHARGER_SC2731)	+=3D sc2731_charger.o
>  obj-$(CONFIG_FUEL_GAUGE_SC27XX)	+=3D sc27xx_fuel_gauge.o
>  obj-$(CONFIG_FUEL_GAUGE_STC3117)       +=3D stc3117_fuel_gauge.o
>  obj-$(CONFIG_CHARGER_UCS1002)	+=3D ucs1002_power.o
> +obj-$(CONFIG_CHARGER_BD71828)	+=3D bd71828-power.o
>  obj-$(CONFIG_CHARGER_BD99954)	+=3D bd99954-charger.o
>  obj-$(CONFIG_CHARGER_WILCO)	+=3D wilco-charger.o
>  obj-$(CONFIG_RN5T618_POWER)	+=3D rn5t618_power.o
> diff --git a/drivers/power/supply/bd71828-power.c b/drivers/power/supply/=
bd71828-power.c
> new file mode 100644
> index 0000000000000..8f7ece6837df8
> --- /dev/null
> +++ b/drivers/power/supply/bd71828-power.c
> @@ -0,0 +1,1060 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * bd71828-power.c

Drop the filename, it's not helpful and just something that people
forget to update when it is being moved.

> + * @file ROHM BD71815, BD71828 and BD71878 Charger driver

@file ?

> + *
> + * Copyright 2021.

Copyright from whom? A copyright notice without the copyright owner
is pointless.

> + */
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/rohm-bd71815.h>
> +#include <linux/mfd/rohm-bd71828.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/power_supply.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +
> +/* common defines */
> +#define BD7182x_MASK_VBAT_U			0x1f
> +#define BD7182x_MASK_VDCIN_U			0x0f
> +#define BD7182x_MASK_IBAT_U			0x3f
> +#define BD7182x_MASK_CURDIR_DISCHG		0x80
> +#define BD7182x_MASK_CHG_STATE			0x7f
> +#define BD7182x_MASK_BAT_TEMP			0x07
> +#define BD7182x_MASK_DCIN_DET			BIT(0)
> +#define BD7182x_MASK_CONF_PON			BIT(0)
> +#define BD71815_MASK_CONF_XSTB			BIT(1)
> +#define BD7182x_MASK_BAT_STAT			0x3f
> +#define BD7182x_MASK_DCIN_STAT			0x07
> +
> +#define BD7182x_MASK_WDT_AUTO			0x40
> +#define BD7182x_MASK_VBAT_ALM_LIMIT_U		0x01
> +#define BD7182x_MASK_CHG_EN			0x01
> +
> +#define BD7182x_DCIN_COLLAPSE_DEFAULT		0x36
> +
> +#define MAX_CURRENT_DEFAULT			890000		/* uA */
> +#define AC_NAME					"bd71828_ac"
> +#define BAT_NAME				"bd71828_bat"
> +
> +/*
> + * VBAT Low voltage detection Threshold
> + * 0x00D4*16mV =3D 212*0.016 =3D 3.392v
> + */
> +#define VBAT_LOW_TH			0x00D4
> +
> +struct pwr_regs {
> +	u8 vbat_avg;
> +	u8 ibat;
> +	u8 ibat_avg;
> +	u8 btemp_vth;
> +	u8 chg_state;
> +	u8 bat_temp;
> +	u8 dcin_stat;
> +	u8 dcin_collapse_limit;
> +	u8 chg_set1;
> +	u8 chg_en;
> +	u8 vbat_alm_limit_u;
> +	u8 conf;
> +	u8 vdcin;
> +};
> +
> +static const struct pwr_regs pwr_regs_bd71828 =3D {
> +	.vbat_avg =3D BD71828_REG_VBAT_U,
> +	.ibat =3D BD71828_REG_IBAT_U,
> +	.ibat_avg =3D BD71828_REG_IBAT_AVG_U,
> +	.btemp_vth =3D BD71828_REG_VM_BTMP_U,
> +	.chg_state =3D BD71828_REG_CHG_STATE,
> +	.bat_temp =3D BD71828_REG_BAT_TEMP,
> +	.dcin_stat =3D BD71828_REG_DCIN_STAT,
> +	.dcin_collapse_limit =3D BD71828_REG_DCIN_CLPS,
> +	.chg_set1 =3D BD71828_REG_CHG_SET1,
> +	.chg_en   =3D BD71828_REG_CHG_EN,
> +	.vbat_alm_limit_u =3D BD71828_REG_ALM_VBAT_LIMIT_U,
> +	.conf =3D BD71828_REG_CONF,
> +	.vdcin =3D BD71828_REG_VDCIN_U,
> +};
> +
> +static const struct pwr_regs pwr_regs_bd71815 =3D {
> +	.vbat_avg =3D BD71815_REG_VM_SA_VBAT_U,
> +	/* BD71815 does not have separate current and current avg */
> +	.ibat =3D BD71815_REG_CC_CURCD_U,
> +	.ibat_avg =3D BD71815_REG_CC_CURCD_U,
> +
> +	.btemp_vth =3D BD71815_REG_VM_BTMP,
> +	.chg_state =3D BD71815_REG_CHG_STATE,
> +	.bat_temp =3D BD71815_REG_BAT_TEMP,
> +	.dcin_stat =3D BD71815_REG_DCIN_STAT,
> +	.dcin_collapse_limit =3D BD71815_REG_DCIN_CLPS,
> +	.chg_set1 =3D BD71815_REG_CHG_SET1,
> +	.chg_en   =3D BD71815_REG_CHG_SET1,
> +	.vbat_alm_limit_u =3D BD71815_REG_ALM_VBAT_TH_U,
> +	.conf =3D BD71815_REG_CONF,
> +
> +	.vdcin =3D BD71815_REG_VM_DCIN_U,
> +};
> +
> +struct bd71828_power {
> +	struct regmap *regmap;
> +	enum rohm_chip_type chip_type;
> +	struct device *dev;
> +	struct power_supply *ac;
> +	struct power_supply *bat;
> +
> +	const struct pwr_regs *regs;
> +	/* Reg val to uA */
> +	int curr_factor;
> +	int rsens;
> +	int (*get_temp)(struct bd71828_power *pwr, int *temp);
> +	int (*bat_inserted)(struct bd71828_power *pwr);
> +};
> +
> +static int bd7182x_write16(struct bd71828_power *pwr, int reg, u16 val)
> +{
> +	__be16 tmp;
> +
> +	tmp =3D cpu_to_be16(val);
> +
> +	return regmap_bulk_write(pwr->regmap, reg, &tmp, sizeof(tmp));
> +}
> +
> +static int bd7182x_read16_himask(struct bd71828_power *pwr, int reg, int=
 himask,
> +				 u16 *val)
> +{
> +	struct regmap *regmap =3D pwr->regmap;
> +	int ret;
> +	__be16 rvals;
> +	u8 *tmp =3D (u8 *)&rvals;
> +
> +	ret =3D regmap_bulk_read(regmap, reg, &rvals, sizeof(*val));
> +	if (!ret) {
> +		*tmp &=3D himask;
> +		*val =3D be16_to_cpu(rvals);
> +	}
> +
> +	return ret;
> +}
> +
> +static int bd71828_get_vbat(struct bd71828_power *pwr, int *vcell)
> +{
> +	u16 tmp_vcell;
> +	int ret;
> +
> +	ret =3D bd7182x_read16_himask(pwr, pwr->regs->vbat_avg,
> +				    BD7182x_MASK_VBAT_U, &tmp_vcell);
> +	if (ret)
> +		dev_err(pwr->dev, "Failed to read battery average voltage\n");
> +	else
> +		*vcell =3D ((int)tmp_vcell) * 1000;
> +
> +	return ret;
> +}
> +
> +static int bd71828_get_current_ds_adc(struct bd71828_power *pwr, int *cu=
rr, int *curr_avg)
> +{
> +	__be16 tmp_curr;
> +	char *tmp =3D (char *)&tmp_curr;
> +	int dir =3D 1;
> +	int regs[] =3D { pwr->regs->ibat, pwr->regs->ibat_avg };
> +	int *vals[] =3D { curr, curr_avg };
> +	int ret, i;
> +
> +	for (dir =3D 1, i =3D 0; i < ARRAY_SIZE(regs); i++) {
> +		ret =3D regmap_bulk_read(pwr->regmap, regs[i], &tmp_curr,
> +				       sizeof(tmp_curr));
> +		if (ret)
> +			break;
> +
> +		if (*tmp & BD7182x_MASK_CURDIR_DISCHG)
> +			dir =3D -1;
> +
> +		*tmp &=3D BD7182x_MASK_IBAT_U;
> +
> +		*vals[i] =3D dir * ((int)be16_to_cpu(tmp_curr)) * pwr->curr_factor;
> +	}
> +
> +	return ret;
> +}
> +
> +/* Unit is tenths of degree C */
> +static int bd71815_get_temp(struct bd71828_power *pwr, int *temp)
> +{
> +	struct regmap *regmap =3D pwr->regmap;
> +	int ret;
> +	int t;
> +
> +	ret =3D regmap_read(regmap, pwr->regs->btemp_vth, &t);
> +	if (ret)
> +		return ret;
> +
> +	t =3D 200 - t;
> +
> +	if (t > 200) {
> +		dev_err(pwr->dev, "Failed to read battery temperature\n");
> +		return -ENODATA;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Unit is tenths of degree C */
> +static int bd71828_get_temp(struct bd71828_power *pwr, int *temp)
> +{
> +	u16 t;
> +	int ret;
> +	int tmp =3D 200 * 10000;
> +
> +	ret =3D bd7182x_read16_himask(pwr, pwr->regs->btemp_vth,
> +				    BD71828_MASK_VM_BTMP_U, &t);
> +	if (ret)
> +		return ret;
> +
> +	if (t > 3200) {
> +		dev_err(pwr->dev,
> +			"Failed to read battery temperature\n");
> +		return -ENODATA;
> +	}
> +
> +	tmp -=3D 625ULL * (unsigned int)t;
> +	*temp =3D tmp / 1000;
> +
> +	return ret;
> +}
> +
> +static int bd71828_charge_status(struct bd71828_power *pwr,
> +				 int *s, int *h)
> +{
> +	unsigned int state;
> +	int status, health;
> +	int ret =3D 1;
> +
> +	ret =3D regmap_read(pwr->regmap, pwr->regs->chg_state, &state);
> +	if (ret) {
> +		dev_err(pwr->dev, "charger status reading failed (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	state &=3D BD7182x_MASK_CHG_STATE;
> +
> +	dev_dbg(pwr->dev, "CHG_STATE %d\n", state);
> +
> +	switch (state) {
> +	case 0x00:
> +		ret =3D 0;
> +		status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		health =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x01:
> +	case 0x02:
> +	case 0x03:
> +	case 0x0E:

no ret =3D 0? I guess this works, since ret must be 0 anyways before
reaching the switch statement. So just remove all of them :)

> +		status =3D POWER_SUPPLY_STATUS_CHARGING;
> +		health =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x0F:
> +		ret =3D 0;
> +		status =3D POWER_SUPPLY_STATUS_FULL;
> +		health =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x10:
> +	case 0x11:
> +	case 0x12:
> +	case 0x13:
> +	case 0x14:
> +	case 0x20:
> +	case 0x21:
> +	case 0x22:
> +	case 0x23:
> +	case 0x24:
> +		ret =3D 0;
> +		status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		health =3D POWER_SUPPLY_HEALTH_OVERHEAT;
> +		break;
> +	case 0x30:
> +	case 0x31:
> +	case 0x32:
> +	case 0x40:
> +		ret =3D 0;
> +		status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> +		health =3D POWER_SUPPLY_HEALTH_GOOD;
> +		break;
> +	case 0x7f:
> +	default:
> +		ret =3D 0;
> +		status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> +		health =3D POWER_SUPPLY_HEALTH_DEAD;
> +		break;
> +	}
> +
> +	if (s)
> +		*s =3D status;
> +	if (h)
> +		*h =3D health;
> +
> +	return ret;
> +}
> +
> +static int get_chg_online(struct bd71828_power *pwr, int *chg_online)
> +{
> +	int r, ret;
> +
> +	ret =3D regmap_read(pwr->regmap, pwr->regs->dcin_stat, &r);
> +	if (ret) {
> +		dev_err(pwr->dev, "Failed to read DCIN status\n");
> +		return ret;
> +	}
> +	*chg_online =3D ((r & BD7182x_MASK_DCIN_DET) !=3D 0);
> +
> +	return 0;
> +}
> +
> +static int get_bat_online(struct bd71828_power *pwr, int *bat_online)
> +{
> +	int r, ret;
> +
> +#define BAT_OPEN	0x7

please don't define in the middle of the function. Use static const u8
instead, which is local to this function, or define it at the top
of the file.

Otherwise LGTM.

Greetings,

-- Sebastian

> +	ret =3D regmap_read(pwr->regmap, pwr->regs->bat_temp, &r);
> +	if (ret) {
> +		dev_err(pwr->dev, "Failed to read battery temperature\n");
> +		return ret;
> +	}
> +	*bat_online =3D ((r & BD7182x_MASK_BAT_TEMP) !=3D BAT_OPEN);
> +
> +	return 0;
> +}
> +
> +static int bd71828_bat_inserted(struct bd71828_power *pwr)
> +{
> +	int ret, val;
> +
> +	ret =3D regmap_read(pwr->regmap, pwr->regs->conf, &val);
> +	if (ret) {
> +		dev_err(pwr->dev, "Failed to read CONF register\n");
> +		return 0;
> +	}
> +	ret =3D val & BD7182x_MASK_CONF_PON;
> +
> +	if (ret)
> +		regmap_update_bits(pwr->regmap, pwr->regs->conf,
> +				   BD7182x_MASK_CONF_PON, 0);
> +
> +	return ret;
> +}
> +
> +static int bd71815_bat_inserted(struct bd71828_power *pwr)
> +{
> +	int ret, val;
> +
> +	ret =3D regmap_read(pwr->regmap, pwr->regs->conf, &val);
> +	if (ret) {
> +		dev_err(pwr->dev, "Failed to read CONF register\n");
> +		return ret;
> +	}
> +
> +	ret =3D !(val & BD71815_MASK_CONF_XSTB);
> +	if (ret)
> +		regmap_write(pwr->regmap, pwr->regs->conf,  val |
> +			     BD71815_MASK_CONF_XSTB);
> +
> +	return ret;
> +}
> +
> +static int bd71828_init_hardware(struct bd71828_power *pwr)
> +{
> +	int ret;
> +
> +	/* TODO: Collapse limit should come from device-tree ? */
> +	ret =3D regmap_write(pwr->regmap, pwr->regs->dcin_collapse_limit,
> +			   BD7182x_DCIN_COLLAPSE_DEFAULT);
> +	if (ret) {
> +		dev_err(pwr->dev, "Failed to write DCIN collapse limit\n");
> +		return ret;
> +	}
> +
> +	ret =3D pwr->bat_inserted(pwr);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret) {
> +		/* WDT_FST auto set */
> +		ret =3D regmap_update_bits(pwr->regmap, pwr->regs->chg_set1,
> +					 BD7182x_MASK_WDT_AUTO,
> +					 BD7182x_MASK_WDT_AUTO);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D bd7182x_write16(pwr, pwr->regs->vbat_alm_limit_u,
> +				      VBAT_LOW_TH);
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * On BD71815 "we mask the power-state" from relax detection.
> +		 * I am unsure what the impact of the power-state would be if
> +		 * we didn't - but this is what the vendor driver did - and
> +		 * that driver has been used in few projects so I just assume
> +		 * this is needed.
> +		 */
> +		if (pwr->chip_type =3D=3D ROHM_CHIP_TYPE_BD71815) {
> +			ret =3D regmap_set_bits(pwr->regmap,
> +					      BD71815_REG_REX_CTRL_1,
> +					      REX_PMU_STATE_MASK);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int bd71828_charger_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct bd71828_power *pwr =3D dev_get_drvdata(psy->dev.parent);
> +	u32 vot;
> +	u16 tmp;
> +	int online;
> +	int ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		ret =3D get_chg_online(pwr, &online);
> +		if (!ret)
> +			val->intval =3D online;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D bd7182x_read16_himask(pwr, pwr->regs->vdcin,
> +					    BD7182x_MASK_VDCIN_U, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		vot =3D tmp;
> +		/* 5 milli volt steps */
> +		val->intval =3D 5000 * vot;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int bd71828_battery_get_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					union power_supply_propval *val)
> +{
> +	struct bd71828_power *pwr =3D dev_get_drvdata(psy->dev.parent);
> +	int ret =3D 0;
> +	int status, health, tmp, curr, curr_avg, chg_en;
> +
> +	if (psp =3D=3D POWER_SUPPLY_PROP_STATUS ||
> +	    psp =3D=3D POWER_SUPPLY_PROP_HEALTH ||
> +	    psp =3D=3D POWER_SUPPLY_PROP_CHARGE_TYPE)
> +		ret =3D bd71828_charge_status(pwr, &status, &health);
> +	else if (psp =3D=3D POWER_SUPPLY_PROP_CURRENT_AVG ||
> +		 psp =3D=3D POWER_SUPPLY_PROP_CURRENT_NOW)
> +		ret =3D bd71828_get_current_ds_adc(pwr, &curr, &curr_avg);
> +	if (ret)
> +		return ret;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval =3D status;
> +		break;
> +	case POWER_SUPPLY_PROP_HEALTH:
> +		val->intval =3D health;
> +		break;
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		ret =3D get_bat_online(pwr, &tmp);
> +		if (!ret)
> +			val->intval =3D tmp;
> +		break;
> +	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
> +		ret =3D bd71828_get_vbat(pwr, &tmp);
> +		val->intval =3D tmp;
> +		break;
> +	case POWER_SUPPLY_PROP_TECHNOLOGY:
> +		val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		val->intval =3D curr_avg;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		val->intval =3D curr;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_MAX:
> +		val->intval =3D MAX_CURRENT_DEFAULT;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D pwr->get_temp(pwr, &val->intval);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		ret =3D regmap_read(pwr->regmap, pwr->regs->chg_en, &chg_en);
> +		if (ret)
> +			return ret;
> +
> +		val->intval =3D (chg_en & BD7182x_MASK_CHG_EN) ?
> +			POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO :
> +			POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bd71828_battery_set_property(struct power_supply *psy,
> +					enum power_supply_property psp,
> +					const union power_supply_propval *val)
> +{
> +	struct bd71828_power *pwr =3D dev_get_drvdata(psy->dev.parent);
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		if (val->intval =3D=3D POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
> +			ret =3D regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
> +						 BD7182x_MASK_CHG_EN,
> +						 BD7182x_MASK_CHG_EN);
> +		else
> +			ret =3D regmap_update_bits(pwr->regmap, pwr->regs->chg_en,
> +						 BD7182x_MASK_CHG_EN,
> +						 0);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int bd71828_battery_property_is_writeable(struct power_supply *ps=
y,
> +						 enum power_supply_property psp)
> +{
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/** @brief ac properties */
> +static const enum power_supply_property bd71828_charger_props[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +};
> +
> +static const enum power_supply_property bd71828_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_MAX,
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +};
> +
> +/** @brief powers supplied by bd71828_ac */
> +static char *bd71828_ac_supplied_to[] =3D {
> +	BAT_NAME,
> +};
> +
> +static const struct power_supply_desc bd71828_ac_desc =3D {
> +	.name		=3D AC_NAME,
> +	.type		=3D POWER_SUPPLY_TYPE_MAINS,
> +	.properties	=3D bd71828_charger_props,
> +	.num_properties	=3D ARRAY_SIZE(bd71828_charger_props),
> +	.get_property	=3D bd71828_charger_get_property,
> +};
> +
> +static const struct power_supply_desc bd71828_bat_desc =3D {
> +	.name		=3D BAT_NAME,
> +	.type		=3D POWER_SUPPLY_TYPE_BATTERY,
> +	.charge_behaviours =3D BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO) |
> +			     BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE),
> +	.properties	=3D bd71828_battery_props,
> +	.num_properties =3D ARRAY_SIZE(bd71828_battery_props),
> +	.get_property	=3D bd71828_battery_get_property,
> +	.set_property	=3D bd71828_battery_set_property,
> +	.property_is_writeable   =3D bd71828_battery_property_is_writeable,
> +};
> +
> +#define RSENS_CURR 10000000LLU
> +
> +#define BD_ISR_NAME(name) \
> +bd7181x_##name##_isr
> +
> +#define BD_ISR_BAT(name, print, run_gauge)				\
> +static irqreturn_t BD_ISR_NAME(name)(int irq, void *data)		\
> +{									\
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;	\
> +									\
> +	dev_dbg(pwr->dev, "%s\n", print);				\
> +	power_supply_changed(pwr->bat);				\
> +									\
> +	return IRQ_HANDLED;						\
> +}
> +
> +#define BD_ISR_AC(name, print, run_gauge)				\
> +static irqreturn_t BD_ISR_NAME(name)(int irq, void *data)		\
> +{									\
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;	\
> +									\
> +	power_supply_changed(pwr->ac);					\
> +	dev_dbg(pwr->dev, "%s\n", print);				\
> +	power_supply_changed(pwr->bat);				\
> +									\
> +	return IRQ_HANDLED;						\
> +}
> +
> +#define BD_ISR_DUMMY(name, print)					\
> +static irqreturn_t BD_ISR_NAME(name)(int irq, void *data)		\
> +{									\
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;	\
> +									\
> +	dev_dbg(pwr->dev, "%s\n", print);				\
> +									\
> +	return IRQ_HANDLED;						\
> +}
> +
> +BD_ISR_BAT(chg_state_changed, "CHG state changed", true)
> +/* DCIN voltage changes */
> +BD_ISR_AC(dcin_removed, "DCIN removed", true)
> +BD_ISR_AC(clps_out, "DCIN voltage back to normal", true)
> +BD_ISR_AC(clps_in, "DCIN voltage collapsed", false)
> +BD_ISR_AC(dcin_ovp_res, "DCIN voltage normal", true)
> +BD_ISR_AC(dcin_ovp_det, "DCIN OVER VOLTAGE", true)
> +
> +BD_ISR_DUMMY(dcin_mon_det, "DCIN voltage below threshold")
> +BD_ISR_DUMMY(dcin_mon_res, "DCIN voltage above threshold")
> +
> +BD_ISR_DUMMY(vsys_uv_res, "VSYS under-voltage cleared")
> +BD_ISR_DUMMY(vsys_uv_det, "VSYS under-voltage")
> +BD_ISR_DUMMY(vsys_low_res, "'VSYS low' cleared")
> +BD_ISR_DUMMY(vsys_low_det, "VSYS low")
> +BD_ISR_DUMMY(vsys_mon_res, "VSYS mon - resumed")
> +BD_ISR_DUMMY(vsys_mon_det, "VSYS mon - detected")
> +BD_ISR_BAT(chg_wdg_temp, "charger temperature watchdog triggered", true)
> +BD_ISR_BAT(chg_wdg, "charging watchdog triggered", true)
> +BD_ISR_BAT(bat_removed, "Battery removed", true)
> +BD_ISR_BAT(bat_det, "Battery detected", true)
> +/* TODO: Verify the meaning of these interrupts */
> +BD_ISR_BAT(rechg_det, "Recharging", true)
> +BD_ISR_BAT(rechg_res, "Recharge ending", true)
> +BD_ISR_DUMMY(temp_transit, "Temperature transition")
> +BD_ISR_BAT(therm_rmv, "bd71815-therm-rmv", false)
> +BD_ISR_BAT(therm_det, "bd71815-therm-det", true)
> +BD_ISR_BAT(bat_dead, "bd71815-bat-dead", false)
> +BD_ISR_BAT(bat_short_res, "bd71815-bat-short-res", true)
> +BD_ISR_BAT(bat_short, "bd71815-bat-short-det", false)
> +BD_ISR_BAT(bat_low_res, "bd71815-bat-low-res", true)
> +BD_ISR_BAT(bat_low, "bd71815-bat-low-det", true)
> +BD_ISR_BAT(bat_ov_res, "bd71815-bat-over-res", true)
> +/* What should we do here? */
> +BD_ISR_BAT(bat_ov, "bd71815-bat-over-det", false)
> +BD_ISR_BAT(bat_mon_res, "bd71815-bat-mon-res", true)
> +BD_ISR_BAT(bat_mon, "bd71815-bat-mon-det", true)
> +BD_ISR_BAT(bat_cc_mon, "bd71815-bat-cc-mon2", false)
> +BD_ISR_BAT(bat_oc1_res, "bd71815-bat-oc1-res", true)
> +BD_ISR_BAT(bat_oc1, "bd71815-bat-oc1-det", false)
> +BD_ISR_BAT(bat_oc2_res, "bd71815-bat-oc2-res", true)
> +BD_ISR_BAT(bat_oc2, "bd71815-bat-oc2-det", false)
> +BD_ISR_BAT(bat_oc3_res, "bd71815-bat-oc3-res", true)
> +BD_ISR_BAT(bat_oc3, "bd71815-bat-oc3-det", false)
> +BD_ISR_BAT(temp_bat_low_res, "bd71815-temp-bat-low-res", true)
> +BD_ISR_BAT(temp_bat_low, "bd71815-temp-bat-low-det", true)
> +BD_ISR_BAT(temp_bat_hi_res, "bd71815-temp-bat-hi-res", true)
> +BD_ISR_BAT(temp_bat_hi, "bd71815-temp-bat-hi-det", true)
> +
> +static irqreturn_t bd7182x_dcin_removed(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	power_supply_changed(pwr->ac);
> +	dev_dbg(pwr->dev, "DCIN removed\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd718x7_chg_done(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd7182x_dcin_detected(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "DCIN inserted\n");
> +	power_supply_changed(pwr->ac);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_vbat_low_res(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "VBAT LOW Resumed\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_vbat_low_det(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "VBAT LOW Detected\n");
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_bat_hi_det(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_warn(pwr->dev, "Overtemp Detected\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_bat_hi_res(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "Overtemp Resumed\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_bat_low_det(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "Lowtemp Detected\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_bat_low_res(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "Lowtemp Resumed\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_vf_det(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "VF Detected\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_vf_res(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "VF Resumed\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_vf125_det(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "VF125 Detected\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t bd71828_temp_vf125_res(int irq, void *data)
> +{
> +	struct bd71828_power *pwr =3D (struct bd71828_power *)data;
> +
> +	dev_dbg(pwr->dev, "VF125 Resumed\n");
> +	power_supply_changed(pwr->bat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +struct bd7182x_irq_res {
> +	const char *name;
> +	irq_handler_t handler;
> +};
> +
> +#define BDIRQ(na, hn) { .name =3D (na), .handler =3D (hn) }
> +
> +static int bd7182x_get_irqs(struct platform_device *pdev,
> +			    struct bd71828_power *pwr)
> +{
> +	int i, irq, ret;
> +	static const struct bd7182x_irq_res bd71815_irqs[] =3D {
> +		BDIRQ("bd71815-dcin-rmv", BD_ISR_NAME(dcin_removed)),
> +		BDIRQ("bd71815-dcin-clps-out", BD_ISR_NAME(clps_out)),
> +		BDIRQ("bd71815-dcin-clps-in", BD_ISR_NAME(clps_in)),
> +		BDIRQ("bd71815-dcin-ovp-res", BD_ISR_NAME(dcin_ovp_res)),
> +		BDIRQ("bd71815-dcin-ovp-det", BD_ISR_NAME(dcin_ovp_det)),
> +		BDIRQ("bd71815-dcin-mon-res", BD_ISR_NAME(dcin_mon_res)),
> +		BDIRQ("bd71815-dcin-mon-det", BD_ISR_NAME(dcin_mon_det)),
> +
> +		BDIRQ("bd71815-vsys-uv-res", BD_ISR_NAME(vsys_uv_res)),
> +		BDIRQ("bd71815-vsys-uv-det", BD_ISR_NAME(vsys_uv_det)),
> +		BDIRQ("bd71815-vsys-low-res", BD_ISR_NAME(vsys_low_res)),
> +		BDIRQ("bd71815-vsys-low-det",  BD_ISR_NAME(vsys_low_det)),
> +		BDIRQ("bd71815-vsys-mon-res",  BD_ISR_NAME(vsys_mon_res)),
> +		BDIRQ("bd71815-vsys-mon-det",  BD_ISR_NAME(vsys_mon_det)),
> +		BDIRQ("bd71815-chg-wdg-temp", BD_ISR_NAME(chg_wdg_temp)),
> +		BDIRQ("bd71815-chg-wdg",  BD_ISR_NAME(chg_wdg)),
> +		BDIRQ("bd71815-rechg-det", BD_ISR_NAME(rechg_det)),
> +		BDIRQ("bd71815-rechg-res", BD_ISR_NAME(rechg_res)),
> +		BDIRQ("bd71815-ranged-temp-transit", BD_ISR_NAME(temp_transit)),
> +		BDIRQ("bd71815-chg-state-change", BD_ISR_NAME(chg_state_changed)),
> +		BDIRQ("bd71815-bat-temp-normal", bd71828_temp_bat_hi_res),
> +		BDIRQ("bd71815-bat-temp-erange", bd71828_temp_bat_hi_det),
> +		BDIRQ("bd71815-bat-rmv", BD_ISR_NAME(bat_removed)),
> +		BDIRQ("bd71815-bat-det", BD_ISR_NAME(bat_det)),
> +
> +		/* Add ISRs for these */
> +		BDIRQ("bd71815-therm-rmv", BD_ISR_NAME(therm_rmv)),
> +		BDIRQ("bd71815-therm-det", BD_ISR_NAME(therm_det)),
> +		BDIRQ("bd71815-bat-dead", BD_ISR_NAME(bat_dead)),
> +		BDIRQ("bd71815-bat-short-res", BD_ISR_NAME(bat_short_res)),
> +		BDIRQ("bd71815-bat-short-det", BD_ISR_NAME(bat_short)),
> +		BDIRQ("bd71815-bat-low-res", BD_ISR_NAME(bat_low_res)),
> +		BDIRQ("bd71815-bat-low-det", BD_ISR_NAME(bat_low)),
> +		BDIRQ("bd71815-bat-over-res", BD_ISR_NAME(bat_ov_res)),
> +		BDIRQ("bd71815-bat-over-det", BD_ISR_NAME(bat_ov)),
> +		BDIRQ("bd71815-bat-mon-res", BD_ISR_NAME(bat_mon_res)),
> +		BDIRQ("bd71815-bat-mon-det", BD_ISR_NAME(bat_mon)),
> +		/* cc-mon 1 & 3 ? */
> +		BDIRQ("bd71815-bat-cc-mon2", BD_ISR_NAME(bat_cc_mon)),
> +		BDIRQ("bd71815-bat-oc1-res", BD_ISR_NAME(bat_oc1_res)),
> +		BDIRQ("bd71815-bat-oc1-det", BD_ISR_NAME(bat_oc1)),
> +		BDIRQ("bd71815-bat-oc2-res", BD_ISR_NAME(bat_oc2_res)),
> +		BDIRQ("bd71815-bat-oc2-det", BD_ISR_NAME(bat_oc2)),
> +		BDIRQ("bd71815-bat-oc3-res", BD_ISR_NAME(bat_oc3_res)),
> +		BDIRQ("bd71815-bat-oc3-det", BD_ISR_NAME(bat_oc3)),
> +		BDIRQ("bd71815-temp-bat-low-res", BD_ISR_NAME(temp_bat_low_res)),
> +		BDIRQ("bd71815-temp-bat-low-det", BD_ISR_NAME(temp_bat_low)),
> +		BDIRQ("bd71815-temp-bat-hi-res", BD_ISR_NAME(temp_bat_hi_res)),
> +		BDIRQ("bd71815-temp-bat-hi-det", BD_ISR_NAME(temp_bat_hi)),
> +		/*
> +		 * TODO: add rest of the IRQs and re-check the handling.
> +		 * Check the bd71815-bat-cc-mon1, bd71815-bat-cc-mon3,
> +		 * bd71815-bat-low-res, bd71815-bat-low-det,
> +		 * bd71815-bat-hi-res, bd71815-bat-hi-det.
> +		 */
> +	};
> +	static const struct bd7182x_irq_res bd71828_irqs[] =3D {
> +		BDIRQ("bd71828-chg-done", bd718x7_chg_done),
> +		BDIRQ("bd71828-pwr-dcin-in", bd7182x_dcin_detected),
> +		BDIRQ("bd71828-pwr-dcin-out", bd7182x_dcin_removed),
> +		BDIRQ("bd71828-vbat-normal", bd71828_vbat_low_res),
> +		BDIRQ("bd71828-vbat-low", bd71828_vbat_low_det),
> +		BDIRQ("bd71828-btemp-hi", bd71828_temp_bat_hi_det),
> +		BDIRQ("bd71828-btemp-cool", bd71828_temp_bat_hi_res),
> +		BDIRQ("bd71828-btemp-lo", bd71828_temp_bat_low_det),
> +		BDIRQ("bd71828-btemp-warm", bd71828_temp_bat_low_res),
> +		BDIRQ("bd71828-temp-hi", bd71828_temp_vf_det),
> +		BDIRQ("bd71828-temp-norm", bd71828_temp_vf_res),
> +		BDIRQ("bd71828-temp-125-over", bd71828_temp_vf125_det),
> +		BDIRQ("bd71828-temp-125-under", bd71828_temp_vf125_res),
> +	};
> +	int num_irqs;
> +	const struct bd7182x_irq_res *irqs;
> +
> +	switch (pwr->chip_type) {
> +	case ROHM_CHIP_TYPE_BD71828:
> +		irqs =3D &bd71828_irqs[0];
> +		num_irqs =3D ARRAY_SIZE(bd71828_irqs);
> +		break;
> +	case ROHM_CHIP_TYPE_BD71815:
> +		irqs =3D &bd71815_irqs[0];
> +		num_irqs =3D ARRAY_SIZE(bd71815_irqs);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	for (i =3D 0; i < num_irqs; i++) {
> +		irq =3D platform_get_irq_byname(pdev, irqs[i].name);
> +
> +		ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						irqs[i].handler, 0,
> +						irqs[i].name, pwr);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +#define RSENS_DEFAULT_30MOHM 30000 /* 30 mOhm in uOhms*/
> +
> +static int bd7182x_get_rsens(struct bd71828_power *pwr)
> +{
> +	u64 tmp =3D RSENS_CURR;
> +	int rsens_ohm =3D RSENS_DEFAULT_30MOHM;
> +	struct fwnode_handle *node =3D NULL;
> +
> +	if (pwr->dev->parent)
> +		node =3D dev_fwnode(pwr->dev->parent);
> +
> +	if (node) {
> +		int ret;
> +		u32 rs;
> +
> +		ret =3D fwnode_property_read_u32(node,
> +					       "rohm,charger-sense-resistor-micro-ohms",
> +					       &rs);
> +		if (ret) {
> +			if (ret =3D=3D -EINVAL) {
> +				rs =3D RSENS_DEFAULT_30MOHM;
> +			} else {
> +				dev_err(pwr->dev, "Bad RSENS dt property\n");
> +				return ret;
> +			}
> +		}
> +		if (!rs) {
> +			dev_err(pwr->dev, "Bad RSENS value\n");
> +			return -EINVAL;
> +		}
> +
> +		rsens_ohm =3D (int)rs;
> +	}
> +
> +	/* Reg val to uA */
> +	do_div(tmp, rsens_ohm);
> +
> +	pwr->curr_factor =3D tmp;
> +	pwr->rsens =3D rsens_ohm;
> +	dev_dbg(pwr->dev, "Setting rsens to %u micro ohm\n", pwr->rsens);
> +	dev_dbg(pwr->dev, "Setting curr-factor to %u\n", pwr->curr_factor);
> +
> +	return 0;
> +}
> +
> +static int bd71828_power_probe(struct platform_device *pdev)
> +{
> +	struct bd71828_power *pwr;
> +	struct power_supply_config ac_cfg =3D {};
> +	struct power_supply_config bat_cfg =3D {};
> +	int ret;
> +	struct regmap *regmap;
> +
> +	regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap) {
> +		dev_err(&pdev->dev, "No parent regmap\n");
> +		return -EINVAL;
> +	}
> +
> +	pwr =3D devm_kzalloc(&pdev->dev, sizeof(*pwr), GFP_KERNEL);
> +	if (!pwr)
> +		return -ENOMEM;
> +
> +	pwr->regmap =3D regmap;
> +	pwr->dev =3D &pdev->dev;
> +	pwr->chip_type =3D platform_get_device_id(pdev)->driver_data;
> +
> +	switch (pwr->chip_type) {
> +	case ROHM_CHIP_TYPE_BD71828:
> +		pwr->bat_inserted =3D bd71828_bat_inserted;
> +		pwr->get_temp =3D bd71828_get_temp;
> +		pwr->regs =3D &pwr_regs_bd71828;
> +		break;
> +	case ROHM_CHIP_TYPE_BD71815:
> +		pwr->bat_inserted =3D bd71815_bat_inserted;
> +		pwr->get_temp =3D bd71815_get_temp;
> +		pwr->regs =3D &pwr_regs_bd71815;
> +		break;
> +	default:
> +		dev_err(pwr->dev, "Unknown PMIC\n");
> +		return -EINVAL;
> +	}
> +
> +	ret =3D bd7182x_get_rsens(pwr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "sense resistor missing\n");
> +
> +	dev_set_drvdata(&pdev->dev, pwr);
> +	bd71828_init_hardware(pwr);
> +
> +	bat_cfg.drv_data	=3D pwr;
> +	bat_cfg.fwnode		=3D dev_fwnode(&pdev->dev);
> +
> +	ac_cfg.supplied_to	=3D bd71828_ac_supplied_to;
> +	ac_cfg.num_supplicants	=3D ARRAY_SIZE(bd71828_ac_supplied_to);
> +	ac_cfg.drv_data		=3D pwr;
> +
> +	pwr->ac =3D devm_power_supply_register(&pdev->dev, &bd71828_ac_desc,
> +					     &ac_cfg);
> +	if (IS_ERR(pwr->ac))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->ac),
> +				     "failed to register ac\n");
> +
> +	pwr->bat =3D devm_power_supply_register(&pdev->dev, &bd71828_bat_desc,
> +					      &bat_cfg);
> +	if (IS_ERR(pwr->bat))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pwr->bat),
> +				     "failed to register bat\n");
> +
> +	ret =3D bd7182x_get_irqs(pdev, pwr);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "failed to request IRQs");
> +
> +	/* Configure wakeup capable */
> +	device_set_wakeup_capable(pwr->dev, 1);
> +	device_set_wakeup_enable(pwr->dev, 1);
> +
> +	return 0;
> +}
> +
> +static const struct platform_device_id bd71828_charger_id[] =3D {
> +	{ "bd71815-power", ROHM_CHIP_TYPE_BD71815 },
> +	{ "bd71828-power", ROHM_CHIP_TYPE_BD71828 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(platform, bd71828_charger_id);
> +
> +static struct platform_driver bd71828_power_driver =3D {
> +	.driver =3D {
> +		.name =3D "bd718xx-power",
> +	},
> +	.probe =3D bd71828_power_probe,
> +	.id_table =3D bd71828_charger_id,
> +};
> +
> +module_platform_driver(bd71828_power_driver);
> +
> +MODULE_AUTHOR("Cong Pham <cpham2403@gmail.com>");
> +MODULE_DESCRIPTION("ROHM BD718(15/28/78) PMIC Battery Charger driver");
> +MODULE_LICENSE("GPL");
>=20
> --=20
> 2.39.5
>=20

--d2xdwud5lf64kpph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJoOIACgkQ2O7X88g7
+pomohAAhurZZJzTUt6mQPiDxKfPma68k9aeLzihidQpTTg6r8PpRpfhQoOv9WIK
ilyHRC9cr0KhH2v9HMDpkoqgj7kNyPG1UDA0KEoSWH3Rqa5t5d2GdgDwqBIgk9qe
aKv2vy7+JWGQlD3X4XWtg7RnPOFWIp6IrbCtwjAvTAAuJg4PtPHLl70Xskg9CGNp
xRZtRjSMFsqyNK58yJm3FKD2hsbKV/JbTsBdmemkRyDE6i4/33wen9tA0uY2kVHt
OtbFgdgrfxGfTGxUfrT/bf7VMJPx3gagOFdyIkmOf/9faK+8jweO+juJDIVS544E
m2Heo6sUEyHedxOo04uIdhDI08IuqCEAubMQmVl+u/huQ1wPYzivhacZ17jNbnTa
2vN/8GOqhScJhxiOB+8sHfDJU3k/EZdYRJSkUdymPsrPGZukdG3xcsOvkyy50SC+
V3Izg4cr6oFlVUg2/5AEVzMv0AXbUIRWeQeWqqO2ITGTHjA2iG9+rPbnjy8LNEJA
/wj5dp7y2u+qwt6qgWTztl+DSmicvJe1lB+nZq348qtH+87GqvOJDNeGBUfTQidA
12FN7/k2KKoZEGXE3XC+xGYvBuNlTneaTCU3wfvljPX3L7yEQ/riBTypoS4FQKD6
a4q24hYhVgB3meH4Ksv5A3Px/R/zdHSATQlzsMgCRRxhNUp3Dmg=
=XYwz
-----END PGP SIGNATURE-----

--d2xdwud5lf64kpph--

