Return-Path: <linux-pm+bounces-34740-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20074B59E5E
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 18:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF9F6486291
	for <lists+linux-pm@lfdr.de>; Tue, 16 Sep 2025 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA3630171B;
	Tue, 16 Sep 2025 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="kBuER/fK"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D623016FB;
	Tue, 16 Sep 2025 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758041494; cv=pass; b=bagjpgmxNf4HnDcwFfvu+aVGwlXsHQfcvnEUYusGJ7MQ46Go3V6Kgh/K9RUB74paxTy8nIATZlAPr1xVRpqN0O/ypYr7hOkjiaqQ9ZXMByjeeyazbszXGTptP0xNuTZCtMcDce1wTmrGiKhpektfRiZgpwDzcsdzVBBhSemikW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758041494; c=relaxed/simple;
	bh=aNcgnIqMlV2nLkN6hap+rk24qyY06m9MOU2lWa0W9jQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2OJrgEUjrHAR+runGojP0spg63F0BY5pFfW+wipm8u7EiQq5F/YfTquAK7vhmzimaq035o5YwlbHoqQ9k9KNUzVcJKueE5udgV+YyMGuUkB6dIep4UOSxvRW5JUO1kiXhvKqr1HwoxmB93yAvPuMLtt2si3C7Ww1AbjpEyk8Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=kBuER/fK; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758041482; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EkPea2vbbeyMTyJndl2PIYXgijcTzDGl0ocFWDEK42cj1z7fStUAvg3Uwi3qPiDFXnNBvgMNHINAS03OQJ4t7eQ9zltX6B8fSx5F/7y/Wqo1HDozScGzSjSIYOU9BdOfBaN5NYOm9lbFPaSWXDc80iVVwEmgNYzWIHOiG4gYbvw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758041482; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=upcDOhCT1maEJJBWxFuPLB5Q6P1kiM+yC2KebKXeNKw=; 
	b=iBQ+Ee9x4Vc0x9m4S3r9jSHMAXGs2vuvfJddGBXr62u6GEt8yK6fQH2FzXv2f3axI2KyHiO5CJbujsgWntl/4gMxOuG1Ch4HCH9Ycu3VkfdQ02aNjvhk6iaIU1vP8tiINavw81GnLNSu0Z1ympZ5XIOMWDj++S9+elq4NkLYg3U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758041482;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=upcDOhCT1maEJJBWxFuPLB5Q6P1kiM+yC2KebKXeNKw=;
	b=kBuER/fKRneqMxTE1Nd5c1JZyAtCkU1WvuIULbr3cEE+wNjntvc8g8B3cQR6U+Mu
	+kYy51kqQFWWQn3d0quUF1UtxP2Ura3es/jjV2PiB3RU1muo7IH3/QFx33frk/oq7wH
	qOOtrGvVnWBYfqlrB+dU7PLGVQTHCNhtbvl6f4FE=
Received: by mx.zohomail.com with SMTPS id 1758041478934468.0563315756556;
	Tue, 16 Sep 2025 09:51:18 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 4063C180733; Tue, 16 Sep 2025 18:51:09 +0200 (CEST)
Date: Tue, 16 Sep 2025 18:51:09 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, =?utf-8?B?QW5kcsOp?= Draszik <andre.draszik@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] power: supply: add support for MAX77759 fuel gauge
Message-ID: <or662kpry67je6cgwzttitsswbcfqwe33oqarq5zuq5ovj4elx@uysebfqkerq3>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
 <20250915-b4-gs101_max77759_fg-v6-1-31d08581500f@uclouvain.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vlmosdcyddltczxg"
Content-Disposition: inline
In-Reply-To: <20250915-b4-gs101_max77759_fg-v6-1-31d08581500f@uclouvain.be>
X-Zoho-Virus-Status: 1
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-1.4.3/258.4.7
X-ZohoMailClient: External


--vlmosdcyddltczxg
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 1/2] power: supply: add support for MAX77759 fuel gauge
MIME-Version: 1.0

Hi,

On Mon, Sep 15, 2025 at 12:14:10PM +0200, Thomas Antoine via B4 Relay wrote:
> From: Thomas Antoine <t.antoine@uclouvain.be>
>=20
> The Maxim MAX77759 is a PMIC used in gs101-oriole and gs101-raven
> (Google Pixel 6 and 6 Pro). It contains a fuel gauge on a separate
> I2C address. Add basic support for this fuel gauge. The driver is
> based on the driver for the MAX17201 and MAX17205 which also uses
> the MAX M5 fuel gauge. There is a lot in common between the two
> devices with some key differences. The main one is the lack of nvmem
> in the fuel gauge of the MAX77759.
>=20
> The initialization of the chip is very basic and mostly hardcoded.
> Loading the model of the fuel gauge is not implemented here.
> Values are extracted from available devices.
>=20
> On both gs101-oriole and gs101-raven, the same EEPROM as for the
> battery id is used to backup some of the state of the fuel gauge.
> Use a standard nvmem binding to access this data. The CRC8 is
> computed to allow to go from linux to a stock android without
> apparent data corruption. If other devices using the MAX77759 are
> found/created, a similar nvmem layout should be made or the driver
> should be extended to support those devices.
>=20
> The current, capacity, temperature and charge have all been tested.
> The charge full design and capacity equal the ones seen on android,
> the ratio between average charge and average current does predict
> pretty accurately the time to empty under a constant workload and
> temperature is coherent with the dynamic state of the device.
>=20
> Health is not enabled as it always reports overheating. The time to
> empty is wrong by about a factor 2. The voltage reporting is
> correct when using VCELL (which reports the lowest voltage of all
> cells) when considering that the device is connected to a single
> cell. It could be enabled by either confirming that the device is
> connected to a single cell or finding an alternative reporting mean.
>=20
> Modifications have been made to it since but the regmap was
> originally proposed by Andr=E9 Draszik in
>=20
> Link: https://lore.kernel.org/all/d1bade77b5281c1de6b2ddcb4dbbd033e455a11=
6.camel@linaro.org/
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/power/supply/Kconfig            |  14 +
>  drivers/power/supply/Makefile           |   1 +
>  drivers/power/supply/max77759_battery.c | 652 ++++++++++++++++++++++++++=
++++++
>  3 files changed, 667 insertions(+)
>=20
> diff --git a/drivers/power/supply/Kconfig b/drivers/power/supply/Kconfig
> index 72f3b2b4d346df354475274b1c6b4ed047fdca1d..2d024fd3a45644d9f6d4e7c48=
ea98f4efe0c443d 100644
> --- a/drivers/power/supply/Kconfig
> +++ b/drivers/power/supply/Kconfig
> @@ -473,6 +473,20 @@ config BATTERY_MAX1721X
>  	  Say Y here to enable support for the MAX17211/MAX17215 standalone
>  	  battery gas-gauge.
> =20
> +config BATTERY_MAX77759
> +	tristate "Maxim Integrated MAX77759 Fuel Gauge"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  Say yes to enable support for the Fuel gauge of the Maxim Integrated
> +	  MAX77759. It is a companion Power Management IC for USB Type-C
> +	  applications with Battery Charger, Fuel Gauge, temperature sensors,
> +	  USB Type-C Port Controller (TCPC), NVMEM, and additional GPIO
> +	  interfaces.
> +
> +	  To compile this driver as module, choose M here: the
> +	  module will be called max77759_fg.
> +
>  config BATTERY_TWL4030_MADC
>  	tristate "TWL4030 MADC battery driver"
>  	depends on TWL4030_MADC
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 51e37e8bdeb35a5ee7a74cd86d4def9d900a542d..b96b5ce9c846c57ce71c23ede=
949d0e89c06a65a 100644
> --- a/drivers/power/supply/Makefile
> +++ b/drivers/power/supply/Makefile
> @@ -59,6 +59,7 @@ obj-$(CONFIG_BATTERY_MAX17040)	+=3D max17040_battery.o
>  obj-$(CONFIG_BATTERY_MAX17042)	+=3D max17042_battery.o
>  obj-$(CONFIG_BATTERY_MAX1720X)	+=3D max1720x_battery.o
>  obj-$(CONFIG_BATTERY_MAX1721X)	+=3D max1721x_battery.o
> +obj-$(CONFIG_BATTERY_MAX77759)	+=3D max77759_battery.o
>  obj-$(CONFIG_BATTERY_RT5033)	+=3D rt5033_battery.o
>  obj-$(CONFIG_CHARGER_RT5033)	+=3D rt5033_charger.o
>  obj-$(CONFIG_CHARGER_RT9455)	+=3D rt9455_charger.o
> diff --git a/drivers/power/supply/max77759_battery.c b/drivers/power/supp=
ly/max77759_battery.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..a49980241f8951705237d1f9c=
4328d0ff516c344
> --- /dev/null
> +++ b/drivers/power/supply/max77759_battery.c
> @@ -0,0 +1,652 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Fuel gauge driver for Maxim 777759
> + *
> + * based on max1720x_battery.c
> + *
> + * Copyright (C) 2024 Liebherr-Electronics and Drives GmbH
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/crc8.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/power_supply.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/unaligned.h>
> +
> +#define MAX77759_FG_CRC8_POLYNOMIAL  0x07
> +DECLARE_CRC8_TABLE(max77759_fg_crc8_table);
> +
> +#define MAX77759_FG_STATUS		0x00	/* Status */
> +#define MAX77759_FG_STATUS_POR		BIT(1)	/* Power-On Reset */
> +#define MAX77759_FG_STATUS_BAT_ABSENT	BIT(3)	/* Battery absent */
> +#define MAX77759_FG_REPCAP		0x05	/* Average capacity */
> +#define MAX77759_FG_REPSOC		0x06	/* Percentage of charge */
> +#define MAX77759_FG_TEMP		0x08	/* Temperature */
> +#define MAX77759_FG_CURRENT		0x0A	/* Actual current */
> +#define MAX77759_FG_AVG_CURRENT		0x0B	/* Average current */
> +#define MAX77759_FG_FULL_CAP		0x10	/* Calculated full capacity */
> +#define MAX77759_FG_QR_TABLE00		0x12
> +#define MAX77759_FG_FULLSOCTHR		0x13
> +#define MAX77759_FG_CYCLES		0x17
> +#define MAX77759_FG_DESIGN_CAP		0x18	/* Design capacity */
> +#define MAX77759_FG_CONFIG		0x1D
> +#define MAX77759_FG_ICHGTERM		0x1E
> +#define MAX77759_FG_DEV_NAME		0x21	/* Device name */
> +#define MAX77759_FG_DEV_NAME_TYPE_MASK	GENMASK(15, 9)
> +#define MAX77759_FG_DEV_NAME_TYPE	0x31
> +#define MAX77759_FG_QR_TABLE10		0x22
> +#define MAX77759_FG_FULLCAPNOM		0x23	/* Nominal full capacity */
> +#define MAX77759_FG_LEARNCFG		0x28
> +#define MAX77759_FG_FILTERCFG		0x29
> +#define MAX77759_FG_RELAXCFG		0x2A
> +#define MAX77759_FG_MISCCFG		0x2B
> +#define MAX77759_FG_TGAIN		0x2C
> +#define MAX77759_FG_TOFF		0x2D
> +#define MAX77759_FG_CGAIN		0x2E
> +#define MAX77759_FG_QR_TABLE20		0x32
> +#define MAX77759_FG_FULLCAPREP		0x35	/* Reported full capacity */
> +#define MAX77759_FG_RCOMP0		0x38
> +#define MAX77759_FG_TEMPCO		0x39	/* Temperature Compensation*/
> +#define MAX77759_FG_TASKPERIOD		0x3C
> +#define MAX77759_FG_TASKPERIOD_175MS	0x1680
> +#define MAX77759_FG_TASKPERIOD_351MS	0x2D00
> +#define MAX77759_FG_QR_TABLE30		0x42
> +#define MAX77759_FG_DQACC		0x45
> +#define MAX77759_FG_DPACC		0x46
> +#define MAX77759_FG_VFSOC0		0x48
> +#define MAX77759_FG_CONVGCFG		0x49
> +#define MAX77759_FG_COMMAND		0x60
> +#define MAX77759_FG_COMMAND_LOCK_CONF	0x0000	/* Lock extra config */
> +#define MAX77759_FG_COMMAND_UNLOCK_CONF	0x0080	/* Unlock extra config */
> +#define MAX77759_FG_CV_MIXCAP		0xB6
> +#define MAX77759_FG_CV_HALFTIME		0xB7
> +#define MAX77759_FG_CURVE		0xB9
> +#define MAX77759_FG_CONFIG2		0xBB
> +#define MAX77759_FG_CONFIG2_OCVQEN	BIT(4)
> +#define MAX77759_FG_CONFIG2_LDMDL	BIT(5)	/* Load model */
> +#define MAX77759_FG_CONFIG2_DSOCEN	BIT(7)
> +#define MAX77759_FG_VFSOC		0xFF
> +
> +static const char *const max77759_fg_manufacturer =3D "Maxim Integrated";
> +static const char *const max77759_fg_model =3D "MAX77759";
> +
> +struct max77759_fg_device_info {
> +	struct regmap *regmap;
> +	int rsense;
> +};
> +
> +/*
> + * Registers 0x80 up to 0xaf which contain the model for the fuel gauge
> + * algorithm are locked. They can be unlocked by writing 0x59 to 0x62
> + * and 0xc4 to 0x63. They should be enabled in the regmap if the driver
> + * is extended to manage the model.
> + */
> +static const struct regmap_range max77759_fg_registers[] =3D {
> +	regmap_reg_range(0x00, 0x4f),
> +	regmap_reg_range(0x60, 0x60),
> +	regmap_reg_range(0xb0, 0xbf),
> +	regmap_reg_range(0xd0, 0xd0),
> +	regmap_reg_range(0xdc, 0xdf),
> +	regmap_reg_range(0xfb, 0xfb),
> +	regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_range max77759_fg_ro_registers[] =3D {
> +	regmap_reg_range(0x3d, 0x3d),
> +	regmap_reg_range(0xfb, 0xfb),
> +	regmap_reg_range(0xff, 0xff),
> +};
> +
> +static const struct regmap_access_table max77759_fg_write_table =3D {
> +	.no_ranges =3D max77759_fg_ro_registers,
> +	.n_no_ranges =3D ARRAY_SIZE(max77759_fg_ro_registers),
> +};
> +
> +static const struct regmap_access_table max77759_fg_rd_table =3D {
> +	.yes_ranges =3D max77759_fg_registers,
> +	.n_yes_ranges =3D ARRAY_SIZE(max77759_fg_registers),
> +};
> +
> +static const struct regmap_config max77759_fg_regmap_cfg =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 16,
> +	.max_register =3D 0xff,
> +	.wr_table =3D &max77759_fg_write_table,
> +	.rd_table =3D &max77759_fg_rd_table,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.cache_type =3D REGCACHE_NONE,
> +};
> +
> +static const enum power_supply_property max77759_fg_battery_props[] =3D {
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_AVG,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_CURRENT_AVG,
> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_MANUFACTURER,
> +};
> +
> +struct max77759_fg_state_save {
> +	u16 rcomp0;
> +	u16 tempco;
> +	u16 fullcaprep;
> +	u16 cycles;
> +	u16 fullcapnom;
> +	u16 qrtable00;
> +	u16 qrtable10;
> +	u16 qrtable20;
> +	u16 qrtable30;
> +	u16 mixcap;
> +	u16 halftime;
> +	u8 crc;
> +} __packed;
> +
> +/* Convert regs value to power_supply units */
> +
> +static int max77759_fg_percent_to_ps(unsigned int reg)
> +{
> +	return reg / 256;	/* in percent from 0 to 100 */
> +}
> +
> +static int max77759_fg_capacity_to_ps(unsigned int reg,
> +				      struct max77759_fg_device_info *info)
> +{
> +	return reg * (500000 / info->rsense);	/* in uAh */
> +}
> +
> +static int max77759_fg_capacity_lsb(struct max77759_fg_device_info *info,
> +				    unsigned int *lsb)
> +{
> +	unsigned int reg_task_period;
> +	int ret;
> +
> +	ret =3D regmap_read(info->regmap, MAX77759_FG_TASKPERIOD,
> +			  &reg_task_period);
> +	if (ret < 0)
> +		return ret;
> +
> +	switch (reg_task_period) {
> +	case MAX77759_FG_TASKPERIOD_175MS:
> +		*lsb =3D 1;
> +		break;
> +	case MAX77759_FG_TASKPERIOD_351MS:
> +		*lsb =3D 2;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Current and temperature is signed values, so unsigned regs
> + * value must be converted to signed type
> + */
> +
> +static int max77759_fg_temperature_to_ps(unsigned int reg)
> +{
> +	int val =3D (int16_t)reg;
> +
> +	return val * 10 / 256; /* in tenths of deg. C */
> +}
> +
> +/*
> + * Calculating current registers resolution:
> + *
> + * RSense stored in 10^-5 Ohm, so measurement voltage must be
> + * in 10^-11 Volts for get current in uA.
> + * 16 bit current reg fullscale +/-51.2mV is 102400 uV.
> + * So: 102400 / 65535 * 10^5 =3D 156252
> + */
> +static int max77759_fg_current_to_voltage(unsigned int reg)
> +{
> +	int val =3D (int16_t)reg;
> +
> +	return val * 156252;
> +}
> +
> +static int max77759_fg_battery_get_property(struct power_supply *psy,
> +					    enum power_supply_property psp,
> +					    union power_supply_propval *val)
> +{
> +	struct max77759_fg_device_info *info =3D power_supply_get_drvdata(psy);
> +	unsigned int reg_val;
> +	int ret =3D 0;
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_PRESENT:
> +		/*
> +		 * POWER_SUPPLY_PROP_PRESENT will always readable via
> +		 * sysfs interface. Value return 0 if battery not
> +		 * present or inaccesable via I2C.
> +		 */
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_STATUS, &reg_val);
> +		if (ret < 0) {
> +			val->intval =3D 0;
> +			return 0;
> +		}
> +
> +		val->intval =3D !FIELD_GET(MAX77759_FG_STATUS_BAT_ABSENT, reg_val);
> +		break;
> +	case POWER_SUPPLY_PROP_CAPACITY:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_REPSOC, &reg_val);
> +		val->intval =3D max77759_fg_percent_to_ps(reg_val);
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_DESIGN_CAP, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D max77759_fg_capacity_to_ps(reg_val, info);
> +		ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +		val->intval *=3D reg_val;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_AVG:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_REPCAP, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D max77759_fg_capacity_to_ps(reg_val, info);
> +		ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +		val->intval *=3D reg_val;
> +		break;
> +	case POWER_SUPPLY_PROP_TEMP:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_TEMP, &reg_val);
> +		val->intval =3D max77759_fg_temperature_to_ps(reg_val);
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_NOW:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_CURRENT, &reg_val);
> +		val->intval =3D max77759_fg_current_to_voltage(reg_val) / info->rsense;
> +		break;
> +	case POWER_SUPPLY_PROP_CURRENT_AVG:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_AVG_CURRENT, &reg_val);
> +		val->intval =3D max77759_fg_current_to_voltage(reg_val) / info->rsense;
> +		break;
> +	case POWER_SUPPLY_PROP_CHARGE_FULL:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_FULL_CAP, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		val->intval =3D max77759_fg_capacity_to_ps(reg_val, info);
> +		ret =3D max77759_fg_capacity_lsb(info, &reg_val);
> +		val->intval *=3D reg_val;
> +		break;
> +	case POWER_SUPPLY_PROP_MODEL_NAME:
> +		ret =3D regmap_read(info->regmap, MAX77759_FG_DEV_NAME, &reg_val);
> +		if (ret < 0)
> +			return ret;
> +
> +		reg_val =3D FIELD_GET(MAX77759_FG_DEV_NAME_TYPE_MASK, reg_val);
> +		if (reg_val =3D=3D MAX77759_FG_DEV_NAME_TYPE)
> +			val->strval =3D max77759_fg_model;
> +		else
> +			return -ENODEV;
> +		break;
> +	case POWER_SUPPLY_PROP_MANUFACTURER:
> +		val->strval =3D max77759_fg_manufacturer;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int max77759_fg_init(struct device *dev,
> +			    struct max77759_fg_device_info *info,
> +			    struct power_supply *bat_psy)
> +{
> +	struct max77759_fg_state_save *state;
> +	struct power_supply_battery_info *bat_info;
> +	struct nvmem_cell *cell;
> +	unsigned int val;
> +	int ret;
> +	size_t len;
> +
> +	ret =3D power_supply_get_battery_info(bat_psy, &bat_info);
> +	if (ret)
> +		return ret;
> +
> +	cell =3D devm_nvmem_cell_get(dev, "fg_state");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	state =3D (struct max77759_fg_state_save *)nvmem_cell_read(cell, &len);
> +	if (IS_ERR(state))
> +		return PTR_ERR(state);
> +	if (len !=3D sizeof(struct max77759_fg_state_save)) {
> +		ret =3D -EINVAL;
> +		goto err_init;
> +	}
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_REPCAP, 0x0000);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_RELAXCFG, 0x0839);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_COMMAND,
> +			   MAX77759_FG_COMMAND_UNLOCK_CONF);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_read(info->regmap, MAX77759_FG_VFSOC, &val);
> +	if (ret < 0)
> +		goto err_init;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_VFSOC0, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_LEARNCFG, 0x260E);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONFIG, 0x4217);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	val =3D MAX77759_FG_CONFIG2_DSOCEN | MAX77759_FG_CONFIG2_OCVQEN;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONFIG2, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FULLSOCTHR, 0x5F00);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FULLCAPREP,
> +			   state->fullcaprep);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	//Use an LSB of 2 because TASKPERIOD will be set to 351MS
> +	val =3D bat_info->charge_full_design_uah * (info->rsense / 100) / 10000;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_DESIGN_CAP, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_DPACC, 0x0C80);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_DQACC,
> +			   state->fullcapnom >> 4);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_STATUS,
> +			   MAX77759_FG_STATUS_POR);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FULLCAPNOM,
> +			   state->fullcapnom);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE00,
> +			   state->qrtable00);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE10,
> +			   state->qrtable10);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE20,
> +			   state->qrtable20);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_QR_TABLE30,
> +			   state->qrtable30);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_RCOMP0, state->rcomp0);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TEMPCO, state->tempco);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TASKPERIOD,
> +			   MAX77759_FG_TASKPERIOD_351MS);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_ICHGTERM,
> +			   bat_info->charge_term_current_ua *
> +			   info->rsense / 15625);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TGAIN, 0xED51);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_TOFF, 0x1EBA);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_MISCCFG, 0x3870);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CV_MIXCAP, state->mixcap=
);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CV_HALFTIME,
> +			   state->halftime);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONVGCFG, 0x2241);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_COMMAND,
> +			   MAX77759_FG_COMMAND_LOCK_CONF);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CURVE, 0x0014);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_FILTERCFG, 0xc623);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CGAIN, 0x0400);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	val =3D MAX77759_FG_CONFIG2_DSOCEN | MAX77759_FG_CONFIG2_OCVQEN;
> +	val |=3D MAX77759_FG_CONFIG2_LDMDL;
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CONFIG2, val);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_STATUS, 0x0000);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	ret =3D regmap_write(info->regmap, MAX77759_FG_CYCLES, state->cycles);
> +	if (ret < 0)
> +		goto err_init;
> +
> +	kfree(state);
> +	return 0;
> +
> +err_init:
> +	kfree(state);
> +	return ret;
> +}
> +
> +static const struct power_supply_desc max77759_fg_bat_desc =3D {
> +	.name =3D "max77759-fg",
> +	.type =3D POWER_SUPPLY_TYPE_BATTERY,
> +	.properties =3D max77759_fg_battery_props,
> +	.num_properties =3D ARRAY_SIZE(max77759_fg_battery_props),
> +	.get_property =3D max77759_fg_battery_get_property,
> +};
> +
> +static int max77759_fg_backup_fg_state(struct device *dev,
> +				       struct regmap *regmap)
> +{
> +	struct max77759_fg_state_save state;
> +	struct nvmem_cell *cell;
> +	int val;
> +	int ret;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_RCOMP0, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.rcomp0 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_TEMPCO, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.tempco =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_FULLCAPREP, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.fullcaprep =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_CYCLES, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.cycles =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_FULLCAPNOM, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.fullcapnom =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE00, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable00 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE10, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable10 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE20, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable20 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_QR_TABLE30, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.qrtable30 =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_CV_MIXCAP, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.mixcap =3D (u16)val;
> +
> +	ret =3D regmap_read(regmap, MAX77759_FG_CV_HALFTIME, &val);
> +	if (ret < 0)
> +		return ret;
> +	state.halftime =3D (u16)val;
> +
> +	state.crc =3D crc8(max77759_fg_crc8_table, (u8 *)&state,
> +			 sizeof(state) - sizeof(state.crc), CRC8_INIT_VALUE);
> +
> +	cell =3D devm_nvmem_cell_get(dev, "fg_state");
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +	ret =3D nvmem_cell_write(cell, &state, sizeof(state));
> +	if (ret < 0)
> +		dev_err(dev, "Failed to write fg_state to NVMEM: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void max77759_fg_remove(struct i2c_client *client)
> +{
> +	struct max77759_fg_device_info *info =3D i2c_get_clientdata(client);
> +
> +	max77759_fg_backup_fg_state(&client->dev, info->regmap);
> +}
> +
> +static int max77759_fg_probe(struct i2c_client *client)
> +{
> +	struct power_supply_config psy_cfg =3D {};
> +	struct device *dev =3D &client->dev;
> +	struct max77759_fg_device_info *info;
> +	struct power_supply *bat;
> +	int ret, val;
> +
> +	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	psy_cfg.drv_data =3D info;
> +	psy_cfg.fwnode =3D dev_fwnode(dev);
> +
> +	crc8_populate_msb(max77759_fg_crc8_table, MAX77759_FG_CRC8_POLYNOMIAL);
> +
> +	i2c_set_clientdata(client, info);
> +
> +	info->regmap =3D devm_regmap_init_i2c(client, &max77759_fg_regmap_cfg);
> +	if (IS_ERR(info->regmap))
> +		return dev_err_probe(dev, PTR_ERR(info->regmap),
> +				     "regmap initialization failed\n");
> +
> +	ret =3D device_property_read_u32(dev, "shunt-resistor-micro-ohms", &val=
);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to read RSense from devicetree\n");
> +	info->rsense =3D val / 10;
> +
> +	bat =3D devm_power_supply_register(dev, &max77759_fg_bat_desc, &psy_cfg=
);
> +	if (IS_ERR(bat))
> +		return dev_err_probe(dev, PTR_ERR(bat),
> +				     "Failed to register power supply\n");
> +
> +	ret =3D max77759_fg_init(dev, info, bat);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize chip\n");
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id max77759_fg_of_match[] =3D {
> +	{ .compatible =3D "maxim,max77759-fg" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, max77759_fg_of_match);
> +
> +static struct i2c_driver max77759_fg_i2c_driver =3D {
> +	.driver =3D {
> +		.name =3D "max77759_fg",
> +		.of_match_table =3D max77759_fg_of_match,
> +	},
> +	.probe =3D max77759_fg_probe,
> +	.remove =3D max77759_fg_remove,
> +};
> +module_i2c_driver(max77759_fg_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Thomas Antoine <t.antoine@uclouvain.be>");
> +MODULE_DESCRIPTION("Maxim MAX77759 Fuel Gauge IC driver");
>=20
> --=20
> 2.51.0
>=20
>=20

--vlmosdcyddltczxg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmjJlXkACgkQ2O7X88g7
+po7/Q//SaoLKwxdfMv2PpRPnRJw2M391Wh/K2N4U7uCyAvU995IbEb3iISG84TJ
rbQkyGcQ1vmZKS5kbTjHNFMShuXWwKxhJ9/l4x5B2RVNGxxFsqBccI5twwsv94TQ
hSqCb8JMXbeRQLKRZyMoXpC+XgzrgaZOBz4qj3jNQjgWkQWj83gc1CBU1r8e2cpQ
nrW2v2ewlvLLyWLh2/+D9bzvuqBbmQ/GPg9/f1G9LUMydbrlsPOuiSWLSNOx7ugi
p5mYCXP3n40Ker+pxq9stO7osjiAm/PjBeu5irMdXoz2dvs6WlET7BpeRcDmEupm
MX6eo31RE4xod9qUdQMGs6XE/Vy/zl+pavwxG79eP8T7t8AoLwkcUOotvJGVJdmm
yKT7U5OJfV61gRwX51sGJiT8MifxEQfOAf7qxOXn5mOSWpDk8dVqUDEGWI7MrEO0
RAOY2QzgGXZd9HXDtoq/uGt6fI1nmNchyfwBpuAT78Lk+iuQbTNK6F0lQuItbH4W
K0e63vSojDJ7Np61tbefkSXvl9QKN/h1m05eXmEV1nv5J/buQ/e180t37bY631gI
zJtCWl+hRLcwg10Is/jTotUeMJ7MZyPqlHvLnBAaRJMzyXnB4MKujxG6Z444Xz0/
SVVOJS2vrYWoNvG0Wyhfa+TmZ8K9DAJ8dfZJdQpQHzl4COSBB0Q=
=/9lV
-----END PGP SIGNATURE-----

--vlmosdcyddltczxg--

